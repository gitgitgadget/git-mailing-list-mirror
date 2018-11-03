Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E161F453
	for <e@80x24.org>; Sat,  3 Nov 2018 03:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeKCMsv (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 08:48:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34520 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeKCMsv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 08:48:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so3841610wre.1
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 20:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HaGXoO1ljWc2ZzPDtqCGei3aGqvwtSNDhg0D9T6fuoM=;
        b=Hf8D1sVoUHF9tR9fg34mn4+Rh8uBEstshne2g2/OzfRk3Il+VEAzQ7rarz7F/W9WIk
         NohfQ1fheMa3b2w3NlW1NElc1qtL7C1EXFyFEgu37b8y4qhxF6LEGX2OgDI4p2bTJTNG
         HnmzDKJlUw/9tyPpNN9QmakOJEG+AQ2jyo/1YEsFbZqMLnXtVbEMuWTZ/2bqKIAGWDNm
         xou802SPQr4FKNjBSPgBw+x8PObetdl6uNeJ5Z9c1WBPjOPypfWEWmfS1R1clsC7RcEI
         smlBwjvA/DcbmXQO5ZDk+QBiYmloofax9W4Tdw7fG1JFGVhuAGImI+o+6uftnCUtq+bW
         le4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HaGXoO1ljWc2ZzPDtqCGei3aGqvwtSNDhg0D9T6fuoM=;
        b=F2nJkyflghJbVZsrgbBacFe3PyE/x3ip7NzdXY7T8UEOERe3TLl6ukwqc5uNSpsh2l
         z1gTwwbbB7oVEWzx9K7txgGVz5VnrI9s0YOEpA8zGy0Gtn4kHtgex18pWV8F9lQEkERs
         H/iFGutUKBziM9xyiDT38LbTthIXHzPTfMnGRYryqALBgPWWKJeYpGMxRVq49XIfxFuG
         vjlpAs6Z61oKJL0+Aob6bm6V10lKqkdmEwLflgFfM4Qd7XJuI66iyQ4BKt+A5FGqEIGL
         ghQjDfKwELeBagdBtDtsNrM6Ud0WTGyfXvXDSnJahaCyr618Gw/1wMzR6PInI1vUP0t7
         viSA==
X-Gm-Message-State: AGRZ1gJ0e4uIReKr53vxPX87ouJcCZPXtzGnSJQilZiOhNRmpwZpUYpu
        vUO2Fv0D5jcp+U4OyuiwiLU=
X-Google-Smtp-Source: AJdET5fDMAYQo0dDjEcGiGMSlen/bOPShgIA53uhhZp3cYplpFJVil9xqB6oSxi53k6FqfjXlj0mPA==
X-Received: by 2002:adf:ead0:: with SMTP id o16-v6mr12976292wrn.287.1541216339935;
        Fri, 02 Nov 2018 20:38:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 109-v6sm18011824wrb.81.2018.11.02.20.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 20:38:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Friday, Nov 2)
References: <784741be-6045-12bb-75b9-0df6f4c612b7@gmail.com>
Date:   Sat, 03 Nov 2018 12:38:57 +0900
In-Reply-To: <784741be-6045-12bb-75b9-0df6f4c612b7@gmail.com> (Derrick
        Stolee's message of "Fri, 2 Nov 2018 22:16:48 -0400")
Message-ID: <xmqqva5en832.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Uncovered code in 'next' not in 'master'
> --------------------------------------------
>
> pretty.c
> 4de9394dcb 1264) if (c->signature_check.primary_key_fingerprint)
> 4de9394dcb 1265) strbuf_addstr(sb,
> c->signature_check.primary_key_fingerprint);
> 4de9394dcb 1266) break;

Perhaps a patch along this line can be appended to the
mg/gpg-fingerprint topic that ends at 4de9394d ("gpg-interface.c:
obtain primary key fingerprint as well", 2018-10-22) to cover this
entry in the report.  

I do not know how involved it would be to set up a new test case
that demonstrates a case where %GF and %GP are different, but if it
is very involved perhaps it is not worth adding such a case.

 t/t7510-signed-commit.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 19ccae2869..9ecafedcc4 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -176,8 +176,9 @@ test_expect_success GPG 'show good signature with custom format' '
 	13B6F51ECDDE430D
 	C O Mitter <committer@example.com>
 	73D758744BE721698EC54E8713B6F51ECDDE430D
+	73D758744BE721698EC54E8713B6F51ECDDE430D
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS%n%GF" sixth-signed >actual &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
 	test_cmp expect actual
 '
 
