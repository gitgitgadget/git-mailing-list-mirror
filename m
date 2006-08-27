From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/7] gitweb: Cleanups, fixes and small improvements
Date: Sun, 27 Aug 2006 22:21:03 +0200
Organization: At home
Message-ID: <ecsur8$gqh$1@sea.gmane.org>
References: <1156612392716-git-send-email-jnareb@gmail.com> <7vd5an1afz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Aug 27 22:21:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHR88-00079i-Vl
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 22:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWH0UVN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 27 Aug 2006 16:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWH0UVN
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 16:21:13 -0400
Received: from main.gmane.org ([80.91.229.2]:9125 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750906AbWH0UVN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 16:21:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GHR7y-00077o-45
	for git@vger.kernel.org; Sun, 27 Aug 2006 22:21:06 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 22:21:06 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 22:21:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26110>

Junio C Hamano wrote:

> * gitweb: Remove workaround for git-diff bug fixed in f82cd3c
> . gitweb: Fix typo in git_patchset_body
>=20
> =A0 I think you had separate patches for these; applied.

I think the second one, the one fixing typo ('@$fd>' instead of '=3D <$=
fd>')
was not applied. I don't know how this typo got into gitweb, as I have
tested gitweb after the 19-patch series, and this error looks was intro=
duced
in 'next' branch, 157e43b4b0dd5a08eb7a6838192ac58bca62fa5b commit

  gitweb: Streamify patch output in git_commitdiff

This error is critical!
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
