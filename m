From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: "Publishing your work" questions?
Date: Sat, 20 Aug 2005 14:57:00 +0100
Message-ID: <200508201457.00725.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Aug 20 15:58:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6TqQ-0007Wb-Dc
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 15:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVHTN46 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 20 Aug 2005 09:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVHTN45
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Aug 2005 09:56:57 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:61837
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932242AbVHTN45 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Aug 2005 09:56:57 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1E6TqC-0000uB-NK
	for git@vger.kernel.org; Sat, 20 Aug 2005 14:56:56 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I am planning my way through switching over to using git (as opposed to=
=20
subversion - via svnserve) to publish some stuff.

At the moment I leave a hole in my firewall for port 3690 and svnserve =
is run=20
as a daemon from inetd. =A0I use svnserve's own user/realm management t=
o limit=20
the repositories I make public.

If I switch over to git, I assume I run git-daemon from inetd.

BUT

a) Is this what the git://my.domain.com/path/to/repository url refers t=
o=20
(neither get-pull-script nor git-fetch-script man pages actually say wh=
at=20
this form means) ?

b) I can't find any mention in the documentation of what the default po=
rt=20
should be. What is it?

c) Is git-daemon multithreaded (ie do I use nowait in inetd.conf)?

d) Is it possible to ensure that external accesses can't access anywher=
e in my=20
filesystem?=20

e) If I put my public key in ~git/.ssh/authorized_keys on the server, I=
 can=20
act as user git on the server via ssh. =A0Does git push support this? =A0

f) If I can do e), then perhaps [need to read the docs a bit harder] I =
can set=20
up my user git on the machine to use git-receive-pack as its login shel=
l. =A0
Will this work? - the tutorial talks about needing .bashrc to set up th=
e=20
$PATH environment, but are there any other hidden gotchas?

--=20
Alan Chandler
http://www.chandlerfamily.org.uk
