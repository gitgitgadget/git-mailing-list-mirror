From: "Senthil Natarajan" <snatarajan@stoke.com>
Subject: git merge heuristic
Date: Fri, 22 Mar 2013 11:53:04 -0700
Message-ID: <ECEA5ACFB4B2BC4A81A93F032519ABCAD47F79@minsk.us.stoke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 19:53:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ75s-0008Mh-Up
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 19:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab3CVSxI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Mar 2013 14:53:08 -0400
Received: from mail1.stoke.com ([209.78.40.3]:45394 "EHLO mail1.stoke.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754565Ab3CVSxH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Mar 2013 14:53:07 -0400
X-ASG-Debug-ID: 1363978386-04870b01e91857840001-QuoKaX
Received: from minsk.us.stoke.com ([172.16.4.20]) by mail1.stoke.com with ESMTP id VYEgIKS1hrWwI5Ux for <git@vger.kernel.org>; Fri, 22 Mar 2013 11:53:06 -0700 (PDT)
X-Barracuda-Envelope-From: snatarajan@stoke.com
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: git merge heuristic
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git merge heuristic
Thread-Index: Ac4nKxBfzbHH9MmETKGUj3nbF0j1XQAA1nqQ
X-Barracuda-Connect: UNKNOWN[172.16.4.20]
X-Barracuda-Start-Time: 1363978386
X-Barracuda-URL: http://mail1.stoke.com:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at stoke.com
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.125932
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218836>

Hi all,

I want to learn about how Git compares patches while doing a merge.=A0 =
=46or example, if a patch has been cherry-picked from branch A to branc=
h B, and then downstream we do a "git merge" from A to B, how does Git =
know to skip the cherry-picked patch?=A0 It would have a different SHA-=
1, so what is the comparison algorithm/heuristic?=A0 What happens if th=
e comment is different, but the actual patch is identical?

I searched around, but couldn't find information on this.=A0 I would ap=
preciate it if someone could point me in the right direction.

Thanks!

-Senthil
