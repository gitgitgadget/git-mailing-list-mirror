From: Jeff King <peff@peff.net>
Subject: Re: Retrospectively add alternates to a repository?
Date: Sat, 22 May 2010 01:38:46 -0400
Message-ID: <20100522053846.GA29118@coredump.intra.peff.net>
References: <loom.20100227T004822-959@post.gmane.org>
 <be6fef0d1002261837g794e8df2yc92261d46f3235bd@mail.gmail.com>
 <20100227083418.GC27191@coredump.intra.peff.net>
 <loom.20100227T123539-643@post.gmane.org>
 <20100227123056.GA22382@coredump.intra.peff.net>
 <AANLkTin5igmPVoISyyj2DtRV6OWagDq-boBkP6Zqq_z-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steve Folly <steve@spfweb.co.uk>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 22 07:41:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFhSG-0008Pg-Ve
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 07:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341Ab0EVFix convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 May 2010 01:38:53 -0400
Received: from peff.net ([208.65.91.99]:39949 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808Ab0EVFiw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 01:38:52 -0400
Received: (qmail 5465 invoked by uid 107); 22 May 2010 05:38:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 22 May 2010 01:38:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 22 May 2010 01:38:46 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin5igmPVoISyyj2DtRV6OWagDq-boBkP6Zqq_z-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147506>

On Sun, May 16, 2010 at 04:55:21PM +0300, Felipe Contreras wrote:

> On Sat, Feb 27, 2010 at 3:30 PM, Jeff King <peff@peff.net> wrote:
> > On Sat, Feb 27, 2010 at 11:43:55AM +0000, Steve Folly wrote:
> >> attach =3D
> >> =C2=A0 =C2=A0 echo "/path/to/mirror" > .git/objects/info/alternate=
s &&
> >> =C2=A0 =C2=A0 git repack -adl &&
> >> =C2=A0 =C2=A0 git repack -ad &&
> >> =C2=A0 =C2=A0 git repack -adl
> >
> > I don't think the first repack is doing anything (I showed it in my
> > example only to show that it was not actually working).
>=20
> That's a bug, isn't it? Has anyone taken a look into it?

Yes, it's a bug. I don't think anybody is looking at it. I started to
write a length explanation, but the more I thought about it, the more I
am not actually sure what is going on. So please, if you are interested=
,
take a look and see if you can come up with a patch.

-Peff
