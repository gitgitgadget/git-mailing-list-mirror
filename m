From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Mon, 7 Sep 2009 09:33:22 +0200
Message-ID: <20090907073322.GA6021@neumann>
References: <20090902080305.GA11549@neumann>
	<20090902081917.GA5447@coredump.intra.peff.net>
	<20090904070216.GA3996@darc.dnsalias.org>
	<20090905061804.GB29863@coredump.intra.peff.net>
	<7v8wgt98ms.fsf@alter.siamese.dyndns.org>
	<20090905084641.GA24865@darc.dnsalias.org>
	<vpqfxb0s177.fsf@bauges.imag.fr> <20090906181621.GA23412@localhost>
	<vpqpra3p92g.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 07 09:33:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkYjJ-0006Xv-BD
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 09:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbZIGHd1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2009 03:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbZIGHd1
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 03:33:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:62150 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZIGHd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 03:33:26 -0400
Received: from [127.0.1.1] (p5B13173F.dip0.t-ipconnect.de [91.19.23.63])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MKuxg-1MkYj44AA5-000QoT; Mon, 07 Sep 2009 09:33:24 +0200
Content-Disposition: inline
In-Reply-To: <vpqpra3p92g.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1/ArEmuXjkS9cfPTZE73Fzs/O2e7rPL0QcXNQQ
 zGt6NMq9sQU5yDJUl0pE7ifVL6R1X3J1tbgCziUtPf+NZZdvSr
 oWzWy5I8STlTJo+cFAZNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127893>

On Mon, Sep 07, 2009 at 08:23:19AM +0200, Matthieu Moy wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
>=20
> > On Sun, Sep 06, 2009 at 02:32:44PM +0200, Matthieu Moy wrote:
> >> I think it has already been proposed to introduce "git add -a" doi=
ng
> >> what "git add -u" do, but for the full tree.
> >
> > I like that, actually. AFAICT it's completely analogous to "git com=
mit -a".
> > We also need something for "git add -A" though.
> >
> > Do you feel the same way about changing the behavior of "git grep"?=
 I don't
> > really want to change the command's name.
>=20
> I don't have particular feeling about "git grep", probably because I
> don't use it much. One argument in favour of keeping the current
> behavior is the consistancy with plain "grep".

I'm not sure how important should be the consistency with plain grep
in this case.  After all, plain grep does not work without pathspec at
all (ok, it searches stdin, but it's completely different thing),
while git grep does.  And plain grep is not recursive by default,
while git grep is.  And plain 'grep -r foo .' searches all files in
the current directory and below, while 'git grep foo .' does not
search in untracked files.


Regards,
G=E1bor
