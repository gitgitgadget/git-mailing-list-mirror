Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7806B202AC
	for <e@80x24.org>; Sat,  8 Jul 2017 23:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbdGHXJa (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 19:09:30 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33848 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdGHXJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 19:09:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id c24so9422242pfe.1
        for <git@vger.kernel.org>; Sat, 08 Jul 2017 16:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RPfwrW1y+ZuoJ//tC+ShEJFHffy/G0DAGm6Knxt+Nm0=;
        b=Sr4diqUzzGrG8Tfh3cE00bpxNc1uRzLxlbDgVntSnu7HwnxxTBpslWEFP2iNuIg5oN
         gUNaDZkdtjt2uRRqbmrPlFVa0gxIh3acAPweVp1NZI5YuXCXuznNlEp2vBqS+l8tRKyr
         XZXSp9F41pL+B5Puh3dDmxuM08ic3T4ccSVekWuNeLWoA0N4zm7898WPBrLa3uy1G9a/
         dy2YJ2T/UOK2Byfb/8BV0FU/gUgBHHQa1KiWxgW9Kyf5SoITbgOsJX3SdXMVUgAPBwfJ
         ImWkmKCbrpNKyf6vV3tsTAPKyNYrmQDaqvvVtizc0makZXGWI7IU9ykY/htE+fsZVfEj
         9lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RPfwrW1y+ZuoJ//tC+ShEJFHffy/G0DAGm6Knxt+Nm0=;
        b=oV6Zf/XPBHSIBqCX9p6mDqAeP3wVOpDPI18yjvH8x5Dcty1SDZD3GtGGgwjSpL3Nif
         l2kZ5m1583TvZ1PK6+OAv2EMgyudp70ADROUvJppp75iy1Sy3Va4FKO97Yd8kOz/eTpP
         cD5w+u/FwgfdFVPKuBGTlG/5xX7c98SPvLTMcTr1XWyvT1lCtYdSWiXPshaQmxePVQTv
         mQKHn7NBUl3ee/vvKm7FnCunDuTmf28bcrjbKMDAkK8lRnGzGeKxEu2fuMdFJinnxPyW
         VYtyd755IO3Z/v7SauipIwpW1S5fEQxW3BzpzwRptlvoCW/J8PGGg3xpRbJo4HGi3L7u
         jz9w==
X-Gm-Message-State: AIVw110jfx4LmIzMLVzHy53FBVPJ8fX1Qw/8d/VW/5LSz5yz/AcglFm5
        ljrMMkRrquEa9A==
X-Received: by 10.99.121.133 with SMTP id u127mr8042744pgc.31.1499555368852;
        Sat, 08 Jul 2017 16:09:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:49f8:bc86:d515:b7dd])
        by smtp.gmail.com with ESMTPSA id p77sm13161994pfd.62.2017.07.08.16.09.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 08 Jul 2017 16:09:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     astian <astian@eclipso.at>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] Doc/config.txt: fix documentation for smtpEncryption
References: <20170708203413.16442-1-astian@eclipso.at>
        <20170708203413.16442-5-astian@eclipso.at>
Date:   Sat, 08 Jul 2017 16:09:27 -0700
In-Reply-To: <20170708203413.16442-5-astian@eclipso.at> (astian@eclipso.at's
        message of "Sat, 8 Jul 2017 20:34:13 +0000")
Message-ID: <xmqqbmoua5lk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

astian <astian@eclipso.at> writes:

> Stop saying that smtpEncryption (a configuration variable used by
> git-send-email) is not usable in "sendemail.<identity>" subsections,
> because that's false.

Hmph, does anybody know when this stopped being true, or was it
incorrect from the very beginning?

>
> Signed-off-by: astian <astian@eclipso.at>
> ---
>  Documentation/config.txt | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d5c9c4cab..f40758c31 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2899,10 +2899,6 @@ sendemail.identity::
>  	values in the 'sendemail' section. The default identity is
>  	the value of `sendemail.identity`.
>  
> -sendemail.smtpEncryption::
> -	See linkgit:git-send-email[1] for description.  Note that this
> -	setting is not subject to the 'identity' mechanism.
> -
>  sendemail.smtpssl (deprecated)::
>  	Deprecated alias for 'sendemail.smtpEncryption = ssl'.
>  
> @@ -2933,6 +2929,7 @@ sendemail.suppresscc::
>  sendemail.suppressFrom::
>  sendemail.to::
>  sendemail.smtpDomain::
> +sendemail.smtpEncryption::
>  sendemail.smtpServer::
>  sendemail.smtpServerPort::
>  sendemail.smtpServerOption::
