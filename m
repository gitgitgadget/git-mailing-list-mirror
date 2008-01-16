From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
Subject: Re: [ANNOUNCE] Push Me Pull You 0.2 - Tech Preview Release
Date: Wed, 16 Jan 2008 23:15:35 +0000
Message-ID: <200801162315.35288.mark.williamson@cl.cam.ac.uk>
References: <200801152131.33628.mark.williamson@cl.cam.ac.uk> <7vzlv5pnrf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:17:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFHVW-0004KY-Fh
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 00:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106AbYAPXQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 18:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755962AbYAPXQR
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 18:16:17 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:44164 "EHLO
	ppsw-9.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755765AbYAPXQP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 18:16:15 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from maw48.kings.cam.ac.uk ([128.232.236.103]:54360)
	by ppsw-9.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpsa (PLAIN:maw48) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1JFHUS-0005vW-Tt (Exim 4.67)
	(return-path <maw48@hermes.cam.ac.uk>); Wed, 16 Jan 2008 23:16:12 +0000
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
In-Reply-To: <7vzlv5pnrf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70770>

> > I'd like to announce a new release of the Push Me Pull You (pmpu) tool; a
> > GUI for distributed revision control systems.
> >
> > PMPU supports plain hg, hg forest repositories, bzr, git and darcs as
> > underlying repositories.  It aims to provide a powerful graphical
> > interface to the underlying functionality, based around the workflow of
> > incoming and outgoing changesets.
>
> I haven't tried to look at this since your 0.1 announcement
> (which unfortunately was accepted with a thundering silence
> here),

Heheh, yeah, I was almost deafened by it :-)  But it's a new obscure tool, 
written using an foreign SCM so I'm not surprised if uptake is slow!

> but it would be interesting if it allowed to pull from Hg 
> into git (or other combinations).  Is that one of the features
> (or planned features)?

That's not one of the current features; I've been focusing on making basic 
functionality of each of the backend available from the GUI.  I'm trying to 
do this in a standardised way so that the GUI always looks / acts the same 
regardless of underlying storage repository.

But yes, in the future I'd like to wrap the process of repository conversion / 
interaction so that's it's easier for people on different SCM backends to 
collaborate.  I've been pondering whether a commandline-based "universal SCM 
tool" that could transparently provide DVCS functionality on top of a variety 
of systems would be worth playing with at some point.

Cheers,
Mark

-- 
Push Me Pull You - Distributed SCM tool (http://www.cl.cam.ac.uk/~maw48/pmpu/)
