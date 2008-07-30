From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Feature suggestion: git-hist
Date: Wed, 30 Jul 2008 14:14:49 +0200
Message-ID: <20080730141449.75cc8e92@pc09.procura.nl>
References: <20080730133859.368bbd92@pc09.procura.nl>
	<8B01DD07-7A11-4855-94E6-822D901840E3@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed Jul 30 14:15:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOAaw-0007QI-H9
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 14:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbYG3MOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 08:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754058AbYG3MOx
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 08:14:53 -0400
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:2705 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787AbYG3MOw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 08:14:52 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6UCEn2L050504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2008 14:14:50 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <8B01DD07-7A11-4855-94E6-822D901840E3@ai.rug.nl>
X-Mailer: Claws Mail 3.5.0cvs35 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90769>

On Wed, 30 Jul 2008 14:03:59 +0200, Pieter de Bie <pdebie@ai.rug.nl>
wrote:

> 
> On 30 jul 2008, at 13:38, H.Merijn Brand wrote:
> 
> > I've talked about this with Arjen, and he suggested to put it here.
> > Please Cc me too, as I have little time to follow this quite busy  
> > list.
> >
> > Suggestion
> >
> > 	Add a new command: 'git-hist' that will show a blame log of a
> > 	single file with each line `tagged' with the most recent tag
> > 	plus the number of changes since that tag.
> 
> You can do something almost similar with a command like:
> 
> 	git blame -l Makefile | git name-rev --stdin --tags

Very noisy compared to my script, but it indeed comes close to what I
need. This lacks the overview.

-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
