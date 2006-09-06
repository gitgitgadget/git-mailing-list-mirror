From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Add git-archive
Date: Wed, 06 Sep 2006 22:29:19 +0200
Organization: At home
Message-ID: <ednb29$u0u$1@sea.gmane.org>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com> <7vfyf6ce29.fsf@assigned-by-dhcp.cox.net> <44FED12E.7010409@innova-card.com> <44FF2C37.2010400@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Sep 06 22:29:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL41X-0007TU-5M
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 22:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWIFU3Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 6 Sep 2006 16:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWIFU3Y
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 16:29:24 -0400
Received: from main.gmane.org ([80.91.229.2]:49093 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751537AbWIFU3X (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 16:29:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GL41O-0007RH-SZ
	for git@vger.kernel.org; Wed, 06 Sep 2006 22:29:18 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 22:29:18 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 22:29:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26558>

Rene Scharfe wrote:

> IMHO should work like in the following example, and the code above
> cuts off the Documentation part:
>=20
> =A0 =A0$ cd Documentation
> =A0 =A0$ git-archive --format=3Dtar --prefix=3Dv1.0/ HEAD howto | tar=
 tf -
> =A0 =A0v1.0/howto/
> =A0 =A0v1.0/howto/isolate-bugs-with-bisect.txt
> =A0 =A0...
>=20
> I agree that simple subtree matching would be enough, at least for
> now.

What about

     $ git-archive --format=3Dtar --prefix=3Dv1.0/ HEAD:Documentation/h=
owto

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
