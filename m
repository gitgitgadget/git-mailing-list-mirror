From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Ensimag students projects, version 2013
Date: Mon, 15 Apr 2013 11:06:19 +0200
Message-ID: <87r4iccgdw.fsf@linux-k42r.v.cablecom.net>
References: <vpqobdg515m.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 11:06:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URfMo-0006Af-JT
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 11:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934459Ab3DOJGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 05:06:22 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:33826 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932703Ab3DOJGV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 05:06:21 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 15 Apr
 2013 11:06:17 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 15 Apr 2013 11:06:19 +0200
In-Reply-To: <vpqobdg515m.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Sun, 14 Apr 2013 22:04:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221205>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>   https://git.wiki.kernel.org/index.php/SmallProjectsIdeas

My $0.02:

* Allow "git add -p" to use "git diff --color-words" to show hunks 

  Check if you can use the existing --word-diff=porcelain output somehow
  to get it done in pure perl.  Alternatively, try to hack a word-diff
  mode where it spews out both the line-diff (for later application) and
  the word-diff (for display) in some clever format, so that the perl
  code can easily match them up.  If neither one is possible my feeling
  is that it's one of the hardest tasks on the list.  (Not to
  discourcage anyone from trying, but still.)

* git pull --set-upstream

  This is vaguely related to another itch that nobody has bothered to
  fix: 'git fetch origin foo' should really update origin/foo.  This has
  been discussed on the list a few times already:

    http://thread.gmane.org/gmane.comp.version-control.git/192252
    http://thread.gmane.org/gmane.comp.version-control.git/165720/focus=165758

  which by the way would be a *great* thing to fix, hint hint ;-)  and
  since Peff already posted a POC patch in the first thread, it's
  probably not that hard.  (Peff?)

* Allow git send-email --cc 'foo@example.com, bar@example.com' instead
  of git send-email --cc foo@example.com --cc bar@example.com

  That would be really nice.  Bonus points if it handles continuation
  lines etc. correctly, so that it's even easier to paste.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
