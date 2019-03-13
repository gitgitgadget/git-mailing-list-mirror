Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A8D20248
	for <e@80x24.org>; Wed, 13 Mar 2019 02:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfCMCKM (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 22:10:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45565 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfCMCKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 22:10:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id h99so197611wrh.12
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 19:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AiknE6fqhw9c6n2oLaTtoec4eKiGH2y98rRSeD53Wys=;
        b=OlPN6XG1oZBmxI07BtlrUb30dZdcrrajLeD9vH1fWaCTVoZYBsFZ5Uh7Q/hukKnmr9
         lieSRmmKnE1ZSqt0J+xvRNfvaa7eUSQa5SCaKH7YSVQgs4ips6IPKkBorMm/SynTQHxd
         87Zmcm6F6BvnwfxtalPpgfKsSoGw7EvcEszjNzTnA4jvyrlZIh9lH7yB1Zepttx0RvuQ
         i9Mqxy3NFYOntkni4AM2jxVoT28gbbr/zFfveA9rNmUclwQoREWoSVGt1jhGU+y/C555
         SfpZqrlV7ZlMvtmL+KasZgr0tik8KOMwnxnh/BYD0u8BNgjEsQyOp1sovFHJ2VAdJyDT
         A4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AiknE6fqhw9c6n2oLaTtoec4eKiGH2y98rRSeD53Wys=;
        b=eYQ+5s9WEpOfWq/LMr40bkzMXqZN2EUaE3+jFUW6OxmJCRwt5RedJtpoalUIISMmC9
         1WkZZ3qJYHR2EuY9tE4FornCRKj8eYi8bK4pQ7cH+D62snBrmlnkPqRDZvxOIVhdUuSZ
         9dZCLAcKEKcenbZiumrNC+2w3kjd7C6wRavXyFmKZaKo1bptRmfuHt9j4U7vnUCJNxDL
         0Hvh58VhRLxdOIK/5AbZg3/v9GUNRqXJFHrhIFv9aL134R47fKnmhhC/rlBMdT9BA4Zd
         VdRBRnBHKiiOc/cxUobk/6sqh7+IIzMLzPCjyC+/sKphvuT6FNZIfDRu1xGs6vC5cnt1
         v8oQ==
X-Gm-Message-State: APjAAAUrdejZDqAOcdh5eDJfPnx9a63Zue5l+J0Qou4P6ObcEGGlhMCT
        zLv5J1xHULSubJ/vMbILWP8=
X-Google-Smtp-Source: APXvYqxbr4X+fBHKHevOQ3ggMrG6xY4zLBUxcl6NLM15Vd7X/1HJ+rcMcr3Rt6iA1Fijbiik+ccWrA==
X-Received: by 2002:adf:dc10:: with SMTP id t16mr26583531wri.40.1552443009738;
        Tue, 12 Mar 2019 19:10:09 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id f191sm256110wmg.41.2019.03.12.19.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 19:10:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk, s-beyer@gmx.net,
        Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] t4150: remove unused variable
References: <36ad743f-8429-a6ff-7fad-15e5dba01483@gmail.com>
Date:   Wed, 13 Mar 2019 11:10:08 +0900
In-Reply-To: <36ad743f-8429-a6ff-7fad-15e5dba01483@gmail.com> (Andrei Rybak's
        message of "Tue, 12 Mar 2019 15:38:04 +0100")
Message-ID: <xmqqa7hzfrsv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> In commit 735285b403 ("am: fix signoff when other trailers are present",
> 2017-08-08) tests using variable $signoff were rewritten and it is no
> longer used, so just remove it from the test setup.
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  t/t4150-am.sh | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Looks good; thanks.

>
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 55b577d919..3f7f750cc8 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -77,14 +77,12 @@ test_expect_success 'setup: messages' '
>  
>  	printf "Subject: " >subject-prefix &&
>  
> -	cat - subject-prefix msg-without-scissors-line >msg-with-scissors-line <<-\EOF &&
> +	cat - subject-prefix msg-without-scissors-line >msg-with-scissors-line <<-\EOF
>  	This line should not be included in the commit message with --scissors enabled.
>  
>  	 - - >8 - - remove everything above this line - - >8 - -
>  
>  	EOF
> -
> -	signoff="Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
>  '
>  
>  test_expect_success setup '
