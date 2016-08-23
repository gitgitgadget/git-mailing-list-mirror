Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240841F859
	for <e@80x24.org>; Tue, 23 Aug 2016 00:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756595AbcHWA2Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 20:28:25 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:38693 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756229AbcHWA2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 20:28:24 -0400
Received: by mail-it0-f45.google.com with SMTP id n128so109265143ith.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 17:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TEmAjRwAVY1P+41IAIEZBo7+kwTKXCUUNSbgmxIXYu8=;
        b=drRP6u0bNEgANv73GFTIUe8PZtSjFR5Kvk7gVis2GspblStEARNOE9kQw0oepIbTIG
         X/B+cEpTpaq0qoK7fKY3FYXkeh6INF3qMTa/09TKxnRKoC3kRsqMgTn8oZa/5c/EGpTt
         URr5j3+vkI94RiT0VBTqjo0MZW7pW7rW3h6MimsYS82tDP/xfeTxMipbuG5E2oDATeGo
         AyvRxPSr2EKuIS485JhDEReBPKbhsTMPNLW2zUxoEtdqNFSMp8sQMQfZt+TNj8tt1g2J
         kdVoa5W0s+cmaa9jSqeqpTeCa2yEZIdXd29eSLVYb/YMTL+nVnG4/NiCEN3xJBH242ZO
         DKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TEmAjRwAVY1P+41IAIEZBo7+kwTKXCUUNSbgmxIXYu8=;
        b=E66f/0wHJwCIhMaovvWxzkpBN1pC9i3uJu9Nn62vgzRfk/9y6FKC75KSFD406OGmdO
         OCiK/TKxmF1QJ9is75VhAKhJrzxmUHneZUdrnVMIJy0r+1rubq3Mdcuo1MjZlSiSYTPU
         /TGSXMciAxcIl/vtlDZ7e2RMhA3voYLnVuop0gsPoxx3Dzy9b67mGmMjf9xd7N7AvWRn
         5w3TmrWQbWiSn4NsS3DG60DlT9vwcY2FELbr4SUY+lCswNeACdZx7kmdRPNZWm2Wy6GY
         n1x1/r31e0Kv2d+OsCgxApJ/dnnlLFblg4GgAO5V3re3hlDb10kDwymH0kAmFBT6dYh4
         HUig==
X-Gm-Message-State: AEkoout08uDc/DOPPN0hHZ4je39unHAiKrQhjkPR91SRg8T9nIDd2LrUXwTiN/MfJh2DEQaoZnGm9Isnmod1px+F
X-Received: by 10.36.127.7 with SMTP id r7mr23440481itc.49.1471912103898; Mon,
 22 Aug 2016 17:28:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 22 Aug 2016 17:28:23 -0700 (PDT)
In-Reply-To: <20160822234344.22797-2-jacob.e.keller@intel.com>
References: <20160822234344.22797-1-jacob.e.keller@intel.com> <20160822234344.22797-2-jacob.e.keller@intel.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 22 Aug 2016 17:28:23 -0700
Message-ID: <CAGZ79kbPhsWChrHKkjabZK0ZHZSPVE7VnwiTrxqrMPSzsmjHVg@mail.gmail.com>
Subject: Re: [PATCH v10 1/9] Git 2.10-rc1
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2016 at 4:43 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:

Bad rebase?
