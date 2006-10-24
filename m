From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: Question about commit message conventions
Date: Tue, 24 Oct 2006 16:08:56 +0200
Organization: Harddisk-recovery.com
Message-ID: <20061024140856.GH5639@harddisk-recovery.com>
References: <200610241549.48238.t.toedter@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 16:10:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcMy6-00027B-Mv
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 16:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWJXOJA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 10:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWJXOJA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 10:09:00 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:12707 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1030223AbWJXOI7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 10:08:59 -0400
Received: (qmail 28179 invoked from network); 24 Oct 2006 16:08:56 +0200
Received: from unknown (HELO zurix.bitwizard.nl) (192.168.234.26)
  by abra2.bitwizard.nl with SMTP; 24 Oct 2006 16:08:56 +0200
Received: from erik by zurix.bitwizard.nl with local (Exim 3.36 #1 (Debian))
	id 1GcMxc-0002PF-00; Tue, 24 Oct 2006 16:08:56 +0200
To: Tobias Toedter <t.toedter@gmx.net>
Content-Disposition: inline
In-Reply-To: <200610241549.48238.t.toedter@gmx.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29978>

On Tue, Oct 24, 2006 at 03:49:44PM +0200, Tobias Toedter wrote:
> although I've read the documentation of git very carefully, I could not find 
> anything related to certain commit message conventions. It would be great 
> if someone here could explain a few things, maybe this could be added to 
> the wiki afterwards (<http://git.or.cz/gitwiki/CommitMessageConventions>).
> 
> First of all, what's the intended use of the "Signed-off-by:" lines? Does it 
> make sense to add my name there, even when I'm listed as the author or 
> committer of a commit? I thought that they are intended mostly to note the 
> approval of other developers.

See Documentation/SubmittingPatches. You basically say you have the
right to submit the patch.

> On the other hand, concerning the approval of other developers, what's the 
> difference between "Signed-off-by:" and "Acked-by:"? Are there any 
> more "*-by:" fields that are in use?

Acked-by is usually used when someone (not the upstream maintainer the
patch was send to) agrees with the patch. I.e.: (s)he says the content
of the patch is OK without actually acknowledging something about the
right to submit.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
