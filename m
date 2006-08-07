From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-diff between /dev/null and blob
Date: Mon, 07 Aug 2006 14:52:50 +0200
Organization: At home
Message-ID: <eb7d2s$cq2$1@sea.gmane.org>
References: <eajl4r$b7o$1@sea.gmane.org> <7vmzaq9sjs.fsf@assigned-by-dhcp.cox.net> <eb5ld6$36k$1@sea.gmane.org> <7vejvt8s24.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Aug 07 14:53:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA4bb-0000xN-Gk
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 14:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWHGMxM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 Aug 2006 08:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWHGMxM
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 08:53:12 -0400
Received: from main.gmane.org ([80.91.229.2]:22184 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932094AbWHGMxL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 08:53:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GA4bL-0000sE-UG
	for git@vger.kernel.org; Mon, 07 Aug 2006 14:52:59 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Aug 2006 14:52:59 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Aug 2006 14:52:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25012>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:=20

>=A0=A0=A0=A0=A0=A0=A0=A0git diff v0.99:pull.h fetch.h
>
>         echo extra >>Makefile && git diff :0:Makefile HEAD^^:Makefile
>=20
>         H=3D`(cat Makefile; echo extra) | git hash-object -w --stdin`
>       echo "100644 $H 2       foobar" | git update-index --add --inde=
x-info
>       git diff :2:foobar :Makefile
>=20
>> git-diff doesn't understand :<stage>:<filename> and :<filename> for
>> accessing index version of blob (git-cat-file for example understand=
s
>> it).
>=20
> You probably got this impression from a botched experiment or
> something, but this statement is wrong as demonstrated above.

Right, sorry.

And you can write ./<filename> to distinguish it from revision name, so
proposed ::<filename> extension is not needed.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
