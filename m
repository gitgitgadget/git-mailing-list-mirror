From: Jeff King <peff@peff.net>
Subject: Re: setting up tracking on push
Date: Tue, 10 Mar 2009 23:06:04 -0400
Message-ID: <20090311030604.GA3044@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de> <buoy6vi297q.fsf@dhlpc061.dev.necel.com> <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com> <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com> <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com> <20090310230939.GB14083@sigio.peff.net> <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com> <20090311020409.GA31365@coredump.intra.peff.net> <76718490903101959i61df26aagdff44bb9ab4593ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 04:07:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhEnC-0006mk-2j
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 04:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbZCKDGL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2009 23:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbZCKDGJ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 23:06:09 -0400
Received: from peff.net ([208.65.91.99]:35347 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210AbZCKDGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 23:06:09 -0400
Received: (qmail 15982 invoked by uid 107); 11 Mar 2009 03:06:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Mar 2009 23:06:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Mar 2009 23:06:04 -0400
Content-Disposition: inline
In-Reply-To: <76718490903101959i61df26aagdff44bb9ab4593ab@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112872>

On Tue, Mar 10, 2009 at 10:59:01PM -0400, Jay Soffian wrote:

> But the primary reason for the -u is to differentiate the operation,
> just like -m and -d.

OK, that at least makes a bit of sense to me.

> > =C2=A02. In your example, if I give only a single non-option argume=
nt, it is
> > =C2=A0 =C2=A0 interpreted as the upstream (and presumably the branc=
h defaults to
> > =C2=A0 =C2=A0 HEAD). =C2=A0But in other branch commands, it is inte=
rpreted as the
> > =C2=A0 =C2=A0 branch, and the upstream defaults to HEAD.
>=20
> No, look at how -m works. [<oldbranch>] <newbranch>. I modeled it aft=
er that.

Hmm. I think of that as "make <newbranch>, move from <oldbranch> or
HEAD". Just as regular branch is "make <newbranch>, start from
<oldbranch> or HEAD". But your proposal is "update <newbranch> or HEAD,
from <oldbranch>".

If "-u" is supposed to be a general mode, then what does it mean to say=
:

  git branch -u foo

? I would expect that to "update" foo. But if --track is given, then it
means "update HEAD to track foo".

-Peff
