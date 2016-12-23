Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81F701FF76
	for <e@80x24.org>; Fri, 23 Dec 2016 23:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbcLWXys (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 18:54:48 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35068 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbcLWXyr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 18:54:47 -0500
Received: by mail-wj0-f196.google.com with SMTP id hb5so8897400wjc.2
        for <git@vger.kernel.org>; Fri, 23 Dec 2016 15:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9jEhNNRCEvIZ4hYvfpp+Ylad2k4+SSF1fzXDXtcDQcI=;
        b=Hny9P/h9TuXajhrvdJ0uWWVIkmzpLsjMXwHtVKejHID4NjNXSUWAAjmb0m4bqxOCTP
         aTkD7mAHIbZ84C7oxiQEKvrIIB4OaGXKBZGD0M1Aonr064EfqjebLPFbYYt8ulUc6g3B
         v/FCaYslDwFc+R+MswLxAOd3SD9vW2VvbLVNBfnrv6DJ49D+5yQnZFBVoz5JWISpVFuO
         ZNFt0ge2RqULgqEi7ADmNpGgT+et1XXkk69Pi3eq1LkeMPMWZE6Ar+EIlCYE9f5Zh7Ff
         d5XgwzchoTVZ7iKrFrY1myLLQloieQteZvhryyCbUsOPALrNPxfuFwCxSbrUJJoXfGE/
         y1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9jEhNNRCEvIZ4hYvfpp+Ylad2k4+SSF1fzXDXtcDQcI=;
        b=tRZpAHm/21O69RFAYJJSPPjE9ezhJSLWMlHzD9wtSe2dyKRcQQxfpaLNv/WHx54Rn+
         JwfadTZ17yQTgHuCRwwnVI4fP/D86iPbQpbUXYLdz8Wunn2PEF7kcHy+k2abL3i6traQ
         6O3xIPJEpjfVQgC1IjYhy2j6dzltGEX1PqL65i2qpCDREzIxQuwVtKmt8XSgy3Lu4WBl
         MYZjIfC61e6DuTzvCciUmcBGygtoaOyZLYve/+jjtWNS+wv7rUziGhOxMOq04NCsp98t
         +2iO49RC+UMoa9LDtrHFldLDnW4knzwYkvJ3AwLVz+L/xhDQpHH4Nn7Xs1MCTlqt2jgD
         l9RQ==
X-Gm-Message-State: AIkVDXIUeHV4CZdNyiL6iAsqRZbNbGyE0awfgq9L7JbwWFCN4FWEfXQE3ajaq1DueFposg==
X-Received: by 10.194.148.134 with SMTP id ts6mr15247946wjb.220.1482537285378;
        Fri, 23 Dec 2016 15:54:45 -0800 (PST)
Received: from krk4cz1410qf7.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id cl10sm42674850wjb.4.2016.12.23.15.54.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Dec 2016 15:54:44 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Dec 2016, #07; Thu, 22)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqzijnehgb.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 24 Dec 2016 00:55:29 +0100
Cc:     git <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
        Stefan Beller <sbeller@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E1C7387-4F37-423F-803D-3B5690B49D40@gmail.com>
References: <xmqqzijnehgb.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 22 Dec 2016, at 23:18, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>=20
> Even though I try not to do two "What's cooking" report back to back,
> I wanted to push out a few topics that we want to have in 'master'
> soonish on 'next' before things really quiet and slow down due to
> year-end holidays.
>=20
> You can find the changes described here in the integration branches
> of the repositories listed at
>=20
>    http://git-blame.blogspot.com/p/git-public-repositories.html
>=20
> Here are the summaries:
>=20
> Will merge to 'master'.
> + jc/push-default-explicit                                     =
10-31/11-01    #2
> + sb/submodule-config-cleanup                                  =
11-22/11-23    #3
> + va/i18n-perl-scripts                                         =
12-14/12-19   #16
> + cp/merge-continue                                            =
12-15/12-19    #4
> + bw/transport-protocol-policy                                 =
12-15/12-19    #6
> + ls/filter-process                                            =
12-18/12-19    #2
> + ld/p4-compare-dir-vs-symlink                                 =
12-18/12-20    #1
> + jk/difftool-in-subdir                                        =
12-11/12-21    #4
> + sb/submodule-embed-gitdir                                    =
12-12/12-21    #6
> + gv/p4-multi-path-commit-fix                                  =
12-19/12-21    #1
> + mk/mingw-winansi-ttyname-termination-fix                     =
12-20/12-21    #1
> + lt/shortlog-by-committer                                     =
12-20/12-21    #3
> + va/i18n-even-more                                            =
12-20/12-22    #1
> + ls/p4-lfs                                                    =
12-20/12-22    #1
> + js/mingw-isatty                                              =
12-22/12-22    #3
> + bw/realpath-wo-chdir                                         =
12-22/12-22    #5
> + bw/grep-recurse-submodules                                   =
12-22/12-22    #7
>=20
> Will merge to 'next'.
> - jc/git-open-cloexec                                          11-02   =
       #3
> - ls/p4-path-encoding                                          12-18   =
       #1

Please hold it. Luke [1] made a good point and I need some time to think =
it through.

[1] =
http://public-inbox.org/git/CAE5ih7-=3DbD_ZoL5pFYfD2Qvy-XE24V_cgge0XoAvuoT=
K02EDfg@mail.gmail.com/

--

Unrelated to my topic:
=20
"next" seems to generate a small error on macOS. Probably introduced in
"worktree: check if a submodule uses worktrees" (1a248cf)

worktree.c:423:9: error: variable 'ret' is used uninitialized whenever =
'while' loop exits because its condition is false =
[-Werror,-Wsometimes-uninitialized]
        while ((d =3D readdir(dir)) !=3D NULL) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~
worktree.c:431:9: note: uninitialized use occurs here
        return ret;
               ^~~
worktree.c:423:9: note: remove the condition if it is always true
        while ((d =3D readdir(dir)) !=3D NULL) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~
               1
worktree.c:390:9: note: initialize the variable 'ret' to silence this =
warning
        int ret;
               ^
                =3D 0
1 error generated.

More: =
https://s3.amazonaws.com/archive.travis-ci.org/jobs/186186597/log.txt


- Lars

