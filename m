From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Oldest supported Perl version
Date: Mon, 20 Apr 2009 23:10:35 +0200
Message-ID: <20090420231035.683a7e0f@pc09.procura.nl>
References: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
	<m3eivnp5p4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Witten <mfwitten@gmail.com>, git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 23:12:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw0mk-0007Gf-Gx
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 23:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084AbZDTVKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 17:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755807AbZDTVKk
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 17:10:40 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:2718 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbZDTVKj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 17:10:39 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id n3KLAZ62024038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 20 Apr 2009 23:10:35 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <m3eivnp5p4.fsf@localhost.localdomain>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117037>

On Mon, 20 Apr 2009 10:59:14 -0700 (PDT), Jakub Narebski
<jnareb@gmail.com> wrote:

> Jay Soffian <jaysoffian@gmail.com> writes:
> 
> > On Sun, Apr 19, 2009 at 9:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Now the real question was if we still support anything older, and if so
> > > what is the bottom version?
> > >
> > > I certainly can go with "5.8.1 or later", but I vaguely recall during the
> > > gitweb discussion we said anything without the utf-8 support is unusable
> > > for gitweb, but I think we also said that the rest of the git codebase
> > > should support running with something older (5.6.1, perhaps).
> 
> > So here's my take-away. For the *.perl scripts and gitweb, it's
> > 5.8.0. For the test suite and Git.pm, all Perl versions are
> > theoretically supported, but for practical purposes, it may be
> > 5.6.0.
> 
> Errr... no.  For gitweb we require good Unicode support, which means
> Perl 5.8.x (IIRC 5.8.1).  For all other: commands (and helpers)

Unicode? 5.8.4 or up. Most desirable 5.8.5
5.8.1 is the worst distribution ever.

ask purl on irc :
 <Tux> purl, perl-5.8.1?
<purl> i guess perl-5.8.1 is made from blood, sweat, tears, coffee and single malt

> written in Perl like git-svn, fragments of Perl in test suite (because
> of incompatibility and corner cases of shell scripting) - with possible
> exception of testing gitweb, and Git.pm (which some commands in Perl
> use) I think it is reasonable to expect 5.6.0 at least.

5.6.1 or 5.8.5

> > Whatever is decided this time, perhaps it should be burned into the tops of
> > the *.perl scripts (i.e. "require 5.008;"). It should also be added to
> > CodingGuidelines. You know, so this conversation doesn't keep recurring. :-)

-- 
H.Merijn Brand  http://tux.nl      Perl Monger  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, OpenSuSE 10.3, 11.0, and 11.1, AIX 5.2 and 5.3.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
