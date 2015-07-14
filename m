From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: AW: "unable to remap" error with git svn after upgrade to Win10
Date: Tue, 14 Jul 2015 10:37:03 +0200
Organization: gmx
Message-ID: <cca8143375b9134b7a29f3748a3c4389@www.dscho.org>
References: <8e6220ba0ffb43dbbc7c4eaefd2ab753@CIPEXMB03N1.ci04.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christoph Murczek <Christoph.Murczek@iteratec.at>
X-From: git-owner@vger.kernel.org Tue Jul 14 10:37:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEviI-0002E9-DD
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 10:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbbGNIhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 04:37:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:57848 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753231AbbGNIhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 04:37:06 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M8eAd-1Z2Mm43UQd-00wBUw; Tue, 14 Jul 2015 10:37:03
 +0200
In-Reply-To: <8e6220ba0ffb43dbbc7c4eaefd2ab753@CIPEXMB03N1.ci04.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:9hsBU96CjUsA/Pj11FNJUqGBDdjAhbY9XA1vu3H5eiVcz9Gil4H
 YIlsIb+KZvJ1UFLUuYQwS2o2/bs1wkg1D0cNvMDDEANBGn7s9HD2tBIK7bRixJvACK1qjyO
 aAaCYpCGH7SYh3kDprEggmQ78OANo+9C6Xm6G4ETKkhrKeoyZfNKaDwW+NP55d1MdUxLgoa
 dmppKOfhFTS5XJPVxTn6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7IMRKIQnMk0=:NLaOO2PsGj3R7h/gtd7m7L
 bynEce7PyrObwhaCxiwnYnd+BLFPvYx0J2d6I+XY29MMqtFES+TXOolzX9xsf22PevIsgnbvS
 hAJHrZbpc3loPFYFmMxEsIHxYTYu+wxhFMUJRZo1IVAYok7LEdd6jEZsG5xrGeKm0HJqVDrcH
 ClAU9ElxLgxQjCbq9OgM18zhOAY1w3hK1p5hHS2Ubp51/NkX6OAjUuu8tG2xCI19863/g4fdl
 yTBsfSxMuiMGfX/8oiQloh29uJP01kQ4myhuYWZtaG0YQhnhsBNEz7eb2abZgDEf/fbs4vMjW
 uCDjiGZhmKoKsh/bMHDLOofFrkLC0GBjpTLaV1OCkFKcl4nt+2tp2rwWE0UJUo1T/YIMibgCB
 0nBCxFifupXru3dOJpYSkhLrOCai9wqXuM4/tdt9lPqJCUzVd/r09FsWFeeOFtMgPWI6YZiub
 L8shEqymu4n6CUFPyS1AWqJ9sngZWuwsnffJa24Yl6WSb64t3HurO+RLSmrocNIZezyuGTsRI
 E8zIhtGot9YayjALR/cLBaJiFM0iuK0tOgGqEeog78UngNS/vhlqKrzh/vujImOGNaYNgq5ew
 q4ZfuAjxr3/pptBxTokjLdal88Uy5wjiGDE7FHDZaq7yyvyA+t3cK/v1o4MIOIQpdbpgOZ+8+
 IUzSF18tsrqDHkkyZououS9DBr7sg63OGTZa7pQghNyYHGB1GoH0PzOpl3iqnniKevhc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273941>

Hi Christoph,

On 2015-07-13 14:24, Christoph Murczek wrote:
> Just wanted to let you know: a re-install of git also fixed the problem.

That is probably because your original report (which I do not quote because that was made too inconvenient by top-posting, sorry) suggests that the culprit was overlapping `.dll` ranges that need to be fixed using the `rebase.exe` tool (which is confusingly completely unrelated to `git rebase`), and that step is part of the installing process.

BTW assuming that you're on a 64-bit setup (Win10 and all...), why do you stick to the 32-bit version of Git for Windows?

Ciao,
Johannes
