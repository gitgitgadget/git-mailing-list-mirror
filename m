From: Eric Raible <raible@gmail.com>
Subject: Re: Canonical method of merging two projects
Date: Mon, 14 Apr 2008 18:10:28 +0000 (UTC)
Message-ID: <loom.20080414T180449-850@post.gmane.org>
References: <Pine.LNX.4.64.0804140733500.7014@ds9.cixit.se> <ftuv6o$vch$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 20:23:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlTEr-0000dR-Ro
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 20:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765217AbYDNSPJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Apr 2008 14:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765215AbYDNSPI
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 14:15:08 -0400
Received: from main.gmane.org ([80.91.229.2]:44636 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765211AbYDNSPG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 14:15:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JlTCo-0003qw-Uk
	for git@vger.kernel.org; Mon, 14 Apr 2008 18:15:03 +0000
Received: from 12.96.234.114 ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 18:15:02 +0000
Received: from raible by 12.96.234.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 18:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.13) Gecko/20080311 Firefox/2.0.0.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79521>

Gabriel <g2p.code <at> gmail.com> writes:

>=20
>=20
> Hello,
>=20
> On Mon, 14 Apr 2008 07:37:17 +0100, Peter Karlsson wrote:
>=20
> > What is the canonical way of merging an unrelated project into anot=
her
> > so that all of the merged project's files appear in a sub-directory=
 of
> > the first?
> >=20
> > I have two projects, A with files "a.txt" and "b.txt", and B with f=
iles
> > "a.txt" and "c.txt", each in a separate Git repoistory. I want to m=
erge
> > those two projects, throwing away the B repository, and achieve a f=
ile
> > layout that has "a.txt" and "b.txt" from A, and "B/a.txt" and "B/c.=
txt"
> > from B. I.e, the two files with the same name are unrelated, and al=
l of
> > B's file should end up in a sub-directory.
>=20
> This is exactly what the subtree =E2=80=9Cmerge strategy=E2=80=9D doe=
s;
> there is a HOWTO here:
> http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-sub=
tree.html
>=20

Because the OP is asking about a one-time operation I thought that it m=
ight
be easier to instead move all of B's files into a new directory (B/Bpro=
j),
and then commit that in B.

A can then simply pull B, and all of B's files will end up in A/Bproj.

- Eric
