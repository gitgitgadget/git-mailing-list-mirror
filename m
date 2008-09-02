From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Wed, 03 Sep 2008 00:11:52 +0200
Organization: At home
Message-ID: <g9kdn4$rgs$1@ger.gmane.org>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl> <7vk5dujn9h.fsf@gitster.siamese.dyndns.org> <20080902210524.GB7757@leksak.fem-net> <0578A0F2-F90A-4555-9B34-726F26A1CDBB@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 00:13:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kae7e-0004Xy-ET
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 00:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbYIBWMI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2008 18:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084AbYIBWMI
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 18:12:08 -0400
Received: from main.gmane.org ([80.91.229.2]:32887 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986AbYIBWMG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 18:12:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kae6T-0008D0-7T
	for git@vger.kernel.org; Tue, 02 Sep 2008 22:12:01 +0000
Received: from abvy100.neoplus.adsl.tpnet.pl ([83.8.222.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 22:12:01 +0000
Received: from jnareb by abvy100.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 22:12:01 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvy100.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94728>

Pieter de Bie wrote:

> =A0=A0=A0=A0=A0=A0=A0=A0# Please enter the commit message for your ch=
anges. Lines starting
> =A0=A0=A0=A0=A0=A0=A0=A0# with '#' will be ignored, and an empty mess=
age aborts the commit.
> =A0=A0=A0=A0=A0=A0=A0=A0# Not currently on any branch.
> =A0=A0=A0=A0=A0=A0=A0=A0# Untracked files:
> =A0=A0=A0=A0=A0=A0=A0=A0# =A0 (use "git add <file>..." to include in =
what will be committed)
>=20
> It's the third line, surrounded by other lines and at the bottom of =A0
> the window.

Perhaps instead of poposed patch we should simply put empty lines
to emphasize that we are on no branch:

        # Please enter the commit message for your changes. Lines start=
ing
        # with '#' will be ignored, and an empty message aborts the com=
mit.
        #
        # Not currently on any branch.
        #
        # Untracked files:
        #   (use "git add <file>..." to include in what will be committ=
ed)


--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
