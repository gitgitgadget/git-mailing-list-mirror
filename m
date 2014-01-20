From: =?utf-8?B?UGF3ZcWC?= Sikora <pawel.sikora@agmk.net>
Subject: problematic git log submodule-dir/
Date: Mon, 20 Jan 2014 19:25:17 +0100
Message-ID: <2550653.GHkhBQDSTk@localhost.localdomain>
Reply-To: pawel.sikora@agmk.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 20 19:42:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5JnZ-0005XD-Ay
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 19:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbaATSmJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jan 2014 13:42:09 -0500
Received: from adamg.eu ([91.192.224.99]:54580 "EHLO adamg.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbaATSmI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jan 2014 13:42:08 -0500
X-Greylist: delayed 1002 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jan 2014 13:42:07 EST
Received: from mail.agmk.net ([91.192.224.71]:43083)
	by adamg.eu with esmtp (Exim 4.82)
	(envelope-from <pluto@agmk.net>)
	id 1W5JXG-0007N2-4I
	for git@vger.kernel.org; Mon, 20 Jan 2014 19:25:22 +0100
Received: from localhost.localdomain (unknown [185.28.248.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pluto@agmk.net)
	by mail.agmk.net (Postfix) with ESMTPSA id 360451B20BAD
	for <git@vger.kernel.org>; Mon, 20 Jan 2014 19:25:13 +0100 (CET)
User-Agent: KMail/4.11.5 (Linux/3.13.0-0.rc8.git4.2.fc21.x86_64; KDE/4.11.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240723>

Hi all.

i've noticed that 'git log submodule-dir' and 'git log submodule-dir/'
return different results (module's head changes vs. nothing). is it a b=
ug?
looks like a trailing slash is a problem for git-log.

tested on git-1.8.5.3-2.fc20.x86_64.

BR,
Pawe=C5=82.

--=20
gpg key fingerprint =3D 60B4 9886 AD53 EB3E 88BB 1EB5 C52E D01B 683B 94=
11
