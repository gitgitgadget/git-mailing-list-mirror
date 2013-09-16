From: Patrick Welche <prlw1@cam.ac.uk>
Subject: Re: 1.8.4 rebase regression?
Date: Mon, 16 Sep 2013 11:28:32 +0100
Message-ID: <20130916102832.GB489@quark>
References: <20130915235739.GA712@quark>
 <vpqsix5b3uk.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 16 12:28:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLW2r-0004w9-Ht
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 12:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813Ab3IPK2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 06:28:37 -0400
Received: from ppsw-mx-f.csi.cam.ac.uk ([131.111.8.149]:43564 "EHLO
	ppsw-42.csi.cam.ac.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753108Ab3IPK2h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 06:28:37 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from host-92-17-176-162.as13285.net ([92.17.176.162]:65504 helo=quark)
	by ppsw-42.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:587)
	with esmtpsa (LOGIN:prlw1) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1VLW2k-0000FN-8i (Exim 4.80_167-5a66dd3)
	(return-path <prlw1@cam.ac.uk>); Mon, 16 Sep 2013 11:28:36 +0100
Content-Disposition: inline
In-Reply-To: <vpqsix5b3uk.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234833>

On Mon, Sep 16, 2013 at 09:52:35AM +0200, Matthieu Moy wrote:
> Patrick Welche <prlw1@cam.ac.uk> writes:
> 
> > I just upgraded (via pkgsrc) from git 1.8.3.4 to 1.8.4. With 1.8.4, I had
> > local changes in glib, did a git pull --rebase. Some of my changes
> > conflicted, but
> >
> > $ git rebase --abort
> > No rebase in progress?
> >
> > so somehow the usual process of amending the edit, or skipping the patch
> > no longer works.
> >
> > I found a similar report at:
> > http://mail-index.netbsd.org/pkgsrc-users/2013/09/14/msg018646.html
> 
> Does the following patch fix this issue?
> 
>   https://github.com/git/git/commit/99855dd

Yes thanks!

CONFLICT (content): Merge conflict in glib/gmain.c
Failed to merge in the changes.

:-)

Any thoughts of the cosmetic ESC[31m change?

Cheers,

Patrick
