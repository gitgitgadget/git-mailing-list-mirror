From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-daemon: more powerful base-path/user-path settings, using formats.
Date: Sun, 27 Aug 2006 17:30:24 +0200
Organization: At home
Message-ID: <ecsdqa$1pi$1@sea.gmane.org>
References: <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net> <200608271228.09718.madcoder@debian.org> <7v64gexxgl.fsf@assigned-by-dhcp.cox.net> <200608271340.32792.madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Aug 27 17:30:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHMax-0002AL-Uy
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 17:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWH0Paj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 27 Aug 2006 11:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWH0Paj
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 11:30:39 -0400
Received: from main.gmane.org ([80.91.229.2]:2197 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751032AbWH0Paj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 11:30:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GHMah-00027C-MT
	for git@vger.kernel.org; Sun, 27 Aug 2006 17:30:27 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 17:30:27 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 17:30:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26100>

Pierre Habouzit wrote:

> Le dim 27 ao?t 2006 12:52, Junio C Hamano a =E9crit :
>> About vger potentially throwing things away, I use this script
>> (called "taboo.perl") to check my messages before sending them
>> out.
>=20
> that was not it, I was biten (again) by git-send-mail that uses strft=
ime=20
> (localized) to generate rfc822 dates, making them unparseable :|

Update your git, or use ./git-send-email.perl directly from git reposit=
ory
(from 'master' branch, as 'next' branch version uses Git.pm). Strftime =
was
replaced by pure Perl to generate rfc2822 date some time ago...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
