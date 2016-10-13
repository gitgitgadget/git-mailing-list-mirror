Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F36220989
	for <e@80x24.org>; Thu, 13 Oct 2016 14:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbcJMO5B (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 10:57:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:61495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751902AbcJMO47 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 10:56:59 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Mcyxq-1bcccJ26Xy-00IAOH; Thu, 13 Oct 2016 16:56:29
 +0200
Date:   Thu, 13 Oct 2016 16:56:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 25/25] sequencer: mark all error messages for
 translation
In-Reply-To: <xmqqlgxt2rch.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610131518220.197091@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de> <e38bf77ff57d06ca3250bc3ec71a34088b49abd0.1476120229.git.johannes.schindelin@gmx.de> <d24a3823-1ed0-ad97-f02d-febab7a97590@kdbg.org>
 <xmqqlgxt2rch.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZLlo2mRnbhqEtzRr6KZuSe57fBqtcZXOOQr2k4zm2ZOeQ6lvRwh
 97fHCYuabygneZ5yOlllkS8bcVJPzblS1Q3+wdZgbc89rJXzFV1edPTC6BmrmFUsOU9uBMA
 gJMoGVmHVzJClAYiCH8w7aai0buG6NpwKTkpv+lc13WrAAQ864G2YdbAzdp8xTJkQlOz3ma
 xWQ6OSo0zRM7HVoOub5Yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h+je7brUo8c=:KKfr6sXqNQJQy737nC1TsN
 G6UtI5wP8bsoguhxgJY51YJ3EPsLOxH/Nvm8TWW73qgzuW+XHkGpwAWOFsVUpd9dcYb1Qw9iq
 CbcpFq5nX85fBz23PCSX9b9ZODlny8JH1HI/PVqru4Hxy/Fvle+PVSDlagOGip56wuaWLbKaT
 ITmV8Yx7Nrdh3pN1vbi1FCjH4tQD6zrZqmqIDZ5FqIGDeHdMVZhhp9eQoJ/7b3oGZjRbb+w2/
 GraV28v+CBybNqbfE+wcd9klluC0ObTgxl7P6+A4/1jFx5lvIJGjVzilM8FVeTsvu3UiyF5f+
 7f0G97Ko3aZfqECE/RLgFdLTgfjh7TQfJ00CGmAeBxuhefJ7uXfB7A3McFe258BggWPsUe5Ph
 utqHBTT+QFRfRSLagxVcJNzI1BU4Ity0f1ng0u3Hvz1pR4++eS5bmFNSERecu/+fEUyVYNkwi
 Ft9ugAGuC3XtK8i7OQauo1aTy2tO2g+oGun5UNdeRhn9mMCcW52ADzfHOPKAZcXSNqCn6Kirh
 Dp0oYT93EIKFtAXp7Dwg4ZErCOYLH2O7W6rZhxzg6lKesNOyYEQagVPKCcZ6DAyFPpgwl+l9X
 xo/1jYjtsiaZLnGNgHG72QXfbpnmw90rrU5UnuXu8wMJ/VGHs/3uW+NZlFzmpR4Lqj06wz1+F
 Habw+pHqKUt8MuotF+vq4O9JSXzc8+uwzLHfAYdFjAMOrWpLXImRvadmM6vtp5QNCKqISPY+0
 wC88Ozj/pL1QQZur4R9ftkLqoQ59TPPBUUQnJNl5xmx4VMlVBRxkaD6npSKSd21rIpzd20nzU
 njPMLTb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 12 Oct 2016, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Can we please have the following change instead? I think it makes sense
> > to deviate from the usual conventions in a case like this.
> 
> You have at least two independent changes relative to Dscho's
> version.  
> 
>  (1) Show line breaks more prominently by avoiding "\n\n" and
>      breaking the string at "\n"; this matches the way how the
>      result would be displayed more closely to how the source looks
>      like.
> 
>  (2) Ignore the usual indentation rule and have messages start at
>      the left end of the source.
> 
> Which one are you saying "makes sense" to?  Both?
> 
> I guess both can be grouped together into one theme: match the way
> the final output and the source code look like.
> 
> If that is the motivation behind "makes sense", I'd prefer to see
> the change explained explicitly with that rationale in the log
> message.
> 
> Thanks.  I personally agree with that motivation (if the one I
> guessed above is your motivation, that is).

I agree with that motivation, but I decided to go about it in a way that
is more in line with the existing source code:

-- snipsnap --
diff --git a/sequencer.c b/sequencer.c
index 8e10bb5..1cf70f7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -483,6 +483,20 @@ static char **read_author_script(void)
 	return env;
 }
 
+static const char staged_changes_advice[] =
+N_("you have staged changes in your working tree\n"
+"If these changes are meant to be squashed into the previous commit, run:\n"
+"\n"
+"  git commit --amend %s\n"
+"\n"
+"If they are meant to go into a new commit, run:\n"
+"\n"
+"  git commit %s\n"
+"\n"
+"In both cases, once you're done, continue with:\n"
+"\n"
+"  git rebase --continue\n");
+
 /*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
@@ -509,18 +523,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		if (!env) {
 			const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
-			return error(_("you have staged changes in your "
-				       "working tree. If these changes are "
-				       "meant to be\n"
-				       "squashed into the previous commit, "
-				       "run:\n\n"
-				       "  git commit --amend %s\n\n"
-				       "If they are meant to go into a new "
-				       "commit, run:\n\n"
-				       "  git commit %s\n\n"
-				       "In both cases, once you're done, "
-				       "continue with:\n\n"
-				       "  git rebase --continue\n"),
+			return error(_(staged_changes_advice),
 				     gpg_opt, gpg_opt);
 		}
 	}
