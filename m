From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: gitweb_check_feature always return list
Date: Fri, 01 Sep 2006 22:12:29 +0200
Organization: At home
Message-ID: <eda475$ob7$1@sea.gmane.org>
References: <ed8a90$pfn$1@sea.gmane.org> <11571390683018-git-send-email-jnareb@gmail.com> <7vk64n5qep.fsf@assigned-by-dhcp.cox.net> <eda2q0$la8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 01 22:13:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJFO5-0001Jy-8D
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 22:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWIAUNJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 1 Sep 2006 16:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbWIAUNJ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 16:13:09 -0400
Received: from main.gmane.org ([80.91.229.2]:50845 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751003AbWIAUNG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Sep 2006 16:13:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GJFNh-0001Ej-6j
	for git@vger.kernel.org; Fri, 01 Sep 2006 22:12:49 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Sep 2006 22:12:49 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Sep 2006 22:12:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26310>

<opublikowany i wys=B3any>

Jakub Narebski wrote:

> Junio C Hamano wrote:
>=20
>> Jakub Narebski <jnareb@gmail.com> writes:
>>=20
>>> Modified feature_blame so it returns one-element list and not scala=
r,
>>> thus making gitweb_check_feature always return list.  Updated comme=
nt
>>> to explain that part.
>>=20
>> I do not understand what you are fixing.
>>=20
>>       sub A { return (1); }
>>       sub B { return 1; }
>>=20
>> Don't they quack the same way?
>=20
> Well, that is just nitpicking. gitweb_check_feature returns list if f=
eature
> is not overridable, so I made it that it always returns list.

Then I'm not sure if Aneesh Kumar patch I replied to is really necessar=
y.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git



--=20
VGER BF report: U 0.499824
