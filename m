From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Subject: can not clone via git:// anymore
Date: Wed, 04 Mar 2009 12:24:34 +0100
Message-ID: <49AE64F2.1090405@cetrtapot.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 12:27:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LepGF-0006XM-F4
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 12:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbZCDL0M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 06:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbZCDL0K
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 06:26:10 -0500
Received: from zimbra-mta.cetrtapot.si ([89.212.80.172]:42559 "EHLO
	zimbra-mta.cetrtapot.si" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbZCDL0J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 06:26:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id 2AE1C19FA5E
	for <git@vger.kernel.org>; Wed,  4 Mar 2009 12:26:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra-mta.cetrtapot.si
Received: from zimbra-mta.cetrtapot.si ([127.0.0.1])
	by localhost (zimbra-mta.cetrtapot.si [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hWdwxmwTjsOW for <git@vger.kernel.org>;
	Wed,  4 Mar 2009 12:26:06 +0100 (CET)
Received: from [172.31.65.135] (unknown [192.168.66.2])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id C53F619FA5D
	for <git@vger.kernel.org>; Wed,  4 Mar 2009 12:26:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112206>

Hi,

I've recently discovered that my GIT repository is not letting me clone=
 it via git clone git://.
It works using git clone git@.. (SSH) but with GIT protocol..

Here is the case:
hinkok@alala /tmp $ git --version
git version 1.6.0.6
hinkok@alala /tmp $ git clone git://zidar/sdk.git
Initialized empty Git repository in /tmp/sdk/.git/
fatal: The remote end hung up unexpectedly

My earlier clone (few months old) has this in .git/config:
hinkok@alala /work/git/sdk.git $ cat .git/config=20
[core]
	repositoryformatversion =3D 0
	filemode =3D true
	bare =3D false
	logallrefupdates =3D true
[remote "origin"]
	url =3D git@zidar:repositories/sdk.git
	fetch =3D +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote =3D origin
	merge =3D refs/heads/master


But I remember cloning via SSH that time, because I needed git push to =
work,
but now other developer do not need the SSH access, but only GIT read-o=
nly -
they can only clone, not push.

I do not administer the server git repos is located on, so I must have =
some
information before I attack the admin..

Thank you,
Hinko

--=20
Hinko Ko=E8evar, OSS developer
=C8ETRTA POT, d.o.o.
Planina 3, 4000 Kranj, SI EU
tel     ++386 (0) 4 280 66 03
e-mail  hinko.kocevar@cetrtapot.si
http    www.cetrtapot.si
