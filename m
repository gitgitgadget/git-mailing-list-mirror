From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Workflow for templates?
Date: Sat, 10 Nov 2012 11:29:33 +0100 (CET)
Message-ID: <7f1bbe94-b3f6-4728-960d-19e89e8e4166@zcs>
References: <F9FF8107FA8F4CBD8C3D87B907BAE9E3@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Josef Wolf <jw@raven.inka.de>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 11:29:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TX8K4-0002Mx-52
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 11:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021Ab2KJK3f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 05:29:35 -0500
Received: from zcs.vnc.biz ([83.144.240.118]:63858 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab2KJK3e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 05:29:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id E1800622260;
	Sat, 10 Nov 2012 11:29:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CJSA3eGyDP5n; Sat, 10 Nov 2012 11:29:33 +0100 (CET)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 73E16622259;
	Sat, 10 Nov 2012 11:29:33 +0100 (CET)
In-Reply-To: <F9FF8107FA8F4CBD8C3D87B907BAE9E3@PhilipOakley>
X-Originating-IP: [91.43.209.211]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209268>


> This is often the key point that requires the 'new mindset'. Most
> folk
> use/used the directory heirarchy (subtle distinction with the .git
> 'repo' directory heirarchy to be noted) as a way of separating
> ownership
> between groups. They find it very hard to undo the old mindset and
> use
> branches _instead of_ directories for the different group
> configurations.

hmm, is this really a psychological issue ?

well, many years ago, i've seen a talk about git (maybe by linus himsel=
f),
which started with something like "forget everything you know abozt scm=
" ...

> > By the way: you really should use non-conflicting tag names (eg.
> > adding some <site>+"/" or <site>+"-" prefix), otherwise you'll
> > easiy run into conflicts, because per default retrieved and local
> > tags will all be in some namespace
> >          Better consider tag names to be really global.
>=20
> Definitely.

Well, you *could* setup special fetch rules, which put tags from separa=
te
repos to separate namespaces, but i'd really advice against that, as it=
's
too easy to forget something and again mess it up.

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
