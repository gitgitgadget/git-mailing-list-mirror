From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 4 Dec 2007 15:11:47 +0000
Message-ID: <20071204151147.3bda2292@pc09.procura.nl>
References: <20071204130922.731c407a@pc09.procura.nl>
	<Pine.LNX.4.64.0712041343040.27959@racer.site>
	<20071204140326.14d9e7a0@pc09.procura.nl>
	<Pine.LNX.4.64.0712041439590.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 04 16:13:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzZSL-00037Z-7U
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 16:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355AbXLDPLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 10:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754322AbXLDPLw
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 10:11:52 -0500
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:4592 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbXLDPLv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 10:11:51 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id lB4FBm4A030792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Dec 2007 16:11:48 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <Pine.LNX.4.64.0712041439590.27959@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67052>

On Tue, 4 Dec 2007 14:40:47 +0000 (GMT), Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Tue, 4 Dec 2007, H.Merijn Brand wrote:
> 
> > On Tue, 4 Dec 2007 13:44:02 +0000 (GMT), Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > 
> > > Hi,
> > > 
> > > On Tue, 4 Dec 2007, H.Merijn Brand wrote:
> > > 
> > > > make test then fails:
> > > 
> > > Could you run the failing test manually with -i -v, like so:
> > > 
> > > 	$ cd t/
> > > 	$ sh t0001*.sh -i -v
> > 
> > /pro/3gl/LINUX/git-1.5.3.7 183 > cd t
> > /pro/3gl/LINUX/git-1.5.3.7/t 184 > sh t0001*.sh -i -v
> > * error: cannot run git init -- have you built things yet?
> > Exit 1
> > /pro/3gl/LINUX/git-1.5.3.7/t 185 >
> 
> Next step: add the sh option -x:
> 
> 	$ sh -x t0001*.sh -i -v

After I did # make git
and         # make test

# cd t
# h -x t0001*.sh -i -v
:
:
+ + pwd
GIT_EXEC_PATH=/pro/3gl/LINUX/git-1.5.3.7/t/..
+ + pwd
GIT_TEMPLATE_DIR=/pro/3gl/LINUX/git-1.5.3.7/t/../templates/blt
+ GIT_CONFIG=.git/config
+ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG
+ + pwd
+ pwd
GITPERLLIB=/pro/3gl/LINUX/git-1.5.3.7/t/../perl/blib/lib:/pro/3gl/LINUX/git-1.5.
3.7/t/../perl/blib/arch/auto/Git
+ export GITPERLLIB
+ test -d ../templates/blt
+ test -x ../test-chmtime
+ test=trash
+ rm -fr trash
+ test_create_repo trash
+ cd trash
+ + expr ./t0001-init.sh : .*/\(t[0-9]*\)-[^/]*$
this_test=t0001
+ test_expect_success plain
        (
                unset GIT_DIR GIT_WORK_TREE &&
                mkdir plain &&
                cd plain &&
                git init
        ) &&
        check_config plain/.git false unset

* expecting success:
        (
                unset GIT_DIR GIT_WORK_TREE &&
                mkdir plain &&
                cd plain &&
                git init
        ) &&
        check_config plain/.git false unset

* FAIL 1: plain

                (
                        unset GIT_DIR GIT_WORK_TREE &&
                        mkdir plain &&
                        cd plain &&
                        git init
                ) &&
                check_config plain/.git false unset


> to find out what made it fail.
> 
> Thanks,
> Dscho
> 
> 


-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
