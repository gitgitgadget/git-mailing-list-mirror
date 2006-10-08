From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Does GIT require property like Subversion?
Date: Sun, 08 Oct 2006 12:26:04 +0200
Organization: At home
Message-ID: <egajm5$424$2@sea.gmane.org>
References: <4528C09B.3030004@gmail.com> <20061008091900.GG30283@lug-owl.de> <egaj49$424$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Oct 08 12:25:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWVqr-0000zU-Ig
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 12:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWJHKZk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 8 Oct 2006 06:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWJHKZk
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 06:25:40 -0400
Received: from main.gmane.org ([80.91.229.2]:4333 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751048AbWJHKZj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 06:25:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GWVqT-0000u7-By
	for git@vger.kernel.org; Sun, 08 Oct 2006 12:25:21 +0200
Received: from host-81-190-22-223.torun.mm.pl ([81.190.22.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 12:25:21 +0200
Received: from jnareb by host-81-190-22-223.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 12:25:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-223.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28532>

Jakub Narebski wrote:

> We could in pronciple "borrow" Mercurial idea of input/output filters
> =A0 http://www.selenic.com/mercurial/wiki/index.cgi/EncodeDecodeFilte=
r
> which would (among others) enable to use constant eol-style in the sh=
ared
> part of repository i.e. object database, while using OS native eol-st=
yle
> (UNIX vs. Microsoft Windows vs. MacOS). eol-style doesn't matter much=
:
> you can find good editors which are able to use any eol-style for any=
 OS
> nowadays.

What's more important, that would enable to store in SCM files which fo=
rmat
is of archive of mix of _text_ and binary files, archive being compress=
ed
and binary. Examples include OpenDocument (ODF), Java Archive (.jar),
Mozilla extension (.xpi)... well good XML aware diff would be also nice=
=2E
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
