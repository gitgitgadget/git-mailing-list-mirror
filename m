From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: Fix UTF Encoding issue
Date: Tue, 4 Dec 2007 10:47:39 +0200
Organization: Pardus / KDE
Message-ID: <200712041047.39340.ismail@pardus.org.tr>
References: <4753D419.80503@clearchain.com> <200712041033.39579.ismail@pardus.org.tr> <20071204084412.GA19597@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>,
	Benjamin Close <Benjamin.Close@clearchain.com>,
	git@vger.kernel.org,
	Perl Unicode Mailing List <perl-unicode@perl.org>,
	Dan Kogai <dankogai@dan.co.jp>
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Dec 04 09:47:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzTQt-0006SC-7Z
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 09:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbXLDIqw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 03:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbXLDIqv
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 03:46:51 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:59378 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750969AbXLDIqv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Dec 2007 03:46:51 -0500
Received: from ninjamobile.local (unknown [85.102.220.209])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 1BA1261D01F3;
	Tue,  4 Dec 2007 10:46:46 +0200 (EET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <20071204084412.GA19597@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67026>

Tuesday 04 December 2007 10:44:12 Martin Koegler yazm=C4=B1=C5=9Ft=C4=B1=
:
> On Tue, Dec 04, 2007 at 10:33:39AM +0200, Ismail D=C3=B6nmez wrote:
> > Following to_utf8 function works for me :
>
> For me too (Debian sarge+etch).

Thanks for testing.

> > sub to_utf8 {
> > =C2=B7 =C2=A0 my $str =3D shift;
> >
> > =C2=A0 =C2=A0 if(utf8::valid($str))
> > =C2=A0 =C2=A0 {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 utf8::decode($str);
> > =C2=A0 =C2=A0 }
> > =C2=B7
> > =C2=A0 =C2=A0 return $str;
>
> In the original thread, there was some discussion, that some people
> might want a different fallback endcoding. So mayme you should
> keep the second call to decode for the fallback encoding.

Probably, I just wanted to fix this damn UTF-8 bug surfacing over and o=
ver =3D)

Regards,
ismail

--=20
Never learn by your mistakes, if you do you may never dare to try again=
=2E
