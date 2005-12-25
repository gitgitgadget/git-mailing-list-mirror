From: M_ <barra_cuda@katamail.com>
Subject: Re: Add a "git-describe" command
Date: Sun, 25 Dec 2005 20:21:09 +0100
Message-ID: <200512252021.09481.barra_cuda@katamail.com>
References: <Pine.LNX.4.64.0512241339120.14098@g5.osdl.org> <Pine.LNX.4.64.0512241409300.14098@g5.osdl.org>
Reply-To: barra_cuda@katamail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Dec 25 20:13:16 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqbIx-0000MO-H1
	for gcvg-git@gmane.org; Sun, 25 Dec 2005 20:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbVLYTNI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 25 Dec 2005 14:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbVLYTNI
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Dec 2005 14:13:08 -0500
Received: from fe-3a.inet.it ([213.92.5.105]:47768 "EHLO fe-3a.inet.it")
	by vger.kernel.org with ESMTP id S1750897AbVLYTNG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2005 14:13:06 -0500
Received: from dial-up-mi-165.lombardiacom.it ([::ffff:212.34.225.165]) by fe-3a.inet.it via I-SMTP-5.2.3-521
	id ::ffff:212.34.225.165+xgA3JxXgOh; Sun, 25 Dec 2005 20:13:03 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <Pine.LNX.4.64.0512241409300.14098@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14050>

Alle 23:13, sabato 24 dicembre 2005, Linus Torvalds ha scritto:
> =A0- it should notice when "git-describe" doesn't exist, and fall bac=
k on
> =A0 =A0the old less-than-descriptive behaviour

And something like this?

GIT_VERSION =3D $(shell (git-describe HEAD || echo "1.0.GIT") | sed 's:=
refs/tags/::')
