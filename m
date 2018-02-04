Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23CF01F576
	for <e@80x24.org>; Sun,  4 Feb 2018 11:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeBDLbp (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 06:31:45 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:39236 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeBDLbn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 06:31:43 -0500
Received: by mail-io0-f178.google.com with SMTP id b198so27439328iof.6
        for <git@vger.kernel.org>; Sun, 04 Feb 2018 03:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ehAduVq//esLmTtKIjo2Yt2kHXFa/1VhRGVMfUMYJEY=;
        b=WoZlvaeAvCfNjB3lXID+L7lqvMnfbzIi9Y7HtmslvWwMtG0el+Fqhe3StyRcfVNvFn
         XnehK+Sr17pka3wamUvY6KtRHYiLCuPaXM+TxGC7JpX+Etxz03KfZMAMk64ARnLXKoXz
         BzWBN1bGD++jOxSd2MfgIr7oPZRjWE6YeAU5d2lRmuvroQDsIkA0zawaN05XIIteWaIQ
         iwypxy+X72wipOYDyWzicIHHA+IMK+w7fNaOHe0FeBAlBMIKuM+ciPF5nmiZsYqtgnrP
         H3NdfCXU+NP0/VE5AsU9z9F5nTyHrp88syIITxeqtGsd9gKEYeXfjM9NKP6iiWEAAQqv
         H/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ehAduVq//esLmTtKIjo2Yt2kHXFa/1VhRGVMfUMYJEY=;
        b=NODhQyAIgFmFpjPLPY9lJpdgOlHk3CBjQuGrfwFs0xNfgue0cDpbSIORdPkDigaFGN
         it8lJJxUdnol4IkAV3iJYTtQicFhkgUk/UTopa8dBx+auwEqxBpt/5KDRGFa6tDx8Qvr
         y9WVAAj1E6/h7pusyBiG+o03lxMUfRW5TFrzmyz65V8TP0yz8PJ+XkOHDilXiP69KJq9
         Yx8a/+fmAA651V6NKuVV4C6cLKpWc+vqYf5pR+2DsalCj2tgfJy0EiAjg/EPeaDLedkf
         SdjP7Or+yaCwBFZRKA1VaTgCrKeDMKXjFCoT9ot2Ze1RuDWIaa0lR6HdhJcifQdpgt3H
         UXeQ==
X-Gm-Message-State: AKwxytfCqvzPBYgt7jnZ0V9fK8m2P5ERvgualf8+OrCcJ4LuoJk8oC6g
        DpNq6AB7TyrK5sDmiaqcax0=
X-Google-Smtp-Source: AH8x2261nEVZa8G22+izDW0zHDBP40LMh9gtxqSlIwiXnCIeZETGOXChslYCv/P2hJsXca+psgEthQ==
X-Received: by 10.107.70.4 with SMTP id t4mr46349751ioa.234.1517743902440;
        Sun, 04 Feb 2018 03:31:42 -0800 (PST)
Received: from flurp.local (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id n89sm3739034ioe.46.2018.02.04.03.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Feb 2018 03:31:41 -0800 (PST)
Date:   Sun, 4 Feb 2018 06:31:35 -0500
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Chen Jingpiao <chenjingpiao@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH] commit: add a commit.signOff config variable
Message-ID: <20180204113135.GA28130@flurp.local>
References: <20180204020318.4363-1-chenjingpiao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180204020318.4363-1-chenjingpiao@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 04, 2018 at 10:03:18AM +0800, Chen Jingpiao wrote:
> Add the commit.signOff configuration variable to use the -s or --signoff
> option of git commit by default.
> 
> Signed-off-by: Chen Jingpiao <chenjingpiao@gmail.com>
> ---
> 
> Though we can configure signoff using format.signOff variable. Someone like to
> add Signed-off-by line by the committer.

This commentary explains why this feature is desirable, therefore it
would be a good idea to include this in the commit message itself.

> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> @@ -505,6 +505,75 @@ Myfooter: x" &&
> +test_expect_success "commit.signoff=true and --signoff omitted" '
> +	echo 7 >positive &&
> +	git add positive &&
> +	git -c commit.signoff=true commit -m "thank you" &&
> +	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +	(
> +		echo thank you
> +		echo
> +		git var GIT_COMMITTER_IDENT |
> +		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
> +	) >expected &&
> +	test_cmp expected actual
> +'

The bodies of these test are quite noisy, doing a lot of work that isn't
really necessary, which makes it difficult to figure out what is really
being tested. Other tests in this script already check that the commit
message is properly formatted when Signed-off-by: is inserted so you
don't need to repeat all that boilerplate here.

Instead, you are interested only in whether or not Signed-off-by: has
been added to the message. For that purpose, you can use a simple 'grep'
expression.

The amount of copy/paste code in these six tests is also unfortunate.
Rather than merely repeating the same code over and over, you could
instead parameterize the test. For instance, you could run all six tests
via a simple for-loop:

--- >8 ---
for cfg in true false
do
    for opt in '' --signoff --no-signoff
    do
        case "$opt:$cfg" in
        --signoff:*|:true) expect= ;;
        --no-signoff:*|:false) expect=! ;;
        esac
        test_expect_success "commit.signoff=$cfg & ${opt:---signoff omitted}" '
            git -c commit.signoff=$cfg commit --allow-empty -m x $opt &&
            eval "$expect git log -1 --format=%B | grep ^Signed-off-by:"
        '
    done
done
--- >8 ---

A final consideration is that tests run slowly on Windows, and although
it's nice to be thorough by testing all six combinations, you can
probably exercise the new code sufficiently by instead testing just two
combinations. For instance, instead of all six combinations, test just
these two:

--- >8 ---
test_expect_success 'commit.signoff=true & --signoff omitted' '
    git -c commit.signoff=true commit --allow-empty -m x &&
    git log -1 --format=%B | grep ^Signed-off-by:
'

test_expect_success 'commit.signoff=true & --no-signoff' '
    git -c commit.signoff=true commit --allow-empty -m x --no-signoff &&
    ! git log -1 --format=%B | grep ^Signed-off-by:
'
--- >8 ---

> +test_expect_success "commit.signoff=true and --signoff" '
> +	echo 8 >positive &&
> +	git add positive &&
> +	git -c commit.signoff=true commit --signoff -m "thank you" &&
> +	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +	(
> +		echo thank you
> +		echo
> +		git var GIT_COMMITTER_IDENT |
> +		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
> +	) >expected &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success "commit.signoff=true and --no-signoff" '
> +	echo 9 >positive &&
> +	git add positive &&
> +	git -c commit.signoff=true commit --no-signoff -m "thank you" &&
> +	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +	echo thank you >expected &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success "commit.signoff=false and --signoff omitted" '
> +	echo 10 >positive &&
> +	git add positive &&
> +	git -c commit.signoff=false commit -m "thank you" &&
> +	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +	echo thank you >expected &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success "commit.signoff=false and --signoff" '
> +	echo 11 >positive &&
> +	git add positive &&
> +	git -c commit.signoff=false commit --signoff -m "thank you" &&
> +	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +	(
> +		echo thank you
> +		echo
> +		git var GIT_COMMITTER_IDENT |
> +		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
> +	) >expected &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success "commit.signoff=false and --no-signoff" '
> +	echo 12 >positive &&
> +	git add positive &&
> +	git -c commit.signoff=false commit --no-signoff -m "thank you" &&
> +	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +	echo thank you >expected &&
> +	test_cmp expected actual
> +'
