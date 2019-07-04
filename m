Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050F31F461
	for <e@80x24.org>; Thu,  4 Jul 2019 09:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfGDJ4X (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 05:56:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38172 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfGDJ4W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 05:56:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so429883wro.5
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=g8BwA/TzAM7s5BDcflNgYH+7KttPvJU1Lx4dkkxMdLI=;
        b=VmuZkRLCcH6eKTbvYoxnyZJDEzsj1HRA5tKqtR27SxCl2t41g/FzMkZgoy+Xqpcbis
         opmO3Q+VUSOFUe38SjCLUWSVKM+YnyTK3ZuZwpVvwpf+ux8Kx2Nje56CS+/Fwi12P5kG
         oK7Pn6+/TtKI+YaJMwp3RJC/9A14UKEIRkMJqYoo2LfP17Lu7oWsxKGlyRrKBR3Q8Bzi
         NifqwX89pKUM4KL2teR7s08j5NsReCs3mK2eiqT3z2V3T6mwgeta9ROTAq1qrd2eScgM
         TmrH645PgDQg9Sfc0yUW68pZAX4Q1oxIZeP9PGdq0Fgxtm3ZzSObLOqNFBaDCtJKNN6Z
         Glxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g8BwA/TzAM7s5BDcflNgYH+7KttPvJU1Lx4dkkxMdLI=;
        b=Q/Sg6j8aP0Aclwyz7jNuWazNKZdOiAB5Kqeeh1RN6U27aC4txCTzkIi/MflLzupAQY
         qxJ76RdMsN/lAOANzkUr27ROx+wNTAXHDRaYem8aEkGEBZ6AnWKB6V0quMlCQKrz7YkL
         a5dGRsaTri19X04f+7i83rM4OA3Og44hu1KSEL7fyrvK/Y4PTCOQ7ZXwck3SYIlwd7gb
         C1A6op7ROw640yhi58MFqq5n2gjjJVzr/9x0PvMZX+GL+OZBGk0iw/RDDjOZlyV7ZWUc
         qYbVjcxLqOi7zJGjCSRqcKcrCOFcrWsHe8efofTiJOQqo810nX68nsDa0TO7BWZzWd8l
         KBPg==
X-Gm-Message-State: APjAAAUZfAME3J6Drz7DJteSedZdznheW65zUzQTbfpqmicibjlnxyPi
        hVWyaser/XIKHvQ831PqQ6RxWxrc
X-Google-Smtp-Source: APXvYqw6dH41sHF+BHbQ2phrhQE90TLdIF2MKRpyH7C1tHewjlhQ9yekRRpJY79BMLF2r/c+948jIg==
X-Received: by 2002:adf:9d81:: with SMTP id p1mr34147494wre.294.1562234180682;
        Thu, 04 Jul 2019 02:56:20 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id l1sm3730829wmg.13.2019.07.04.02.56.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 02:56:20 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jul 2019, #01; Wed, 3)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9b0fa396-6aae-ff4b-afee-0310a4f601f9@gmail.com>
Date:   Thu, 4 Jul 2019 10:56:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/07/2019 23:28, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> The third batch of topics post 2.22 are now in 'master', and the tip
> of 'next' has been rewound.
> 
> You can find the changes described here in the integration branches
> of the repositories listed at
> 
>     http://git-blame.blogspot.com/p/git-public-repositories.html
> 
> --------------------------------------------------
> [New Topics]
> 
> * pw/rebase-progress-test-cleanup (2019-07-01) 1 commit
>  - t3420: remove progress lines before comparing output
>  (this branch uses sg/rebase-progress.)
> 
>  Test cleanup.
> 
>  Will merge to 'next'.

I've just posted an update to this which avoids the repeated printf calls

Best Wishes

Phillip
