From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Feature suggestion: git-hist
Date: Wed, 30 Jul 2008 15:58:35 +0200
Message-ID: <20080730155835.71289eee@pc09.procura.nl>
References: <20080730133859.368bbd92@pc09.procura.nl>
	<20080730133334.GB31192@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lars Noschinski <lars-2008-1@usenet.noschinski.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 15:59:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOCDL-0006YL-2E
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 15:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbYG3N6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 09:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbYG3N6i
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 09:58:38 -0400
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:1310 "EHLO
	smtp-vbr15.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbYG3N6i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 09:58:38 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr15.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6UDwals017669
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2008 15:58:36 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <20080730133334.GB31192@lars.home.noschinski.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90789>

On Wed, 30 Jul 2008 15:33:34 +0200, Lars Noschinski
<lars-2008-1@usenet.noschinski.de> wrote:

> * H.Merijn Brand <h.m.brand@xs4all.nl> [08-07-30 13:38]:
> 
> >	I can ask them what version they have, and I can then check if
> >	the complaint was already addressed in an update that was
> >	already released. In SCCS this was easy: they tell me the output
> >	of the what command, I check if the bug was fixed in a newer
> >	version and the answer is present. No such luck in git, as the
> >	stamps are (non-sequitive) SHA id's. As we moved to git, we now
> >	have to update those id's by hand, as the customers are used to
> >	it. (At least we can now use readable date formats)
> 
> Hm, what about "git-describe --contains $SHA_OF_BUGFIX"?

If you come from a SCCS environment, the developers are used to see the
version of a single file, not of the id of a fix. One of the reasons we
moved from SCCS to git, is that we now can commit a group of files as a
single commit, and later look at the complete picture.

We are not used to working with $SHA's, and IMHO from the end-user pov,
a $SHA is less user friendly than a release number or a file version. I
can remember a version, but I cannot remember a SHA.

The end user only has the application, which is (or at least should be)
able to spit out its release version.  That is all we can go by when we
dig back into the history to see where we changed things.

One (very) big disadvantage of  SCCS  is that commits are on a per-file
basis, and only in a single directory. This drawback still haunts me in
git, as my first attempts to convert were successful in a single folder
and git cannot merge folders into a single project.

Say I now have

/work/src/project/.git
/work/src/project/module_a/.git
/work/src/project/module_b/.git
/work/src/project/module_c/.git

Which are all converted repos from SCCS, I'd like to merge the three
module_# repos into the top level repo.

-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
