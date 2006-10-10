From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 23:13:47 +0200
Message-ID: <200610102313.48170.jnareb@gmail.com>
References: <20061010210226.47626.qmail@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 23:13:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXOu8-0008JZ-80
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 23:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWJJVMo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Oct 2006 17:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWJJVMo
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 17:12:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:54025 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030400AbWJJVMn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 17:12:43 -0400
Received: by ug-out-1314.google.com with SMTP id o38so833637ugd
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 14:12:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KDJHHYYqUJu9WmX2axHusB0Lz8X+GaAtX+D2jSscaLgsdAI6jDYbeRCUfoEk36I+8KUG1ZSU4S/+Hu66EvlRpDVSi+N70PVPk5sS3mvdO+kWq7FvucbD8rXHn4kw8goMJ61EoU04rRyfsO22NYX5VAGDtysV0jSPrWzbH+zv/lk=
Received: by 10.67.117.2 with SMTP id u2mr8709804ugm;
        Tue, 10 Oct 2006 14:12:41 -0700 (PDT)
Received: from host-81-190-20-194.torun.mm.pl ( [81.190.20.194])
        by mx.google.com with ESMTP id e33sm3189085ugd.2006.10.10.14.12.40;
        Tue, 10 Oct 2006 14:12:41 -0700 (PDT)
To: Luben Tuikov <ltuikov@yahoo.com>
User-Agent: KMail/1.9.3
In-Reply-To: <20061010210226.47626.qmail@web31809.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28672>

Dnia wtorek 10. pa=BCdziernika 2006 23:02, Luben Tuikov napisa=B3:
> > > Isn't that a simple "labelling" question? =A0I do not think
> > > anybody minds to show clickable string "contents" (instead of
> > > "blob" or "tree") at the places you mention above and if we did
> > > so everybody would be happy, right?
> >=20
> > Not, IMHO it is not a good idea. Clicking on file name leads to it
> > contents, but it is not obvoius what kind of view is it. "blob" lin=
k
>=20
> It is pretty obvious to me: the contents of the object, whether it be
> "blob" or "tree". =A0The contents of "blob" and the contents of "tree=
"
> as shown by gitweb.

It's pretty obvous to you, because there is only one basic view of tree=
,=20
and one basic view of blob. It is not the case for example for commits=20
in shortlog view, where we have commit and commitdiff views. It is=20
possible that either blobs or trees acquire another views.
--=20
Jakub Narebski
Poland
