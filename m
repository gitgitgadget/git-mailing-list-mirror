From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
Subject: [ANNOUNCE] Push Me Pull You 0.2 - Tech Preview Release
Date: Tue, 15 Jan 2008 21:31:33 +0000
Message-ID: <200801152131.33628.mark.williamson@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 22:32:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEtOD-0007Qh-Jm
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 22:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721AbYAOVbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 16:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbYAOVbh
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 16:31:37 -0500
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:49006 "EHLO
	ppsw-8.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbYAOVbg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 16:31:36 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from maw48.kings.cam.ac.uk ([128.232.236.103]:38493)
	by ppsw-8.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpsa (PLAIN:maw48) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1JEtNe-0007Fr-R1 (Exim 4.67) for git@vger.kernel.org
	(return-path <maw48@hermes.cam.ac.uk>); Tue, 15 Jan 2008 21:31:34 +0000
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70564>

Hi all,

I'd like to announce a new release of the Push Me Pull You (pmpu) tool; a GUI 
for distributed revision control systems.

PMPU supports plain hg, hg forest repositories, bzr, git and darcs as 
underlying repositories.  It aims to provide a powerful graphical interface 
to the underlying functionality, based around the workflow of incoming and 
outgoing changesets.

PMPU is implemented in Python and PyQt4 and is tested on Linux, though it 
should work on other Unix platforms.  I eventually hope to support Windows 
hosts also.  For hg, bzr and git, plugins are supplied to improve integration 
with the command line interface of the underlying system.

My DVCS of choice is Mercurial but I aim to properly support the other 
backends and have this be an SCM-agnostic system.  I would appreciate expert 
feedback about my implementation of all the backends including Mercurial, 
including advice if I'm doing things wrong and suggestions of further 
enhancements.

Please treat this as experimental software, released as a technical preview.  
The error handling is not very good and my understanding of the underlying 
SCMs is still somewhat incomplete.  I regard it as fairly safe and solid and 
it hasn't eaten my data during all my use and testing but please be cautious 
nonetheless.  I don't want to make it sound like it's going to destroy the 
world ;-) but I'm very aware that most users of revision control have 
critical data to manage.

The website is here: http://www.cl.cam.ac.uk/~maw48/pmpu/ and contains links 
to a downloadable tarball and the Mercurial repository.

Please feel free to send me e-mail with feedback or questions, no matter how 
insignificant.  There's no user documentation, so don't hesitate to ask me 
questions about how things work.  Private e-mail is fine if you prefer.

Cheers,
Mark
-- 
Push Me Pull You - Distributed SCM tool (http://www.cl.cam.ac.uk/pmpu/)
