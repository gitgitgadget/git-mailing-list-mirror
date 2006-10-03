From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: start to generate PATH_INFO URLs.
Date: Tue, 03 Oct 2006 19:50:00 +0200
Organization: At home
Message-ID: <efu7r9$fra$1@sea.gmane.org>
References: <20060929221641.GC2871@admingilde.org> <7v8xk2jofc.fsf@assigned-by-dhcp.cox.net> <20060930181408.GD2871@admingilde.org> <7vfye9dtv7.fsf@assigned-by-dhcp.cox.net> <20061001215748.GG2871@admingilde.org> <eftkdk$2ii$3@sea.gmane.org> <7vbqotpadg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Oct 03 19:51:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUoPW-0005Y6-9f
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 19:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWJCRu0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 3 Oct 2006 13:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWJCRu0
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 13:50:26 -0400
Received: from main.gmane.org ([80.91.229.2]:40357 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030392AbWJCRuZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 13:50:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GUoPB-0005S8-12
	for git@vger.kernel.org; Tue, 03 Oct 2006 19:50:09 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 19:50:09 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 19:50:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28285>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> Martin Waitz wrote:
>>
>>> +=A0=A0=A0=A0=A0=A0=A0'pathinfo' =3D> {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'override' =3D> 0,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'default' =3D> [1]},
>>
>> You should add failsafe to gitweb_check_feature for when 'sub' is no=
t
set;
>> for example when somebody sets $feature{'pathinfo'}{'override'} to 1=
=2E
>=20
> Yes, I noticed this last night while playing with it.  We would
> at least need a big warning that says this should not be made
> overridable (which does not make any sense anyway).
>=20
> Setting 'sub' to a failsafe one that only returns what is in the
> default without looking at individual repository would be the
> cleanest, I think.

Perhaps we should not add 'override' key, and test for existence
of 'override' to fallback on 'sub'.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
