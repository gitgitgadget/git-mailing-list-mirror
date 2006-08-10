From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 7] autoconf: Add support for setting CURLDIR, OPENSSLDIR, EXPATDIR
Date: Thu, 10 Aug 2006 23:43:39 +0200
Organization: At home
Message-ID: <ebg99i$ijq$1@sea.gmane.org>
References: <200608081834.09271.jnareb@gmail.com> <200608090215.10917.jnareb@gmail.com> <ebf31a$8qv$2@sea.gmane.org> <7vejvouvqm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Aug 10 23:43:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBIJe-0008V4-Ou
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 23:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWHJVnm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 10 Aug 2006 17:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWHJVnl
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 17:43:41 -0400
Received: from main.gmane.org ([80.91.229.2]:55458 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932067AbWHJVnk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 17:43:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GBIJJ-0008Qv-RY
	for git@vger.kernel.org; Thu, 10 Aug 2006 23:43:26 +0200
Received: from host-81-190-28-159.torun.mm.pl ([81.190.28.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Aug 2006 23:43:25 +0200
Received: from jnareb by host-81-190-28-159.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Aug 2006 23:43:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-28-159.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25213>

<opublikowany i wys=B3any>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> Jakub Narebski wrote:
>>
>>> Add support for --with-openssl=3DPATH and --without-openssl,
>>> --with-curl=3DPATH and --without-curl, --with-expat=3DPATH and
>>> --without-expat ./configure options, each setting or unsetting
>>> appropriate NO_PACKAGE and if called with argument also PACKAGEDIR
>>> (of which only CURLDIR is documented in Makefile)
>>>=20
>>> All above options are supported as override to autodetection; more =
to
>>> come in the same style (override to autodetection), so moved the bu=
lk
>>> of comments for site configuration down.
>>
>> Is this patch dropped?
>=20
> I think it should be on "pu" but I might have missed it; it came
> with a warning not to apply didn't it?

Yes, although the warning is more about the _style_ than about what
it does. It works as far as I tested, but IMVHO it is a bit of hack.=20

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
