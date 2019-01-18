Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08541F453
	for <e@80x24.org>; Fri, 18 Jan 2019 18:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfARSQh (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 13:16:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35066 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfARSQh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 13:16:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so16220787wrb.2
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 10:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+9B8p8T232YjuVSNaLCBHqtiENesfx+ltfy4+RcshDo=;
        b=auecSs6s80jV5cF7/AL59oRfFmp3l437xeZzeXKRHeITTeFlk0p4rMVr4QqtNehiCN
         OW7pJiGjhQkprI4PbWY/QcgQV3vSXwbc0ZG5leNjKpcaP8JGjuVRNIwDirR6P6akHAqC
         cY2s6Am9DELUYVUB8/+tGxPvwFRmXP/r5VyXjKLBDJU33XnQ+qi6Ak90dKbBuMs6euPq
         X/V4spN8Wrj5l6AxxSoBSE54+usENW21UE332UgU4BDeTRvz8fcdJa+TlFaVvtXJD/10
         9De4ZcIygfznjQ9B5oL7Qsb7dHGiWglIKyz14MWPKI8b1wiZq2T9iph3iT0ohk6qXKwZ
         ruCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+9B8p8T232YjuVSNaLCBHqtiENesfx+ltfy4+RcshDo=;
        b=AfYiDH7gbHAOMOuLAZ585EXtdo4r3RF/Bl0g2WPCxNIUG/6531MlGDS04D5hv8pT0x
         IREUbOyntSAqxwtnldDDO1A7mIoRn8h9Hy4I3Rlx8bTbI/VFkvhLuBTmAsXGDycrqlyF
         kK81XwDk7B8FnUU4m1HCPDKixvPjXCoZCV9JD0IVVNwfFjkNOwVO9uSMzzemaOwks1pL
         cGsvYaOFNDtuiQ+1Vm4KQlsfUhW7+svWqQqBujBwgJhcWYOgQOBbE2nsQwidXK5lPsNH
         rrBdesNKFfIZ9xd2zcIO1oTv5T6ZEnEM2VMhIiP06v9BiNFzLS5tPVfCngaxzp8k8FaV
         xOnA==
X-Gm-Message-State: AJcUukf4M+JqhrlITTJY2Wcbc0BVIaSnc9uUH8HSKPNb4GotYmnieMA6
        8FhQ2HXtNQDSZyxJWtvcPGw=
X-Google-Smtp-Source: ALg8bN4HAMoWZiySWBN1bLQkuxTdSnH76Njz4wZGq+auPUgCWZL07bT+Vg62JE997AXoH1cDS/TMag==
X-Received: by 2002:adf:8484:: with SMTP id 4mr17531622wrg.249.1547835395124;
        Fri, 18 Jan 2019 10:16:35 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x15sm94877511wrs.27.2019.01.18.10.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 10:16:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, bwilliamseng@gmail.com,
        git <git@vger.kernel.org>, bwilliams.eng@gmail.com
Subject: Re: [PATCH] mailmap: update brandon williams's email address
References: <20181207205621.49961-1-bwilliams.eng@gmail.com>
        <20181207214013.GA73340@google.com>
        <CAGZ79kYrgpZDqAhg8c11V_qJTCzzw4-qrVN2z_Y_OAeCbWU6dQ@mail.gmail.com>
        <20181207222225.GC73340@google.com>
        <20190118165754.GA11350@sigill.intra.peff.net>
Date:   Fri, 18 Jan 2019 10:16:33 -0800
In-Reply-To: <20190118165754.GA11350@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 18 Jan 2019 11:57:54 -0500")
Message-ID: <xmqqa7jxltku.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I just had to cc Brandon and manually look up his email address, which
> made me wonder what ever happened to this patch. :)

d076ad13 ("Merge branch 'bw/mailmap'", 2019-01-14)

