From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn pointing at svn branch instead of trunk?
Date: Sat, 22 Aug 2009 19:51:01 -0700
Message-ID: <20090823025101.GA22562@dcvr.yhbt.net>
References: <2729632a0908221140p532a3c29k90af7b4cbd25d65e@mail.gmail.com> <20090822204627.GA22484@dcvr.yhbt.net> <2729632a0908221512v7d7af188h28d11a4bc8f092fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sun Aug 23 04:51:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf3Ao-000319-64
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 04:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933440AbZHWCvD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Aug 2009 22:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933438AbZHWCvD
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 22:51:03 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36227 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933429AbZHWCvC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 22:51:02 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id D211B1F790;
	Sun, 23 Aug 2009 02:51:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2729632a0908221512v7d7af188h28d11a4bc8f092fc@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126831>

skillzero@gmail.com wrote:
> On Sat, Aug 22, 2009 at 1:46 PM, Eric Wong<normalperson@yhbt.net> wro=
te:
>=20
> > So you have something like this?
> >
> > ----------trunk
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 \-> tag
> >
> > It looks like it's mixed but that's because trunk is an ancestor of=
 your
> > tag, so the majority of commits (see git-svn-id:) look like they're=
 from
> > trunk except the latest git-svn-id: which should have the URL of th=
e tag
> > in it. =A0So in short, everything here is OK.
>=20
> Yes, that's what I see: most of the commits have a /trunk URL except
> the last one has a /tags/TagX URL.
>=20
> When the next commit happens on master (I don't have svn commit acces=
s
> on the svn repo to try it myself), will git svn automatically track
> master->trunk again? Or is there something I need to change to tell i=
t
> "master tracks svn's /trunk"? I normally do git svn fetch and git svn
> rebase (while on master, I do all my own commits on a separate
> branch).

You need to reset your master to trunk so it knows to track trunk
instead of tags/TagX

--=20
Eric Wong
