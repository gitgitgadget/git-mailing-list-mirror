From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] git-repack: -b to pass --delta-base-offset
Date: Fri, 13 Oct 2006 23:29:35 +0200
Organization: At home
Message-ID: <egp0fk$15b$1@sea.gmane.org>
References: <11607177011745-git-send-email-junkio@cox.net> <11607177024171-git-send-email-junkio@cox.net> <Pine.LNX.4.64.0610130912500.2435@xanadu.home> <7v64endi6x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Oct 13 23:30:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYUbL-0004vA-Fw
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 23:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWJMV3w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 13 Oct 2006 17:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWJMV3w
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 17:29:52 -0400
Received: from main.gmane.org ([80.91.229.2]:5547 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932079AbWJMV3v (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Oct 2006 17:29:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GYUb4-0004sC-Qq
	for git@vger.kernel.org; Fri, 13 Oct 2006 23:29:39 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 23:29:38 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 23:29:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28862>

Junio C Hamano wrote:

> So how about
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0[core]
> =A0 =A0 =A0 =A0 =A0=A0=A0=A0=A0=A0=A0=A0repackUseDeltaBase =3D true

+1, but I'd rather first it default to false.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
