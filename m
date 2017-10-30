Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E7BF2055E
	for <e@80x24.org>; Mon, 30 Oct 2017 10:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbdJ3KnG convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 30 Oct 2017 06:43:06 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:11532
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752096AbdJ3KnF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2017 06:43:05 -0400
X-IronPort-AV: E=Sophos;i="5.44,319,1505772000"; 
   d="scan'208";a="242810517"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 30 Oct 2017 11:43:04 +0100
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     git@vger.kernel.org, Kevin <kevin@ki-ai.org>
Subject: Re: [PATCH 1/4] remote-mediawiki: add namespace support
References: <20171029160857.29460-1-anarcat@debian.org>
        <20171029160857.29460-2-anarcat@debian.org>
Date:   Mon, 30 Oct 2017 11:43:04 +0100
In-Reply-To: <20171029160857.29460-2-anarcat@debian.org> ("Antoine
 \=\?utf-8\?Q\?Beaupr\=C3\=A9\=22's\?\=
        message of "Sun, 29 Oct 2017 12:08:54 -0400")
Message-ID: <q7h93760zzk7.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antoine Beaupré <anarcat@debian.org> writes:

> @@ -319,6 +341,10 @@ sub get_mw_pages {
>  		$user_defined = 1;
>  		get_mw_tracked_categories(\%pages);
>  	}
> +    if (@tracked_namespaces) {
> +        $user_defined = 1;
> +        get_mw_tracked_namespaces(\%pages);
> +    }
>  	if (!$user_defined) {
>  		get_mw_all_pages(\%pages);
>  	}

Space Vs tabs indent issue (I have tab-width = 8, you probably have 4
and this "if" looks underindented).

-- 
Matthieu Moy
https://matthieu-moy.fr/
