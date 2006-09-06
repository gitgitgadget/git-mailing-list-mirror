From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: file rename causes history to disappear
Date: Wed, 06 Sep 2006 21:25:47 +0200
Organization: At home
Message-ID: <edn996$rfb$1@sea.gmane.org>
References: <44FEE0BB.2060601@garzik.org> <Pine.LNX.4.64.0609060834520.27779@g5.osdl.org> <44FEED4B.30909@garzik.org> <Pine.LNX.4.64.0609060858050.27779@g5.osdl.org> <edmvfv$lt7$2@sea.gmane.org> <Pine.LNX.4.64.0609061131100.27779@g5.osdl.org> <edn5dd$c4s$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Sep 06 21:59:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL3YQ-0001Au-IS
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 21:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWIFT7I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 6 Sep 2006 15:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbWIFT7I
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 15:59:08 -0400
Received: from main.gmane.org ([80.91.229.2]:46797 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751360AbWIFT7G (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 15:59:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GL3Xl-00014J-52
	for git@vger.kernel.org; Wed, 06 Sep 2006 21:58:41 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 21:58:41 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 21:58:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26555>

Jakub Narebski wrote:

> Linus Torvalds wrote:
>=20
>>> git-rev-list could then output hash with current set of <filenames>=
, which
>>> were given <filename> at the beginning, i.e.
>>> =A0 <hash> -- <filename> [<filename>...]

> I'm not that sure. The output could be changed to, for example
>   <hash> SP <quoted-filename> [SP <quoted-filename> ...]

The "<hash> -- <filename> [<filename>...]" was to allow the followed=20
<filename> to be pathspec for other command, for example=20
   git-diff-tree --stdin
(if git-diff-tree accepts pathspec limiting on stdin, and not only
revisions, or pairs of revisions; according to 1.4.2 documentation
--stdin is for reading either one  <commit>  or a pair of <tree-ish>
separated with a single space from its input -- no pathspecs).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
