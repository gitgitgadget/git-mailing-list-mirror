Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87AB81FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 17:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbcLFRYz (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 12:24:55 -0500
Received: from mout.gmx.net ([212.227.15.18]:50924 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbcLFRYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 12:24:54 -0500
Received: from [192.168.178.50] ([188.98.236.66]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LdYdG-1cvaiH1pn0-00ikfZ for
 <git@vger.kernel.org>; Tue, 06 Dec 2016 18:24:51 +0100
Subject: Re: Re: Feature request: Set git svn options in .git/config file
To:     git@vger.kernel.org
References: <1936940c-c4c8-540c-eb99-b434e8d32d6c@gmx.de>
 <20161205225424.GA29771@starla>
From:   Juergen Kosel <juergen.kosel@gmx.de>
X-Enigmail-Draft-Status: N1110
Message-ID: <6160a58b-5f86-384f-30b5-2a3826019157@gmx.de>
Date:   Tue, 6 Dec 2016 18:24:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161205225424.GA29771@starla>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:kgZ86V/iEJEHHBjHavRy7NyIzrfqXJyA0h0jSnyKjephjIh6owq
 aFOamaozYSBrjTL2LlVZYWzLMjqfHvOq7FLiTyJnZJplIJuVCrNZMMsEmtiKKrhyoyMXV3a
 JGqCKjuxDr4ozlGSJwWDHBApk3W3nkivgltDIxjuQM7G4muH1wD/SQcbu71sUtX2xGKuhVW
 bWgG+ggcbcZ5lukYc2d2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jqWkwf5d4eY=:50WIndfDsG3xNPRHnyWn47
 DQ+e2bt1gIenj2kmAugCmZpRwuGENKEa8PEvg3ZqJs44eUZfGRMYPdWCCSXXGom494bb2hYsQ
 AlqfFodCHxXDaCQLsFhBrQCeppqqF7g7yJLMdF1hrLg1tOgJaudoWZ5L7P1pkiBpC7fgPkqgS
 evBou63IF0Z5GUPPu7tNcGGQH1jgm6+6rpA6LjEmepysESeMwZkYd3QpANrRWBwO5Z8jpzv0+
 UZHNirdgTG1I3Q5Ok3kx9ZgjHOvM9MGipGXrABddh3x7AoDyLOLfIewuutdfyuKMh1dSwkEhw
 pRzBvV6VjjCMJwqabBVAlY7I5h3RfrAMDSG+eLBVFIi+SVehUjurFeioSq6jbkwsIl+WnhjaA
 +26GtwIO9EMhydIJUOWiwrVGN2EwTnLDMBRDGRwKrIOFeVgugKduuly5ZyElKn2u1C9wC2qmB
 Vp7Vgazq0APHOBLeFlVBzNcHahaTK82iASISCDVC3Hr6CMt6GFIZYjONmJaZvLAPgW51xsw3u
 NJRt2evjoFITQOwn29XmBWQCs66P/j5b1F45im5fS7Fx9/SVLBZtl7O0CxrApTvua737QJvmS
 7Q+bBwFRHcPiLnLiltd97kJSfUSGP6b8h0imh4nZ6I3SARkNAabkBmYRoM9ecCHjHTyZWMsUg
 eFhr0iB+M/gIgDFR/aSL5p4nJ03TpHJMAOW34dOT2Y64sMETiXlQiqOYCpaK6PpvDtKyuhc6s
 VZDUc6W3bag/vLLvotDPwL81UJSZQzSsBGOssONHLGaJTzQssNoaQPz5tRee4iG9RRvVdKABp
 ccMpBBR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hello,

Am 05.12.2016 um 23:54 schrieb Eric Wong:
> So, can you confirm that svn.addAuthorFrom and svn.useLogAuthor 
> config keys work and can be documented?

yes, I can confirm, that adding this configuration keys works with git
2.1.4 work.
I have added the config keys as follows:

git config --add --bool svn.useLogAuthor true
git config --add --bool svn.addAuthorFrom true

> 
> Even better would be for you to provide a patch to the 
> documentation :) Otherwise, I can write one up sometime this week.

My English is not that well. So I prefer, if you update the
documentation :-)


Greetings
	Juergen


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFYRvRhYZbcPghIM9IRAjtHAJ0QaqbUxcgoPXmidIg9WALXmg1JAQCfTHFj
wgPLKXK5Ny0bP/K9vpE9KzY=
=A+Yy
-----END PGP SIGNATURE-----
