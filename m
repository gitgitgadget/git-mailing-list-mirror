From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Install issues
Date: Tue, 11 Nov 2008 19:02:43 +0100
Message-ID: <20081111190243.7044d6cb@pc09.procura.nl>
References: <20081110121739.15f77a01@pc09.procura.nl>
	<20081110113924.GR24201@genesis.frugalware.org>
	<20081110173101.3d76613b@pc09.procura.nl>
	<20081110175123.GV24201@genesis.frugalware.org>
	<7vhc6e17fv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 19:08:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzxdc-00030Z-MB
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 19:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbYKKSF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 13:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbYKKSF3
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 13:05:29 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:2675 "EHLO
	smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbYKKSF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 13:05:28 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id mABI2h5r052295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 11 Nov 2008 19:02:44 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <7vhc6e17fv.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.6.1cvs12 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100664>

On Tue, 11 Nov 2008 09:47:00 -0800, Junio C Hamano <gitster@pobox.com>
wrote:

> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
> > On Mon, Nov 10, 2008 at 05:31:01PM +0100, "H.Merijn Brand" <h.m.brand@xs4all.nl> wrote:
> >> --- Makefile.org	2008-11-10 17:29:53.000000000 +0100
> >> +++ Makefile	2008-11-10 17:29:39.000000000 +0100
> >> @@ -1329,6 +1329,10 @@ check-sha1:: test-sha1$X
> >>  	./test-sha1.sh
> >>  
> >>  check: common-cmds.h
> >> +	@`sparse </dev/null 2>/dev/null` || (\
> >> +	    echo "The 'sparse' command is not available, so I cannot make the 'check' target" ;\
> >> +	    echo "Did you mean 'make test' instead?" ;\
> >> +	    exit 1 )
> >>  	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
> >
> > Please read Documentation/SubmittingPatches, your patch lacks a signoff
> > and a commit message.
> 
> Heh, for something small and obvious like this, that's asking a tad too
> much, although a properly formatted message does reduce my workload and is
> appreciated.

Junio++

> I said "obvious" not in the sense that it is "obviously good".  It is
> obvious what issue the patch wants to address.
> 
> Having said that, it is far from clear if special casing "make check" like
> this is a good thing, though.  The crufts resulting from "Four extra lines
> won't hurt" kind of reasoning can accumulate and snowball.  Is reading the
> Makefile when your build fails in order to see if the target was what you
> really wanted to invoke (ideally, it should rater be "_before_ running
> make, reading the Makefile to find out what you want to run") a lost art
> these days?

Not at all, and for me it was clear from the start, so I typed 'make
test' and went ahead.

It was that I am just all to aware of the GNU world that I can easily
imagine other people making the same mistake, and just thought it
end-user-friendly to do as I proposed.

I'm by now way offended or scared away if you reject these kind of
patches

-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
