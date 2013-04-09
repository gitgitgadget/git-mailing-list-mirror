From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: RFC: Very useful script to SVG graph the git commits from a
 file orientated view
Date: Tue, 9 Apr 2013 10:55:06 +0200 (CEST)
Message-ID: <1344434918.1379702.1365497705958.JavaMail.root@openwide.fr>
References: <CAHQ6N+rPfYmNRjjU0EDx3B1O_K+c6zm9v=BT_bMEXZ1yQFXGhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 09 10:55:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPUKi-0004r4-VV
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 10:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935183Ab3DIIzL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 04:55:11 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:43657 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935034Ab3DIIzI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Apr 2013 04:55:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 068E4280A7;
	Tue,  9 Apr 2013 10:55:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hJe9aOcY6hDW; Tue,  9 Apr 2013 10:55:06 +0200 (CEST)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 3B075280A1;
	Tue,  9 Apr 2013 10:55:06 +0200 (CEST)
In-Reply-To: <CAHQ6N+rPfYmNRjjU0EDx3B1O_K+c6zm9v=BT_bMEXZ1yQFXGhw@mail.gmail.com>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC26 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220554>

looking a little bit more into this, I was very suprised....

there seems to be little/no tools in the git ecosystem that studies the=
 dependencies between commits based on the file they modified and/or th=
e conflict they would cause.

Is there any pre-existing tool to do that ? It can be done with git-log=
 --name-only(the graph_git.pl is just a graphing layer above that comma=
nd) but i'm suprised that I couldn't find anything else

And that was at the file level, is there any tool to help find what com=
mits can be reordered without causing conflicts ? I am not sure if ther=
e is an easy way to extract potential conflict information from git...

    Regards

    J=C3=A9r=C3=A9my Rosen

fight key loggers : write some perl using vim

----- Mail original -----
> Hi Jeremy,
>=20
>   It would be great if you could send your email again to the list,
>   so
> that other people can see that there is interest in my script :)
> Makes it easier for me to get it included.
>=20
> > * The tooltips are very handy, but it would be nice if the tooltip
> > would activate on the whole commit ellipsis, not just the text
> > inside the ellipsis
>=20
> Yes, tooltips are a real pain.  I don't know how to do that.
>=20
> > * I would love to have tooltips on the arrows too. when trying to
> > follow what arrow is what file it makes things really handi
>=20
> Actually they do have tooltips - it's just that the arrows are really
> thin so you have to be very accurate with your mouse pointing!
>=20
> > It would be nice if there were a way to filter only some files in
> > the output... there probably is with the git-log like syntax but
> > i'm not a master of that... hints would be welcome
>=20
> Try just specifying the files:
>=20
> $ graph_git.pl -10  filename1 filename2
>=20
> I haven't tested, but it should work
>=20
> > is there a public repo for this script so I can point other people
> > to it ?
>=20
> No - any suggestions as to where to put it are welcome :)
>=20
> John
>=20
