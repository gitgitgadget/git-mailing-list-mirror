From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH v2] git-clone: Add option --branch to override initial branch
Date: Mon, 9 Mar 2009 14:39:54 +0000 (UTC)
Message-ID: <loom.20090309T143413-334@post.gmane.org>
References: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de> <1236040414-19089-1-git-send-email-torarnv@gmail.com> <7vbpsh93q5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 15:41:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lggfg-0004qW-H8
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 15:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbZCIOkI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 10:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbZCIOkH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 10:40:07 -0400
Received: from main.gmane.org ([80.91.229.2]:44417 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbZCIOkF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 10:40:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LggeB-0002zt-ET
	for git@vger.kernel.org; Mon, 09 Mar 2009 14:40:03 +0000
Received: from 85.205.253.203 ([85.205.253.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 14:40:03 +0000
Received: from paolo.ciarrocchi by 85.205.253.203 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 14:40:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 85.205.253.203 (Mozilla/5.0 (Windows; U; Windows NT 5.1; it; rv:1.9.0.7; .NET CLR 3.0; ffco7) Gecko/2009021910 Firefox/3.0.7 GTB5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112698>

Junio C Hamano <gitster <at> pobox.com> writes:

>=20
> Tor Arne Vestb=C3=B8 <torarnv <at> gmail.com> writes:
>=20
> > The options --branch and -b allow the user to override the initial
> > branch created and checked out by git-clone (normally this is the
> > active branch of the remote repository).
> >
> > If the selected branch is not found the operation aborts.
> >
> > Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv <at> gmail.com>
>=20
> The semantics and desirability of the new feature have been already
> discussed, and I am not convinced that it is necessary, in the sense =
that
> I do not think I likely ever use this myself, but I am just one of gi=
t
> users so that is not a strong basis for rejection.

I wrote a comment about the --branch approach a couple of days ago, dun=
no why
but this thread never reached my inbox (replying via gmame web interfac=
e).

http://thread.gmane.org/gmane.comp.version-control.git/112527

As I wrote in my post a friend of mine, new to git, was looking for the
possibility of cloning a repo and automatically checkout a specific bra=
nch.

Regards,
           Paolo
