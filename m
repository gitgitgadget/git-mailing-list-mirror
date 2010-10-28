From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: git-svn tests fail since 1.7.2.2
Date: Thu, 28 Oct 2010 22:32:54 +0200
Message-ID: <20101028223254.25c0241a@pc09.procura.nl>
References: <20101028122857.3c8d3f4d@pc09.procura.nl>
	<20101028175648.GA14212@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 22:33:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBZ9p-00054P-OY
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 22:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933797Ab0J1UdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 16:33:05 -0400
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:1253 "EHLO
	smtp-vbr7.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933685Ab0J1UdD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Oct 2010 16:33:03 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id o9SKWtn1032194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 28 Oct 2010 22:32:56 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <20101028175648.GA14212@burratino>
X-Mailer: Claws Mail 3.7.6cvs59 (GTK+ 2.18.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160222>

On Thu, 28 Oct 2010 12:56:48 -0500, Jonathan Nieder
<jrnieder@gmail.com> wrote:

> Hi,
> 
> H.Merijn Brand wrote [snipped somewhat]:
> 
> > Up to and including 1.7.2.1, all went smooth and fine, but as of
> > 1.7.2.2 (and 1.7.3.1 and 1.7.3.2), the tests started to fail on svn
> > issues.
> >
> > t9101-git-svn-props.sh                           (Wstat: 256 Tests: 26 Failed: 3)
> >   Failed tests:  24-26
> > t9143-git-svn-gc.sh                              (Wstat: 256 Tests: 11 Failed: 1)
> >   Failed test:  10
> >
> > These tests fail on *all* my Linux boxes, which happen to be OpenSUSE
> > ranging from 11.0 to 11.3.
> >
> > OpenSUSE 11.0/64:
> > + svn, version 1.5.7 (r36142)
> > 
> > OpenSUSE 11.2/64:
> > + svn, version 1.6.6 (r40053)
> > 
> > OpenSUSE 11.3/32:
> > + svn, version 1.6.9 (r901367)
> 
> Any idea what error message or command they fail at?  Useful commands
> to try might be
> 
>  sh t9101-git-svn-props.sh -v

ok 23 - test show-ignore

expecting success:
        git svn fetch && git pull . remotes/git-svn &&
        git svn create-ignore &&
        cmp ./.gitignore create-ignore.expect &&
        cmp ./deeply/.gitignore create-ignore.expect &&
        cmp ./deeply/nested/.gitignore create-ignore.expect &&
        cmp ./deeply/nested/directory/.gitignore create-ignore.expect &&
        git ls-files -s | grep gitignore | cmp - create-ignore-index.expect

        A       deeply/nested/directory/.keep
r8 = ddf07d64e9879c7d8f730b781596e1a6cf5d413b (refs/remotes/git-svn)
From .
 * remote branch     git-svn    -> FETCH_HEAD
Updating eff953b..ddf07d6
Fast-forward
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 deeply/nested/directory/.keep
-: No such file or directory
not ok - 24 test create-ignore
#
#               git svn fetch && git pull . remotes/git-svn &&
#               git svn create-ignore &&
#               cmp ./.gitignore create-ignore.expect &&
#               cmp ./deeply/.gitignore create-ignore.expect &&
#               cmp ./deeply/nested/.gitignore create-ignore.expect &&
#               cmp ./deeply/nested/directory/.gitignore create-ignore.expect &&
#               git ls-files -s | grep gitignore | cmp - create-ignore-index.expect
#

expecting success:
        git svn propget svn:ignore . | cmp - prop.expect &&
        cd deeply &&
        git svn propget svn:ignore . | cmp - ../prop.expect &&
        git svn propget svn:entry:committed-rev nested/directory/.keep    | cmp - ../prop2.expect &&
        git svn propget svn:ignore .. | cmp - ../prop.expect &&
        git svn propget svn:ignore nested/ | cmp - ../prop.expect &&
        git svn propget svn:ignore ./nested | cmp - ../prop.expect &&
        git svn propget svn:ignore .././deeply/nested | cmp - ../prop.expect

-: No such file or directory
error: git-svn died of signal 13
not ok - 25 test propget
#
#               git svn propget svn:ignore . | cmp - prop.expect &&
#               cd deeply &&
#               git svn propget svn:ignore . | cmp - ../prop.expect &&
#               git svn propget svn:entry:committed-rev nested/directory/.keep   | cmp - ../prop2.expect &&
#               git svn propget svn:ignore .. | cmp - ../prop.expect &&
#               git svn propget svn:ignore nested/ | cmp - ../prop.expect &&
#               git svn propget svn:ignore ./nested | cmp - ../prop.expect &&
#               git svn propget svn:ignore .././deeply/nested | cmp - ../prop.expect
#

expecting success:
        git svn proplist . | cmp - prop.expect &&
        git svn proplist nested/directory/.keep | cmp - prop2.expect

-: No such file or directory
error: git-svn died of signal 13
not ok - 26 test proplist
#
#               git svn proplist . | cmp - prop.expect &&
#               git svn proplist nested/directory/.keep | cmp - prop2.expect
#

# failed 3 among 26 test(s)
1..26
Exit 1

Right, If I would have thought of that myself, I would not have had to report
the issue. My system seems to have a non-standard "cmp" that seems to
have been chosen over the system one. That cmp does not handle -.

Problem solved:

ok 26 - test proplist

# passed all 26 test(s)
1..26

> and
> 
>  sh -x t9101-git-svn-props.sh -v -i
> 
> Thanks for reporting,
> Jonathan


-- 
H.Merijn Brand  http://tux.nl      Perl Monger  http://amsterdam.pm.org/
using 5.00307 through 5.12 and porting perl5.13.x on HP-UX 10.20, 11.00,
11.11, 11.23 and 11.31, OpenSuSE 10.1, 11.0 .. 11.3 and AIX 5.2 and 5.3.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
