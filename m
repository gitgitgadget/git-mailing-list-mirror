From: John Keeping <john@keeping.me.uk>
Subject: Re: Remove old forgotten command: whatchanged
Date: Thu, 8 Aug 2013 20:09:08 +0100
Message-ID: <20130808190908.GF2337@serenity.lan>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
 <vpqfvukdy39.fsf@anie.imag.fr>
 <ku0lqj$qvs$1@ger.gmane.org>
 <vpqk3jwcb1q.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Damien Robert <damien.olivier.robert+gmane@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 08 21:09:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7VaN-0006rN-8Y
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 21:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966204Ab3HHTJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 15:09:18 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:55565 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966146Ab3HHTJR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 15:09:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 46ED4CDA5B5;
	Thu,  8 Aug 2013 20:09:16 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rBcPGyT9SkVz; Thu,  8 Aug 2013 20:09:15 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 9B65BCDA5AE;
	Thu,  8 Aug 2013 20:09:10 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <vpqk3jwcb1q.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231922>

On Thu, Aug 08, 2013 at 08:06:09PM +0200, Matthieu Moy wrote:
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -532,12 +532,7 @@ commit, and you can tell it to show a whole series of diffs.
>  Alternatively, you can tell it to be "silent", and not show the diffs at
>  all, but just show the actual commit message.
>  
> -In fact, together with the 'git rev-list' program (which generates a
> -list of revisions), 'git diff-tree' ends up being a veritable fount of
> -changes. A trivial (but very useful) script called 'git whatchanged' is
> -included with Git which does exactly this, and shows a log of recent
> -activities.
> -
> +'git log' can also be used to display changes introduced by some commits.
>  To see the whole history of our pitiful little git-tutorial project, you
>  can do
>  
> @@ -550,7 +545,7 @@ with the associated patches use the more complex (and much more
>  powerful)

Isn't this paragraph slightly misleading now?  We're not using a
different command any more so this could say:

    which shows just the log messages, or if we want to see the log together
    with the associated patches use the `--patch` option


>  ----------------
> -$ git whatchanged -p
> +$ git log --raw -p
>  ----------------

Then this can be "git log --patch", since it seems that the surrounding
text doesn't actually care that whatchanged prints the raw diffstat.
