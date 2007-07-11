From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: New cgi parameter: filter
Date: Wed, 11 Jul 2007 23:19:41 +0200
Organization: At home
Message-ID: <f73hhc$uo1$1@sea.gmane.org>
References: <20070708013543.GD29994@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 23:20:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8jbP-0006Tq-ML
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307AbXGKVT7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 11 Jul 2007 17:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbXGKVT7
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:19:59 -0400
Received: from main.gmane.org ([80.91.229.2]:50942 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754809AbXGKVT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:19:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I8jbB-0002tJ-GZ
	for git@vger.kernel.org; Wed, 11 Jul 2007 23:19:49 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 23:19:49 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 23:19:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52202>

[Cc: git@vger.kernel.org]

Miklos Vajna wrote:

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0((defined $filter and $=
filter =3D=3D "nomerges") ? ("--no-merges") : ()),

Shouldn't it be '$filter eq "nomerges"' instead?

Besides, I'd rather have generalized way to provide additional options
to git commands, like '--no-merges' for RSS and Atom feeds, log, shortl=
og
and history views, '-C' for commitdiff view, '--remove-empty' for histo=
ry
view for a file, perhaps even '-c' or '--cc' for commitdiff for merges
instead of abusing 'hp' argument for that.

But that doesn't mean that this patch should be not applied... it doesn=
't
mean it should be applied neither ;-)
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
