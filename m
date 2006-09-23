From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] diff.c: second war on whitespace.
Date: Sat, 23 Sep 2006 11:15:53 +0200
Organization: At home
Message-ID: <ef2u05$f29$1@sea.gmane.org>
References: <7vbqp7vxb8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Sep 23 11:16:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR3cW-0002xM-Vh
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 11:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWIWJQJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 05:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWIWJQJ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 05:16:09 -0400
Received: from main.gmane.org ([80.91.229.2]:16010 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751372AbWIWJQG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 05:16:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GR3c4-0002sY-Hs
	for git@vger.kernel.org; Sat, 23 Sep 2006 11:15:56 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 11:15:56 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 11:15:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27574>

Junio C Hamano wrote:

> gmane.comp.version-control.git
> This adds DIFF_WHITESPACE color class (default =3D reverse red) to
> colored diff output to let you catch common whitespace errors.
>=20
> =A0- trailing whitespaces at the end of line
> =A0- a space followed by a tab in the indent

In gitweb/gitweb.perl, around %feature hash definition, we have:

        <TAB> # <SP> <TAB> 'sub' ...

and I think that is exception to the "no space followed by tab" rule.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
