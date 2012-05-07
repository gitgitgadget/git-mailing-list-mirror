From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git svn dcommit <branch> committed to trunk anyway
Date: Mon, 7 May 2012 14:16:47 +0200
Message-ID: <87havs6v9s.fsf@thomas.inf.ethz.ch>
References: <CAH3AnroP+ckzgijibPDEupBCfUFu5Bwsq8YP58h+igXoJyJEyg@mail.gmail.com>
	<87txzsba0o.fsf@thomas.inf.ethz.ch>
	<CAH3Anrq5SGZZsTpKd1MFBRVD8xzsUvckt6d-BxtTYYce--F1+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 14:17:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRMsy-0002Fu-KZ
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 14:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756578Ab2EGMRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 08:17:34 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:39331 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756474Ab2EGMRB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 08:17:01 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 7 May
 2012 14:16:57 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.211.12) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 7 May
 2012 14:16:57 +0200
In-Reply-To: <CAH3Anrq5SGZZsTpKd1MFBRVD8xzsUvckt6d-BxtTYYce--F1+g@mail.gmail.com>
	(Jon Seymour's message of "Mon, 7 May 2012 17:08:56 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.211.12]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197262>

Jon Seymour <jon.seymour@gmail.com> writes:

> I guess I am confused by this guidance in git-svn(1) in the section on dcommit:
>
>     "An optional revision or branch argument may be specified, and
> causes git svn to do all work on that revision/branch instead of
> HEAD":
>
> I had assumed that dcommit would respect the optional (SVN branch)
> argument that I had specified, but it seems that this is not the case.
> What do the words in the man page actually mean, if they don't mean
> what I thought they meant.  Do the words "optional revision or branch"
> actually refer to the git commit/branch rather than the SVN
> revision/branch?

Oh, now I understand.  Yes, specifying a revision C there acts mostly as
if you said

  git checkout C^0
  git svn dcommit
  git checkout -

(IIRC, I haven't used it in a while).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
