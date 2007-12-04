From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 4 Dec 2007 23:25:42 +0100
Message-ID: <20071204232542.425d2ead@pc09.procura.nl>
References: <20071204130922.731c407a@pc09.procura.nl>
	<Pine.LNX.4.64.0712041343040.27959@racer.site>
	<20071204140326.14d9e7a0@pc09.procura.nl>
	<Pine.LNX.4.64.0712041439590.27959@racer.site>
	<20071204150102.7f3ec3e9@pc09.procura.nl>
	<47556EE2.6040105@op5.se>
	<20071204152240.6cb6018e@pc09.procura.nl>
	<Pine.LNX.4.64.0712041536180.27959@racer.site>
	<20071204155655.053f4fb4@pc09.procura.nl>
	<7vve7e49or.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 23:28:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzgG8-00043M-Tg
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 23:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbXLDW2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 17:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbXLDW2g
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 17:28:36 -0500
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:4631 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbXLDW2e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 17:28:34 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id lB4MPham003995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Dec 2007 23:25:43 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <7vve7e49or.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.1.0cvs51 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67094>

On Tue, 04 Dec 2007 10:05:40 -0800, Junio C Hamano <gitster@pobox.com> wrote:

> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> 
> > On Tue, 4 Dec 2007 15:39:47 +0000 (GMT), Johannes Schindelin
> > ...
> > I found it! unset returns false
> > ...
> > I must leave now.
> 
> Thanks, you two.
> 
> I do not see "unset VAR... &&" outside t0001 test, but there are
> instances of "unset VAR... &&" in git-submodule implementations as well.
> 
> In short, not too many places to fix.

Going from there ....

# make test
:
:
:
*** t1300-repo-config.sh ***
*   ok 1: initial
*   ok 2: mixed case
*   ok 3: similar section
*   ok 4: similar section
*   ok 5: replace with non-match
*   ok 6: replace with non-match (actually matching)
*   ok 7: non-match result
*   ok 8: multiple unset
*   ok 9: multiple unset is correct
*   ok 10: --replace-all
*   ok 11: all replaced
*   ok 12: really mean test
*   ok 13: really really mean test
*   ok 14: get value
*   ok 15: unset
*   ok 16: multivar
* FAIL 17: non-match
        git config --get nextsection.nonewline !for
* FAIL 18: non-match value
        test wow = $(git config --get nextsection.nonewline !for)
*   ok 19: ambiguous get
*   ok 20: get multivar
*   ok 21: multivar replace
*   ok 22: ambiguous value
*   ok 23: ambiguous unset
*   ok 24: invalid unset
*   ok 25: multivar unset
*   ok 26: invalid key
*   ok 27: correct key
*   ok 28: hierarchical section
*   ok 29: hierarchical section value
*   ok 30: working --list
*   ok 31: --get-regexp
*   ok 32: --add
*   ok 33: get variable with no value
*   ok 34: get-regexp variable with no value
*   ok 35: no arguments, but no crash
*   ok 36: new section is partial match of another
*   ok 37: new variable inserts into proper section
*   ok 38: alternative GIT_CONFIG (non-existing file should fail)
*   ok 39: alternative GIT_CONFIG
*   ok 40: alternative GIT_CONFIG (--file)
*   ok 41: --set in alternative GIT_CONFIG
*   ok 42: rename section
*   ok 43: rename succeeded
*   ok 44: rename non-existing section
*   ok 45: rename succeeded
*   ok 46: rename another section
*   ok 47: rename succeeded
*   ok 48: remove section
*   ok 49: section was removed properly
*   ok 50: section ending
*   ok 51: numbers
*   ok 52: bool
*   ok 53: invalid bool (--get)
*   ok 54: invalid bool (set)
*   ok 55: set --bool
*   ok 56: set --int
*   ok 57: quoting
*   ok 58: key with newline
*   ok 59: value with newline
*   ok 60: value continued on next line
* FAIL 61: --null --list
        cmp result expect
* FAIL 62: --null --get-regexp
        cmp result expect
*   ok 63: symlinked configuration
* failed 4 among 63 test(s)


-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
