Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCED2207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 20:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760499AbcIWUpS (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 16:45:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:56693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758358AbcIWUpR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 16:45:17 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M82zV-1b0mRD3VxZ-00viG7; Fri, 23 Sep 2016 22:45:11
 +0200
Date:   Fri, 23 Sep 2016 22:45:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2016, #06; Wed, 21)
In-Reply-To: <xmqqk2e46da3.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609232244140.129229@virtualbox>
References: <xmqqk2e46da3.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:whVxw3rSDZNszS43wUc6H/8UFz9WZj2mrmv06oDwa21aMmushdR
 XPti83Bou33hgAR/7sSFxZeYft0JwSEp4xCsBepEQqL8jLJQNydTnDFoKE6wbsX3Gk69sPS
 MQ1KgUusHIKCDqLgixIei5M+azgwkJ5XR7YSUbagyU9Qwa2+YRUF+I8/Zfs5PN1RSRU6Bmg
 sovIo5dHpv2D+24Ahjmiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:awY8ZUSywxs=:9vjpEM8z6dP6vvLe/YdR4K
 m3gdfGLnOmjhoKWUXR6E3hDZFoaodUVyLaoNEptuluXDQEZeGKzP2y3S+I7YRKDWSYWXX9qoG
 6wL6qVDMVen0ZpjPjdwpoOTv8wmUPpxGLtL1tQH3Y9HVv1ynxDsaiX3sCHtDTyh4AR6UiVTMZ
 QMyE8+HsiRxAcDoikl74mH2ZnWeTT+hQC3yuexNfzQ9kpz8e5ksPRC01bmzZo2upftZ+N5lRg
 pbA15TQOveZiS1xtmp3H95XlyhPLdiYKoPyVrwEg6lFt7Cm39kD+Aa7gaaRq/JMu/qvbLyZVD
 gM+pmFKI4QybAEUnZs3ujN+yI4f2tt04LZhh8XqqC/0TM2L3wSOwjwd6N4MyLgqEfsv1bs9JS
 jXegWBqmttCrzRsvKcbVoHlJ2Uze8B1xjOAEdfLHoVijE52lzhtvUwHQ7QxXJTpwVEHGRdWTP
 cYAhofUggem5nmheDyABaOVV3skvxGVF4MOBN/R6/vS01qHuBUz9XxbDuobnvlpUHKgsRnnUv
 dssQZKabrcEFquQfdFLFgYs0yE+1Lcbyt0fkWpOOEH2sV0Es6hCb7TgByFODIkLhYzPjkARRq
 FXR/WHOMdCu2g+h8IALILm8QSqLbyScgj8NEZN9nkZMxWVoAuGBQJcDREJRHFKSNzIvw4PtlW
 ttyady8EP2EKeElLtJVDDRYdtTc3Ins7gsRCGEd1U501bmCQGOUEI0Zmgn9Btv1/HADkqlNAu
 tCKQa/liwh+AoTrwkhCYqF9m4RCQUiO4mYUUfY9x+cyNUnJoLhoYyAY18swL+hFu5V/Zh/kYw
 MmQg1us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 21 Sep 2016, Junio C Hamano wrote:

> * rt/rebase-i-broken-insn-advise (2016-09-07) 1 commit
>  - rebase -i: improve advice on bad instruction lines
> 
>  When "git rebase -i" is given a broken instruction, it told the
>  user to fix it with "--edit-todo", but didn't say what the step
>  after that was (i.e. "--continue").
> 
>  Will hold.
>  Dscho's "rebase -i" hopefully will become available in 'pu', by
>  which time an equivalent of this fix would be ported to C.  This is
>  queued merely as a reminder.

Porting the fix was surprisingly easy:

-- snipsnap --
[PATCH] fixup! rebase -i: check for missing commits in the rebase--helper

---
 sequencer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8f27524..386d16e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2567,9 +2567,10 @@ int check_todo_list(void)
 
 	if (raise_error)
 		fprintf(stderr,
-			_("You can fix this with 'git rebase --edit-todo'.\n"
-			"Or you can abort the rebase with 'git rebase"
-			" --abort'.\n"));
+			_("You can fix this with 'git rebase --edit-todo' "
+			  "and then run 'git rebase --continue'.\n"
+			  "Or you can abort the rebase with 'git rebase"
+			  " --abort'.\n"));
 
 	return res;
 }
-- 
2.10.0.windows.1.10.g803177d

