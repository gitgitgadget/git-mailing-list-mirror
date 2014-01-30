From: Vincent Bernardi <vincent@kameleoon.com>
Subject: Strange merge output.
Date: Thu, 30 Jan 2014 11:52:27 +0100
Message-ID: <55DE3FAC-BD7E-4AB2-8A18-CF85BB859465@kameleoon.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 30 12:04:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8pQN-0002oy-22
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 12:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbaA3LEn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jan 2014 06:04:43 -0500
Received: from ns3269353.ovh.net ([37.59.55.141]:34731 "EHLO
	utumno.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752671AbaA3LEm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jan 2014 06:04:42 -0500
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jan 2014 06:04:42 EST
Received: from [192.168.0.12] (APuteaux-652-1-133-147.w82-124.abo.wanadoo.fr [82.124.116.147])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by utumno.localdomain (Postfix) with ESMTPSA id 9D081E024E
	for <git@vger.kernel.org>; Thu, 30 Jan 2014 11:58:42 +0100 (CET)
X-Mailer: Apple Mail (2.1827)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241265>

Hi,
I asked about this problem on #git@freenode and someone suggested I sub=
mit it to this list. I have a case where the output of a merge gives a =
conflict and produces the following file:

Code Block A
<<<<<<< HEAD
=3D=3D=3D=3D=3D=3D=3D
Code Block B
>>>>>>> branch-B
Code Block B' (similar to code block B but not exactly the same).

Here is what HEAD looks like=20
Code Block A
Code Block B'=20

and branch-B:
Code Block A
Code Block B

I thought that taking a conflicted file like above and removing the thr=
ee following lines:
<<<<<<< HEAD
=3D=3D=3D=3D=3D=3D=3D
>>>>>>> branch-B

was supposed to produce *exactly* the branch-B version?

1=B0/ was I wrong to believe this implied promise?
2=B0/ if not, is this a known problem with git merge's default recursiv=
e strategy? (I didn't change any default configuration about merging).
3=B0/ If yes to question 2=B0/, is there a known workaround for it? I a=
m trying to move my team to git, but we already have a hard time unders=
tanding how it works. I'm really hoping it's a case of us not understan=
ding things and not a bug :-)

Thanks in advance for any answer, I'm willing to answer any question to=
 help create a test case for this.

Vincent Bernardi

P.S.: I am using git 1.8.3.4
-----
The Kameleoon team.
http://www.kameleoon.com