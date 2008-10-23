From: Francis Galiegue <fge@one2team.com>
Subject: git-cvsimport bug? Newly created branch not seen unless there's at least one commit in it
Date: Thu, 23 Oct 2008 14:00:45 +0200
Organization: One2team
Message-ID: <200810231400.45734.fge@one2team.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 14:29:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KszK1-0007Ds-Jg
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 14:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbYJWM2h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Oct 2008 08:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbYJWM2g
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 08:28:36 -0400
Received: from ns35774.ovh.net ([213.251.185.197]:60420 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481AbYJWM2g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Oct 2008 08:28:36 -0400
X-Greylist: delayed 1666 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Oct 2008 08:28:36 EDT
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 6025B92C011
	for <git@vger.kernel.org>; Thu, 23 Oct 2008 14:00:42 +0200 (CEST)
Received: from erwin.olympe.o2t (erwin.olympe.o2t [192.168.1.21])
	by smtp.olympe.o2t (Postfix) with ESMTP id EE2AF7001F
	for <git@vger.kernel.org>; Thu, 23 Oct 2008 14:00:45 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98954>

Hello,

I've tried to git-cvsimport a module from CVS, where a branch named "fo=
o"=20
existed. CVSROOT set in the environment, CVS_RSH too, and I imported wi=
th:

git-cvsimport -k -a -C themodule themodule

However, it didn't do what I expected: I couldn't see the branch named =
"foo".

I had to make a commit using CVS on that very same module on that "foo"=
=20
branch. After the commit, out of curiosity, I executed the same git com=
mand=20
again in the same directory: this time the branch was seen.

Is this a bug, or is there a git-cvsimport option that I missed? I have=
 looked=20
at the manpage several times, and couldn't find what option could be of=
 any=20
use in my case (mind you, I haven't looked at the cvsps manpage either)=
=2E

Thanks,
--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob=A0: +33 (0) 6 83 87 78 75
Tel=A0: +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris
