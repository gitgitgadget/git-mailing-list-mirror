From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC] pull/fetch rename
Date: Thu, 22 Oct 2009 11:48:26 +0200
Message-ID: <200910221148.28335.trast@student.ethz.ch>
References: <200910201947.50423.trast@student.ethz.ch> <20091021030608.GA18997@atjola.homenet> <7vk4ypb71j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 11:49:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0uIA-0001b8-Q7
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 11:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528AbZJVJs7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Oct 2009 05:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754486AbZJVJs7
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 05:48:59 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:16041 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbZJVJs6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Oct 2009 05:48:58 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 22 Oct
 2009 11:49:01 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 22 Oct
 2009 11:49:01 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7vk4ypb71j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131014>

Junio C Hamano wrote:
> Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>=20
> > So that's ten days of #git. I left out a bunch of duplications (mos=
t
> > were "pull =3D=3D fetch", "pull =3D=3D update" and "pull to update
> > non-checked-out branch").
>=20
> Interesting; this shows that people who do not understand what "pull"=
 does
> expect different behaviour from "pull", use the word "pull" to expres=
s
> what they want to happen, expect other people interpret the word to m=
ean
> the way they think it does.  At the same time, judging from different
> behaviour expected by these people, push/pull asymmetry does not seem=
 to
> have much to do with the confusion.

This of course is where our conclusions differ.  I haven't counted
them, but Bj=C3=B6rn (thanks again for the excellent survey) points out
that most duplicates are confusion with fetch, (imagined) update or
"update to not checked out branch".

Pull is none of these, but if it was (current) fetch, at least the
first group of people would have had the right idea of what it does.

> I am actually even Ok, at least in the long run (like in 3 years), if=
 we
> were to deprecate the refspecs with colon given on the command line t=
o
> "pull" and "fetch" altogether [*1*].

As an aside, there are actually some use-cases, e.g., to grab the
git-svn refs from a freshly cloned repository you would run:

  git fetch origin refs/remotes/*:refs/remotes/*

(and then 'git svn init' etc.)  I've also had some weird requests on
IRC that could be solved by clever (and of course dangerous) use of
'git fetch . glob:otherglob'.

Hiding that power behind an option could be a good idea though.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
