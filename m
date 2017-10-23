Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7228A202A2
	for <e@80x24.org>; Mon, 23 Oct 2017 16:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbdJWQ1z (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 12:27:55 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:47282 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbdJWQ1y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 12:27:54 -0400
Received: by mail-wm0-f50.google.com with SMTP id t69so10669810wmt.2
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aynjfap6h/yAryiLGH2z/0UF12kOYqJtJHd2XZszRBs=;
        b=z8lqs98XnUkUCpzblyo00JaDqN6xVUGYRqE9ZGpwooN3WsnkjTcZhK1f1HYmiwDFbF
         9HPqxbTQbDPmND2L+8JfoqA1cCL6m4pymVp0wpxja1qsTg6x3SAiBWrWxmri91GaIkDm
         K8ArtLOGY9g/lXeybQ09dSU4In9ikDQab7zPRvzLdXFVkpSwQFNWcf9pSkT0kjHa0GTB
         FzCq73lIq2b+sxRIEaO53TuwiQr8mx6PyZj+S2GmgkqblnwytrHH17PCEXvawLxzyxIB
         DmQuAIGn+YpxaEd82BUkcrLnQRD/cM/7BmaW40e3yGqQGUtjTo/B77IZcRcMSY9FSkwq
         p3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aynjfap6h/yAryiLGH2z/0UF12kOYqJtJHd2XZszRBs=;
        b=SAoxlSeRv/4EXrDjSMKuSUwjnOn2XDSiedF8a/bSJSLamM20AhqH0jzQZPjYwmuYft
         y+fFDVT9EOT2eUmdWNp8DezOz7EcN70zb37X2agtaBAOH1/XCfyf76RU+fgQcgCCO+z/
         yPeNAL+Cj3dFolXd/Z1YhfgNABDpg5yGtdbghYEmfSRWuFYnNEiDk2gdrqv6bwANd5rw
         0GYBWU27j1PbGUgQk8iZFs9h3nN42Soq3Xi39+D9m4WQ2FjMarW9r/46D3uiOMY+abAH
         FX0854GLvBHjU3wIm1qXqshSF9XQG2291SIziSHLYUcGPODGpWr8YzQMcTlyBdUahqM9
         6PBg==
X-Gm-Message-State: AMCzsaWKAp1zgYSSozvxwUjV25oT392jhY/HNshmPz1Rpn+OLXesjGSG
        N6kbkBK+tkQ7gph7PXCXX2j696doRQ==
X-Google-Smtp-Source: ABhQp+StHFmcHaUrgqsOrkO3QTWu8Q/MG9TF/yP1qD/fVN0eyAFIMq8nIeaZKSpwYaxtlFzySw113Q==
X-Received: by 10.80.173.227 with SMTP id b32mr17881232edd.65.1508776072768;
        Mon, 23 Oct 2017 09:27:52 -0700 (PDT)
Received: from [192.168.1.80] ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id o55sm8128239edc.90.2017.10.23.09.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 09:27:51 -0700 (PDT)
Message-ID: <1508776071.2750.15.camel@kaarsemaker.net>
Subject: Re: git send-email does not work with Google anymore?!
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Date:   Mon, 23 Oct 2017 18:27:51 +0200
In-Reply-To: <EC14D46D-61AB-4531-AE20-8C2B3F6B5A2A@gmail.com>
References: <EC14D46D-61AB-4531-AE20-8C2B3F6B5A2A@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-10-05 at 12:52 +0200, Lars Schneider wrote:
> Hi,
> 
> I used to use the Google SMTP server to send my patches to the list with 
> the following config:

>8 ---

> Apparently that stopped working today. I get this error:
> 
>     (mbox) Adding cc: Lars Schneider <larsxschneider@gmail.com> from line 'From: Lars Schneider <larsxschneider@gmail.com>'
>     Password for 'smtp://larsxschneider@gmail.com@smtp.gmail.com:587':
>     5.7.14 <https://accounts.google.com/signin/continue?...token...
>     5.7.14 ...> Please log in via your web browser and
>     5.7.14 then try again.
>     5.7.14  Learn more at
>     5.7.14  https://support.google.com/mail/answer/78754 ... - gsmtp
> 
> Of couse I tried to log in via web browser etc. Does anyone else use 
> Google as SMTP server? If yes, does it work for you?

For 2fa-protected accounts, this seems to break quite often. I ended up
setting up a mail relay on my vps for this. If you want, you can use
git.seveas.net to send patches to the git mailing lists (doesn't work
for other recipients, I'm not quite stupid enough to run an open mail
relay...)

D.
