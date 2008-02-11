From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 10 Feb 2008 21:04:12 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802102059260.2732@xanadu.home>
References: <200802081828.43849.kendy@suse.cz>
 <alpine.LFD.1.00.0802100017380.2732@xanadu.home>
 <BAYC1-PASMTP059B375F7660D93F93647DAE290@CEZ.ICE>
 <200802110242.27324.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_+N29K5GTs5qyet3s8oBRJg)"
Cc: Sean <seanlkml@sympatico.ca>, Jan Holesovsky <kendy@suse.cz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 03:04:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOO2M-0007PL-Vx
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 03:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbYBKCEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 21:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbYBKCEO
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 21:04:14 -0500
Received: from relais.videotron.ca ([24.201.245.36]:50758 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbYBKCEN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 21:04:13 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW100GK9XR02CV0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Feb 2008 21:04:13 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <200802110242.27324.jnareb@gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73454>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_+N29K5GTs5qyet3s8oBRJg)
Content-type: TEXT/PLAIN; charset=iso-8859-2
Content-transfer-encoding: 8BIT

On Mon, 11 Feb 2008, Jakub Narebski wrote:

> On Sun, 10 Feb 2008, Sean napisa³:
> > On Sun, 10 Feb 2008 00:22:09 -0500 (EST)
> > Nicolas Pitre <nico@cam.org> wrote:
> >
> >> Finding out what those huge objects are, and if they actually need to be 
> >> there, would be a good thing to do to reduce any repository size.
> > 
> > Okay, i've sent the sha1's of the top 500 to Jan for inspection.  It appears
> > that many of the largest objects are automatically generated i18n files that
> > could be regenerated from source files when needed rather than being checked
> > in themselves; but that's for the OO folks to decide.
> 
> Good practice is to not add generated files to version control.
> But sometimes such files are stored if regenerating them is costly
> (./configure file in some cases, 'man' and 'html' branches in git.git).
> 
> IIRC Dana How tried also to deal with repository with large binary
> files in repo, although in that case those had shallow history. IIRC
> the proposed solution was to pack all such large objects undeltified
> into separate "large-objects" kept pack.

That was to solve a completely different problem which wasn't about 
space saving, but rather to save on 'git push' latency.


Nicolas

--Boundary_(ID_+N29K5GTs5qyet3s8oBRJg)--
