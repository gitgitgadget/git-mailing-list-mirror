Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4BE20A40
	for <e@80x24.org>; Thu, 30 Nov 2017 02:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbdK3CEv (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 21:04:51 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:38785 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbdK3CEu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 21:04:50 -0500
Received: by mail-io0-f194.google.com with SMTP id d14so5864989ioc.5
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 18:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uevIV+1eCRj5F1qM8MI5HQM1hl6qxppYAEJJOpbBOQQ=;
        b=orNxo8AiWGu/cWaGTKUQPDjN40FH+vzm0CN+X3SgzLU4MJoc4vTQhrFdVocxTtK92x
         CaJ9Nvl9ciaAnhugwoF0rwzDVrVtzfbYuToN99VXIbmdWlVjrptL57KoHDK406vWFBSW
         4MihMsPCv/hBAA7muKS43h+ZDHETrrv5Xj0e8xpJkxXwp+4X0t+oQ7BnuXgojRDCXRny
         hjRAjWp8g8pfg0CFzcdmQYt7XqhxtUl+iiExQ8MzqSV0Jqe3rR4KvyEZZ2hgJkCLV+OR
         5fnV02p1bU/Gjnnzo/ESDiLgtUwWTC8NUNluT2OAkukZ5zKEOsNNY+nUEIi89QlkWksp
         t+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uevIV+1eCRj5F1qM8MI5HQM1hl6qxppYAEJJOpbBOQQ=;
        b=imEXmCUgFfW+UQ8LB/56uapNZXHa56DUgd87Y5D6J9d3Fm2SuFuxLUdvFZtk7F3ytb
         3cdwJV+Zsa2kKqVSyDjIu0770v77A+CD2r+TVsO7VNx1QOj7V2xla4imqtAiylsog1jB
         Bc2qG/nfigf3zAyUqTIb90yATZpDZSIIf405qFmQXOMY1maZqf/PVUuiDTZ/ODtn8QcK
         81vwSmnBn+zbEHKQuxu/Oc8/hwI7qnQekfgkJDaOrVQYy1xineTR+3tNOumOul3z/Dfj
         gHEmkRdD/+1mc9R4R5Lxf1mkJqM6oR2z7eoDMtcB8qUn0KBVtUGQvOLGrT4R3EMBH6lf
         LhJw==
X-Gm-Message-State: AJaThX5GXeTCIusIjBiJBla/7ADoQiNSMvTIDOUG5Y9J7Y5mwn5wAtIf
        hca5EKfsqHepoKhu8HoYUiIYN28E
X-Google-Smtp-Source: AGs4zMa54/g9LGNozN5Olzn98Wq7sHPzAz5qePABmj5s0X3QMAzdE0c/WBqvLC2xCya92qH2jjPrUw==
X-Received: by 10.107.15.202 with SMTP id 71mr6054712iop.146.1512007488356;
        Wed, 29 Nov 2017 18:04:48 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g100sm1399590iod.84.2017.11.29.18.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 18:04:47 -0800 (PST)
Date:   Wed, 29 Nov 2017 18:04:45 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Doron Behar <doron.behar@gmail.com>
Cc:     git@vger.kernel.org,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: Re: imap-send with gmail: curl_easy_perform() failed: URL using
 bad/illegal format or missing URL
Message-ID: <20171130020445.GF15098@aiede.mtv.corp.google.com>
References: <20171129171301.l3coiflkfyy533yz@NUC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129171301.l3coiflkfyy533yz@NUC.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: Nicolas)
Hi,

Doron Behar wrote:

> I'm trying to send a patch with the command `git imap-send`, I used the
> examples in the manual page as the main reference for my configuration:
>
> ```
> [imap]
> 	folder = "[Gmail]/Drafts"
> 	host = imaps://imap.gmail.com
> 	user = doron.behar@gmail.com
> 	port = 993
> 	sslverify = false
> ```
>
> This is my `cat patch.out | git imap-send` output:
>
> ```
> Password for 'imaps://doron.behar@gmail.com@imap.gmail.com':
> sending 3 messages
> curl_easy_perform() failed: URL using bad/illegal format or missing URL
> ```

Thanks for reporting this.  I suspect this is related to
v2.15.0-rc0~63^2 (imap-send: use curl by default when possible,
2017-09-14) --- e.g. perhaps our custom IMAP code was doing some
escaping on the username that libcurl does not do.

"man git imap-send" says this is a recommended configuration, so I
don't think it's a configuration error.

What platform are you on?  What version of libcurl are you using?

In libcurl::lib/easy.c I am also seeing

    if(mcode)
      return CURLE_URL_MALFORMAT; /* TODO: return a proper error! */

which looks suspicious.

Nicolas, am I on the right track?

Thanks,
Jonathan

> The URI doesn't seem OK to me, I tried using `imap.user = doron.behar` and the
> URI was `imaps://doron.behar@imap.gmail.com` but that ended up with the same
> error as in the previous case.
>
> I would love to get some help here, a Google Search didn't help as well.
>
> Thanks.
