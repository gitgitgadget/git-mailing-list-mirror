Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BDAF20954
	for <e@80x24.org>; Wed, 22 Nov 2017 17:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbdKVRlE convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 22 Nov 2017 12:41:04 -0500
Received: from marot.dh.bytemark.co.uk ([212.110.172.17]:38920 "EHLO
        marot.bettens.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbdKVRlD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 12:41:03 -0500
Received: by marot.bettens.info (Sendmail new on BidulOS, from userid 65534)
        id DCEF757058D; Wed, 22 Nov 2017 18:41:02 +0100 (CET)
Received: from machaut.bettens.info (dslgva4378.worldcom.ch [83.172.215.76])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by marot.bettens.info (Sendmail new on BidulOS) with ESMTPS id 78617570589;
        Wed, 22 Nov 2017 18:41:00 +0100 (CET)
Received: from [192.168.1.9] (dslgva4378.worldcom.ch [83.172.215.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by machaut.bettens.info (Postfix) with ESMTPSA id F0F751C9D;
        Wed, 22 Nov 2017 18:40:58 +0100 (CET)
Date:   Wed, 22 Nov 2017 18:40:58 +0100
From:   Louis Bettens <louis@bettens.info>
Subject: Re: [PATCH] fix french translation
To:     git@vger.kernel.org
Cc:     jn.avila@free.fr, worldhello.net@gmail.com
Message-Id: <1511372458.854.7@machaut.bettens.info>
In-Reply-To: <20171122172440.15106-2-louis@bettens.info>
References: <20171122172440.15106-1-louis@bettens.info>
        <20171122172440.15106-2-louis@bettens.info>
X-Mailer: geary/0.12-dev
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also it seems this is the only .po that has this particular quirk:

$ grep -c "worktree prune" po/*.po
po/bg.po:2
po/ca.po:2
po/de.po:2
po/es.po:2
po/fr.po:3  # outlier
po/is.po:0
po/it.po:0
po/ko.po:2
po/pt_PT.po:2
po/ru.po:2
po/sv.po:2
po/vi.po:2
po/zh_CN.po:2

zero lines -> translation missing, OK
two lines -> msgid and msgstr, OK
three lines -> something wrong. In this case, the present issue.


Le mer 22 nov 2017 à 18:24, Louis Bettens <louis@bettens.info> a 
écrit :
> Signed-off-by: Louis Bettens <louis@bettens.info>
> ---
>  po/fr.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/po/fr.po b/po/fr.po
> index 4deae3318..a12a2ae37 100644
> --- a/po/fr.po
> +++ b/po/fr.po
> @@ -14331,7 +14331,7 @@ msgstr "git worktree add [<options>] <chemin> 
> [<branche>]"
> 
>  #: builtin/worktree.c:17
>  msgid "git worktree list [<options>]"
> -msgstr "git worktree prune [<options>]"
> +msgstr "git worktree list [<options>]"
> 
>  #: builtin/worktree.c:18
>  msgid "git worktree lock [<options>] <path>"
> --
> 2.15.0
> 

