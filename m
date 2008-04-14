From: Gabriel <g2p.code@gmail.com>
Subject: Re: Canonical method of merging two projects
Date: Mon, 14 Apr 2008 06:56:25 +0000 (UTC)
Message-ID: <ftuv6o$vch$1@ger.gmane.org>
References: <Pine.LNX.4.64.0804140733500.7014@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 08:57:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlId6-000639-AY
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 08:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbYDNG4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Apr 2008 02:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755400AbYDNG4o
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 02:56:44 -0400
Received: from main.gmane.org ([80.91.229.2]:43929 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbYDNG4n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 02:56:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JlIcL-0002sp-1k
	for git@vger.kernel.org; Mon, 14 Apr 2008 06:56:41 +0000
Received: from pro75-5-88-162-203-35.fbx.proxad.net ([88.162.203.35])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 06:56:41 +0000
Received: from g2p.code by pro75-5-88-162-203-35.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 06:56:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pro75-5-88-162-203-35.fbx.proxad.net
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79469>


Hello,

On Mon, 14 Apr 2008 07:37:17 +0100, Peter Karlsson wrote:

> What is the canonical way of merging an unrelated project into anothe=
r
> so that all of the merged project's files appear in a sub-directory o=
f
> the first?
>=20
> I have two projects, A with files "a.txt" and "b.txt", and B with fil=
es
> "a.txt" and "c.txt", each in a separate Git repoistory. I want to mer=
ge
> those two projects, throwing away the B repository, and achieve a fil=
e
> layout that has "a.txt" and "b.txt" from A, and "B/a.txt" and "B/c.tx=
t"
> from B. I.e, the two files with the same name are unrelated, and all =
of
> B's file should end up in a sub-directory.

This is exactly what the subtree =E2=80=9Cmerge strategy=E2=80=9D does;
there is a HOWTO here:
http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtr=
ee.html
