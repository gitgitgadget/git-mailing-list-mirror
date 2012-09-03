From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Clone to an SSH destination
Date: Mon, 03 Sep 2012 16:27:29 +0200 (CEST)
Message-ID: <a39bec83-ea05-462d-9b62-f01d4246ffc1@zcs>
References: <alpine.LFD.2.01.1209031351200.5945@sys880.ldn.framestore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Mark Hills <Mark.Hills@framestore.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 16:27:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8Xco-00035q-Mc
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 16:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173Ab2ICO1c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Sep 2012 10:27:32 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:20071 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932131Ab2ICO1b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2012 10:27:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 774024609AF;
	Mon,  3 Sep 2012 16:27:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4+auci7AXhqR; Mon,  3 Sep 2012 16:27:29 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id D3BAE4609AA;
	Mon,  3 Sep 2012 16:27:29 +0200 (CEST)
In-Reply-To: <alpine.LFD.2.01.1209031351200.5945@sys880.ldn.framestore.com>
X-Originating-IP: [91.43.180.222]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC18 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204698>

Hi,

> Without a command-line onto the filesystem (either local or NFS), how
> do you create a new repository for a new project?

These things are out of the scope of git itself, they belong to another
layer - you're probably looking for some repo hosting solution.

One already was mentioned: gitolite. Another one is gitosis.

> We have a fairly large team on a diverse set of projects. Projects
> come and go, so it's a burden if the administrator is needed just to
> create repos.

Maybe you'd also like to have some project management / ticketing
tool. We've got an redmine and gitolite based solution for that,
that's automatically creating repos and managing access control
on per-project basis. Will be publically released in a few days,
just drop a note if you're interested in it.

> Most projects start as a small test at some point; eg.
>=20
>   mkdir xx
>   cd xx
>   git init
>   <write some code>
>   git commit
>   ...
>=20
> When a project becomes more official, the developer clones to a
> central
> location; eg.
>=20
>   git clone --bare . /net/git/xx.git

Do you have any kind of access control in place, or can everybody
write just everywhere ?


cu
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
