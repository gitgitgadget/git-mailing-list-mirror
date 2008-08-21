From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [JGIT PATCH] Typo in implementation of pack protocol
Date: Thu, 21 Aug 2008 17:02:00 +0200
Message-ID: <20080821170200.3ea08b28@pc09.procura.nl>
References: <1219314971-13445-1-git-send-email-mike@abacus.co.uk>
	<20080821145012.GN3483@spearce.org>
	<20080821170042.457e62f1@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mike Ralphson <mike@abacus.co.uk>, git@vger.kernel.org,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 17:09:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWBh3-0004Zz-JV
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 17:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674AbYHUPCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 11:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755451AbYHUPCO
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 11:02:14 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:2558 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805AbYHUPCO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 11:02:14 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id m7LF20Ux036917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Aug 2008 17:02:01 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <20080821170042.457e62f1@pc09.procura.nl>
X-Mailer: Claws Mail 3.5.0cvs64 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93163>

On Thu, 21 Aug 2008 17:00:42 +0200, "H.Merijn Brand"
<h.m.brand@xs4all.nl> wrote:

> On Thu, 21 Aug 2008 07:50:12 -0700, "Shawn O. Pearce"
> <spearce@spearce.org> wrote:
> 
> > Mike Ralphson <mike@abacus.co.uk> wrote:
> > > cgit's receive-pack.c has never had the corresponding typo.
> > > Fix up method and member names to match.
> > 
> > Whoops.  Thanks.
> >  
> > > -				if (line.equals("capabilties^{}")) {
> > > +				if (line.equals("capabilities^{}")) {
> > >  					// special line from git-receive-pack to show
> > >  					// capabilities when there are no refs to advertise
> 
> Wouldn't it be nice to stick to ANSI Comments?
> I bet AIX xlc will fall over very very fast here

Ignore that stupid remark. It's java :(


-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
