From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
Subject: [ANNOUNCE] Push Me Pull You 0.1 - Preview Release
Date: Wed, 9 Jan 2008 02:28:40 +0000
Message-ID: <200801090228.40382.mark.williamson@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 03:59:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCRAO-0000Qg-4M
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 03:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbYAIC67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 21:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbYAIC67
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 21:58:59 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:45326 "EHLO
	ppsw-9.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbYAIC66 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 21:58:58 -0500
X-Greylist: delayed 1814 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2008 21:58:58 EST
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from maw48.kings.cam.ac.uk ([128.232.236.103]:38875)
	by ppsw-9.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpsa (PLAIN:maw48) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1JCQgK-0000Gf-W7 (Exim 4.67) for git@vger.kernel.org
	(return-path <maw48@hermes.cam.ac.uk>); Wed, 09 Jan 2008 02:28:40 +0000
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69946>

Hi all,

For some time I have been working on a GUI for DVCS systems, which I have 
named Push Me Pull You (PMPU).  At its core is a GUI for viewing Incoming / 
Outgoing changesets.  It also includes support for initiating pulls / pushes, 
doing clones, etc.  Eventually I hope to provide access to much more 
functionality.

My "native" DVCS is Mercurial and I'm rather new to git's way of doing things, 
although it is similar in many respects.  PMPU is intended to support 
multiple DVCS systems; currently it supports hg, bzr and git.  The level of 
support and testing for these backends varies, however my eventual goal is to 
have complete and robust support for all of them (and probably others).

This is just a quick heads-up that I've tagged a 0.1 release and that the code 
may be worth looking at / playing with for some of you.

Please note that error handling is non-existant and that many usecases (e.g. 
nested repositories) haven't been tested.  The git backend is currently 
fairly lightly tested.  It seems to work OK for me, just please be CAUTIOUS 
when playing with it.

The hg repository is here:
http://xenbits.xensource.com/maw/pmpu.hg

And the homepage (including a tarball of the release) is here:
http://www.cl.cam.ac.uk/~maw48/pmpu/

I would love to hear any feedback, suggestions, bug reports, etc.  Please cc 
any mailing list e-mails to me, as I am not subscribed.  You're all welcome 
to contact me directly if preferred.

Cheers,
Mark
-- 
Dave: Just a question. What use is a unicyle with no seat?  And no pedals!
Mark: To answer a question with a question: What use is a skateboard?
Dave: Skateboards have wheels.
Mark: My wheel has a wheel!
