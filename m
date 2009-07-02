From: "Patrick Neuner - Futureweb.at" <neuner@futureweb.at>
Subject: AW: AW: AW: Parallell Development / Switching to GIT
Date: Thu, 2 Jul 2009 13:44:10 +0200
Message-ID: <B81058949321C8439B9D742F5F8D8FCA01A75D15@hpserver.intranet.local>
References: <loom.20090625T095000-90@post.gmane.org> <4A434D6F.2090105@op5.se> <B81058949321C8439B9D742F5F8D8FCA01A75C1D@hpserver.intranet.local> <20090628184714.GA8634@sigio.peff.net> <B81058949321C8439B9D742F5F8D8FCA01A75C33@hpserver.intranet.local> <4A487CCD.1040406@op5.se> <B81058949321C8439B9D742F5F8D8FCA01A75CFA@hpserver.intranet.local> <4A4C51B7.7010000@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Andreas Ericsson" <ae@op5.se>, "Jeff King" <peff@peff.net>,
	<git@vger.kernel.org>, "David Aguilar" <davvid@gmail.com>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 02 13:45:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMKj0-0002zE-6X
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 13:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbZGBLoP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2009 07:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754115AbZGBLoO
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 07:44:14 -0400
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:33910 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753578AbZGBLoK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 07:44:10 -0400
Received: from source ([80.109.165.251]) (using TLSv1) by eu1sys200aob115.postini.com ([207.126.147.11]) with SMTP
	ID DSNKSkydi5doOgLTFHKbNZSBBG5P/ff8Awhq@postini.com; Thu, 02 Jul 2009 11:44:14 UTC
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <4A4C51B7.7010000@viscovery.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: AW: AW: Parallell Development / Switching to GIT
Thread-Index: Acn63UAo3HJ1c3hAQvqEUjx7MqDqfQALJH9Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122636>

Hi,

ok, I see, well then this howto (at the end of page) seems to be mislea=
ding.=20
http://www.kernel.org/pub/software/scm/git/docs/howto/update-hook-examp=
le.txt
as it actually works with the update hook, but not with git itself.=20

Well, anyway, no problem, we will do it different.=20

Thanks

Patrick Neuner
=46utureweb.at
Innsbrucker Str.=A04
6380 St. Johann

neuner@futureweb.at
www.futureweb.at

=46on: +43 (0) 5352 65335
=46ax:=A0+43 (0) 5352 63148
Gratis =FCber Skype anrufen | Skype-ID: futureweb


> -----Urspr=FCngliche Nachricht-----
> Von: Johannes Sixt [mailto:j.sixt@viscovery.net]
> Gesendet: Donnerstag, 02. Juli 2009 08:21
> An: Patrick Neuner - Futureweb.at
> Cc: Andreas Ericsson; Jeff King; git@vger.kernel.org; David Aguilar
> Betreff: Re: AW: AW: Parallell Development / Switching to GIT
>=20
> Patrick Neuner - Futureweb.at schrieb:
> > We use the update-hook to check into which branches pushes are
> allowed per different ssh keys.
> > Now, I wonder how I am able to create branches that are below anoth=
er
> branch.
> >
> > Like
> > Refs/heads/master
> > Refs/heads/dev
> > Refs/heads/dev/featureA
> > Refs/heads/dev/featureB
> >
> > Instead of
> > Refs/heads/featureA
> >
> > Anything I tried either results in an error or creates the branch
> under /refs/heads/.
>=20
> You cannot have refs/heads/dev and refs/heads/dev/featureA at the sam=
e
> time, just like you cannot have a file and a directory with the same
> name
> at the same time. In fact, the refs "database" is implemented as
> physical
> files on the file system.
>=20
> -- Hannes
