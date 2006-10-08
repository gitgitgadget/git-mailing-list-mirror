From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] Enhance core.logallrefupdates
Date: Sun, 08 Oct 2006 12:03:20 +0200
Organization: At home
Message-ID: <egaibi$bb$1@sea.gmane.org>
References: <7vbqonkzfe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Oct 08 12:03:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWVUq-0004mr-S1
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 12:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWJHKC5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 8 Oct 2006 06:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWJHKC5
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 06:02:57 -0400
Received: from main.gmane.org ([80.91.229.2]:32228 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751014AbWJHKC4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 06:02:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GWVUY-0004jr-1H
	for git@vger.kernel.org; Sun, 08 Oct 2006 12:02:42 +0200
Received: from host-81-190-22-223.torun.mm.pl ([81.190.22.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 12:02:42 +0200
Received: from jnareb by host-81-190-22-223.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 12:02:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-223.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28528>

Junio C Hamano wrote:

> This enhances core.logallrefupdates by allowing it to take
> "heads" as the value as well, which causes git to create missing
> reflog files automatically only for branch heads. =A0Usually tags
> are create-once-and-live-forever, and it is irritating to see
> reflog files created automatically every time a new tag is made.
>=20
> As before, boolean "true" means create missing reflog files for
> all refs.
>=20
> ---
>=20
> =A0* Setting it to "tags" is not supported, as it does not make
> =A0 =A0much sense wanting to log only tag updates.
>=20
> =A0 =A0Come to think of it, it might make sense to change the
> =A0 =A0meaning of "true" to do what this patch does. =A0I do not thin=
k
> =A0 =A0of reasons to create missing reflog for tags automatically
> =A0 =A0anyway.

If we change meaning of "true", perhaps (just in case in case) we
should add "all" value?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
