From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 09:05:54 +0100
Message-ID: <20090327090554.5d6160f2@pc09.procura.nl>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 09:15:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln7E9-0004Gg-D7
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 09:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509AbZC0INK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 04:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757395AbZC0INJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 04:13:09 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:1937 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbZC0INF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 04:13:05 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Mar 2009 04:13:04 EDT
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id n2R85tRH094885
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 27 Mar 2009 09:05:55 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-Mailer: Claws Mail 3.7.1cvs20 (GTK+ 2.14.4; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114872>

On Fri, 27 Mar 2009 08:21:36 +0100, "Ulrich Windl"
<ulrich.windl@rz.uni-regensburg.de> wrote:

> What I'd like to see in git (My apologies if some were already discussed to 
> death):
> 
> 1) The ability to use the file's time at the time of add/commit instead of
>    the current time, and the ability tho check outfiles with the times stored
>    in the repository.
> 
> 2) Keyword substitution. I know it's controverse (dealing with binary files),
>    but I'd like to have some automatic version numbering keyword at least:
>    Initial idea is that every commit with a change increments the number by
>    one, and when merging numbers a and b, the resulting number is max(a, b) + 1.

impossible. Even with checkin- and checkout hooks, you won't get that
SCCS behaviour. They have to be better in something too :)
/me still misses that but got used to it

> 3) "git undo": If possible undo the effects of the last command.
> 
> Following are some random remarks from a first-time git user, regarding the 
> buld/install:
> 
> Notes on building git-1.6.1.3 on openSUSE 11.0:
> There is no "asciidoc"; the INSTALL should be more verbose on special
> requirements (i.e. additional packages needed, and where to get them).

# zypper in asciidoc libcurl-devel

(yes, 'make install-man' should stop soon after detecting asciidoc is
not installed


-- 
H.Merijn Brand  http://tux.nl      Perl Monger  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.3, 11.0, and 11.1, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
