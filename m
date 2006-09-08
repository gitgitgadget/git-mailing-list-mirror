From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Problem with send-email
Date: Sat, 09 Sep 2006 00:25:30 +0200
Organization: At home
Message-ID: <edsqjo$gh3$1@sea.gmane.org>
References: <4501DA6D.9020104@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Sep 09 00:25:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLomv-000740-I4
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 00:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWIHWZV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 8 Sep 2006 18:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWIHWZU
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 18:25:20 -0400
Received: from main.gmane.org ([80.91.229.2]:7310 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751175AbWIHWZS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 18:25:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLomU-0006zS-2F
	for git@vger.kernel.org; Sat, 09 Sep 2006 00:25:02 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 00:25:02 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 00:25:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26720>

Timur Tabi wrote:

> Everything works. =A0However, if I do this:
>=20
> git-send-email --from timur@freescale.com --to =A0\
>    --smtp-server remotesmtp.freescale.net patchfile=20
>=20

What do you expect when you specify _empty_ To: header?

I use git-send-email from time to time; I always specify From:,=20
either entering it when prompted, or using --from parameter.
The fact that it didn't fill default value from committer/author
core.author+core.email is I guess a bug...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
