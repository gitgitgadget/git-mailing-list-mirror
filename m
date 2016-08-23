Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E184F1F859
	for <e@80x24.org>; Tue, 23 Aug 2016 06:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757028AbcHWGVm (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 02:21:42 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:35006 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756943AbcHWGV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 02:21:28 -0400
Received: by mail-yb0-f170.google.com with SMTP id z10so47427005ybh.2
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 23:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TwUzJ9HSB6S7MuynZvyQFrEIIyrFk4adkHB/Ct2quSo=;
        b=noYgUljJNux4S3uzaXWXz5leJfn1GtA5vjGS1yWmy9MHNcQ5I7AI9icm4oyC2TxGPQ
         jdDHlx28hglJ+sCp1xFNbbjqzcxE5mVYcm+a2lvzFuShzSzq8XNXdpqSPXfC0Wkfrt3t
         A67wbyeWmYg9VuoJTZQjcWmDuqU6X1mDukBKtHgFuvsvbHGgnphrZLsflR1S0LVB5713
         yEmNK8+luu0VVTvQt5H2sWV7DQvWplfeqOQeQB4zSom74PFxv/VMRVawybGs0a7hdtHf
         3Ih9GokfVE7hjpNM8qXoXSJYoSBRexYakb3Yrn8LcRA9JGRyOvLswgTT4yq+rSpxT/89
         VTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TwUzJ9HSB6S7MuynZvyQFrEIIyrFk4adkHB/Ct2quSo=;
        b=O9bZGamLiYjL617iamrxncPyfOCMNLp3y7gPfatFxOLWnyKs9tmCNxRt7y7Pe1tGao
         A4ZgJQxTr6VsIccETuutSCLYT8uSlW97pi2Ncm5fUO7ri1D/geV48iD3dtkBXbfPEdmK
         kJKyNhnJFuzQwOe27TF28Sjq4+X+2R/diD2LzKu/YJMrVfb/+DcOcQhY+UYduiIzFnG/
         Pzi1qU2UHtIjpRT5bLosE8DWpLSHPyQBK7lS4BbdqHTAECDsjS8xaC3WcSS/5YT4Tb3w
         PlTnOplxwx1KTGdKznouUnBLCH8iGCe4WOyCn6I2R3dRjdh5DKk9kKEg9yECICwYVVAj
         bOpw==
X-Gm-Message-State: AEkoouvohBo9m+axityvJ+BNbMnswPJ99h4sm+xNFcpKKG6Fhvm1DZxaJVb7O+CALPVwG5cA0ZScQwV7TcY+AA==
X-Received: by 10.37.119.134 with SMTP id s128mr20181944ybc.58.1471933288113;
 Mon, 22 Aug 2016 23:21:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Mon, 22 Aug 2016 23:21:06 -0700 (PDT)
In-Reply-To: <CAGZ79kbPhsWChrHKkjabZK0ZHZSPVE7VnwiTrxqrMPSzsmjHVg@mail.gmail.com>
References: <20160822234344.22797-1-jacob.e.keller@intel.com>
 <20160822234344.22797-2-jacob.e.keller@intel.com> <CAGZ79kbPhsWChrHKkjabZK0ZHZSPVE7VnwiTrxqrMPSzsmjHVg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 22 Aug 2016 23:21:06 -0700
Message-ID: <CA+P7+xo6Vtxh9RuKAGh-vaK+rqitt-VMK-2KBTeh=4zoDB2s9Q@mail.gmail.com>
Subject: Re: [PATCH v10 1/9] Git 2.10-rc1
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2016 at 5:28 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Aug 22, 2016 at 4:43 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>
> Bad rebase?

Ya not sure what happened here. Will find out tomorrow.

Thanks,
Jake
