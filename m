From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] split notes [was: Re: What's cooking in git.git (Jan 2009, #05; Wed, 21)]
Date: Sun, 01 Feb 2009 13:01:55 +0100
Organization: At home
Message-ID: <gm42vk$lg7$1@ger.gmane.org>
References: <7vab9kataf.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901220606040.3586@pacific.mpi-cbg.de> <1233384354.10045.170.camel@maia.lan> <20090131073640.GF3033@coredump.intra.peff.net> <1233455960.17688.122.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 13:08:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTb7d-0004MW-Kq
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 13:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbZBAMCO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Feb 2009 07:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbZBAMCO
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 07:02:14 -0500
Received: from main.gmane.org ([80.91.229.2]:36687 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbZBAMCN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 07:02:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LTb1Z-00037w-FJ
	for git@vger.kernel.org; Sun, 01 Feb 2009 12:02:05 +0000
Received: from abwv210.neoplus.adsl.tpnet.pl ([83.8.245.210])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 12:02:05 +0000
Received: from jnareb by abwv210.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 12:02:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwv210.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107979>

Sam Vilain wrote:

> =A0test -z "$GIT_NOTES_REF" && GIT_NOTES_REF=3D"$(git config core.not=
esref)"
> =A0test -z "$GIT_NOTES_REF" && GIT_NOTES_REF=3D"refs/notes/commits"

GIT_NOTES_REF=3D$($(GIT_NOTES_REF:-$(git config core.notesref):-refs/no=
tes/commits)

Or something like that.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
