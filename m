From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: update-index --unresolve
Date: Thu, 2 Oct 2008 16:25:03 +0200
Message-ID: <20081002142503.GE6839@neumann>
References: <20081002135224.GC6839@neumann>
	<m3tzbvqesz.fsf@localhost.localdomain>
	<20081002141853.GD6839@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:26:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlP8D-0000bf-J1
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbYJBOZG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Oct 2008 10:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbYJBOZG
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:25:06 -0400
Received: from francis.fzi.de ([141.21.7.5]:37900 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752741AbYJBOZF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:25:05 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 2 Oct 2008 16:25:02 +0200
Content-Disposition: inline
In-Reply-To: <20081002141853.GD6839@neumann>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 02 Oct 2008 14:25:02.0769 (UTC) FILETIME=[A8860A10:01C9249A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97340>

On Thu, Oct 02, 2008 at 04:18:53PM +0200, SZEDER G=E1bor wrote:
> > > How could I clear those states by accident (or intentionally)?
> >=20
> > "git add <file>", or "git update-index <file>", or error in handlin=
g
> > merge tool via git-mergetool.
> Thanks for your fast reply.
>=20
> However:
>=20
> # ...  do a conflicting merge
> (master|MERGING)$ echo 4 >one
> (master|MERGING)$ git status
> one: needs merge
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working
> #   directory)
> #
> #       unmerged:   one
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> (master|MERGING)$ git add one
> (master|MERGING)$ git status
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #       modified:   one
> #
> (master|MERGING)$ git update-index --unresolve

Ah, that should be 'git update-index --unresolve one', and
everything works as expected.


Sorry,
G=E1bor
