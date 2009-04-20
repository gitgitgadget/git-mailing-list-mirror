From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Oldest supported Perl version
Date: Mon, 20 Apr 2009 23:07:07 +0200
Message-ID: <20090420230707.48f5f82c@pc09.procura.nl>
References: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
	<20090420181806.229b833e@pc09.procura.nl>
	<alpine.DEB.1.00.0904201926531.6771@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Witten <mfwitten@gmail.com>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 23:09:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw0k4-0006Ul-ED
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 23:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754AbZDTVHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 17:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754140AbZDTVHs
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 17:07:48 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:4511 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbZDTVHs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 17:07:48 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id n3KL77xv022026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 20 Apr 2009 23:07:08 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <alpine.DEB.1.00.0904201926531.6771@intel-tinevez-2-302>
X-Mailer: Claws Mail 3.7.1cvs44 (GTK+ 2.14.4; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117035>

On Mon, 20 Apr 2009 19:29:03 +0200 (CEST), Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Mon, 20 Apr 2009, H.Merijn Brand wrote:
> 
> > * defined-or is available in any version of perl 5.8.x is the binary
> >   was built with the appropriate patch, which is available on my CPAN
> >   directory:
> >   ftp://download.xs4all.nl/pub/mirror/CPAN/authors/id/H/HM/HMBRAND/
> >   These patches still include the 'err' keyword
> 
> Do you realize how much _pain_ you cause here?

Me? Why?
I just couldn't line *without* defined-or after I first encountered it,
so I backported it to 5.8.x (after some patch from someone else) and
people thought it would be a good idea to semi-officially allow it to
be available for all.

Officially, defined-or is *NOT* available in perl-5.8.x. End of story.

*ALL* my production code expects defined-or to be available.

> I just do not have the _time_ to recompile Perl 5.8 for msysGit!

Sorry, I can't help you there

> Bah,
> Dscho "who thinks that a lot of people would not introduce dependencies 
> so lightly if they actually felt the pain they cause"

-- 
H.Merijn Brand  http://tux.nl      Perl Monger  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, OpenSuSE 10.3, 11.0, and 11.1, AIX 5.2 and 5.3.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
