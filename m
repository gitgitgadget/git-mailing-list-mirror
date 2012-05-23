From: <dag@cray.com>
Subject: Re: Feature idea: git rebase --exec $CMD
Date: Wed, 23 May 2012 10:12:08 -0500
Message-ID: <nngfwar3p9z.fsf@transit.us.cray.com>
References: <20120505132650.637c4e06086654e0dbf641fc@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Wed May 23 17:12:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXDEg-0007wX-Ld
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 17:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933670Ab2EWPMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 11:12:19 -0400
Received: from exprod6og101.obsmtp.com ([64.18.1.181]:51171 "EHLO
	exprod6og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932692Ab2EWPMR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 11:12:17 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob101.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT7z+TJyXTv9VdQw2od4rEfBg6B8x3xwn@postini.com; Wed, 23 May 2012 08:12:17 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.247.3; Wed, 23 May
 2012 10:12:11 -0500
In-Reply-To: <20120505132650.637c4e06086654e0dbf641fc@studenti.unina.it>
	(Antonio Ospite's message of "Sat, 5 May 2012 13:26:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198295>

Antonio Ospite <ospite@studenti.unina.it> writes:

> I find the x/exec function in "git rebase -i" very useful, but it may
> be tedious to edit the commit list to add something like "make test"
> after each commit.

I've taken a more general approach inspired by
run-command-on-git-revisions at
https://github.com/garybernhardt/dotfiles/tree/master/bin

I took that and turned it into a git-run-command subcommand.  It will
take an arbitrary command and run it on each revision specified by a
revlist.

I think that's a more flexible approach than tying it to rebase.

Thoughts?

                          -Dave
