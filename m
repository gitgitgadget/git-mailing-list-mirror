From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] format-patch: add --prefix to prepend a prefix to output
 file names
Date: Tue, 09 Jun 2009 14:37:01 +0200
Message-ID: <4A2E576D.704@op5.se>
References: <1244547227-6466-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 14:37:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME0aE-0005jI-2l
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 14:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760879AbZFIMhE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 08:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760804AbZFIMhD
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 08:37:03 -0400
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:54291 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759329AbZFIMhC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 08:37:02 -0400
Received: from source ([72.14.220.152]) by na3sys009aob106.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSi5XcHpDgeD0xDKKtEyMTHTEIMzxKEZl@postini.com; Tue, 09 Jun 2009 05:37:05 PDT
Received: by fg-out-1718.google.com with SMTP id 13so1466627fge.5
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 05:37:03 -0700 (PDT)
Received: by 10.86.23.20 with SMTP id 20mr94903fgw.49.1244551023587;
        Tue, 09 Jun 2009 05:37:03 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 4sm1600518fgg.18.2009.06.09.05.37.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Jun 2009 05:37:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <1244547227-6466-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121172>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> I use git to manages patches in my Gentoo development. In Gentoo,
> all ebuilds (another form of RPM spec) corresponding to different
> versions of the same package are grouped into one directory. So patch=
es
> for each versions usually have a prefix to separate them from the one=
s
> for other versions. With --prefix it comes handy to produce such patc=
hes,
> for example:
>=20
> git format-patch --prefix dbus-1.2.3- HEAD~5
>=20
> will generate patches for dbus-1.2.3 for me, all starting with "dbus-=
1.2.3-".
>=20
> This might be handy for RPM developers as well.
>=20

I'm thinking this could be confused with '--subject-prefix' which was
given the long option to *not* confuse it with cover-letters and filena=
me
prefixes. Any chance you could make it --filename-prefix instead? Since
it already lacks a short option, the extra typing will probably be wort=
h
it to avoid unnecessary confusion.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
