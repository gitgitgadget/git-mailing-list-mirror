From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: multiple-commit cherry-pick?
Date: Fri, 7 Nov 2008 12:03:31 +0100
Message-ID: <20081107110331.GA2938@atjola.homenet>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081106032437.GA27237@euler> <20081106095122.GA2656@atjola.homenet> <buozlkd6oh1.fsf@dhapc248.dev.necel.com> <20081106122658.GB4192@atjola.homenet> <buozlkcqg0c.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Deskin Miller <deskinm@umich.edu>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 12:04:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyP96-00048a-2u
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 12:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbYKGLDm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2008 06:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbYKGLDm
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 06:03:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:42885 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751481AbYKGLDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 06:03:41 -0500
Received: (qmail invoked by alias); 07 Nov 2008 11:03:33 -0000
Received: from i577B9D1D.versanet.de (EHLO atjola.local) [87.123.157.29]
  by mail.gmx.net (mp036) with SMTP; 07 Nov 2008 12:03:33 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18RX4s16NERe/s5AEU2im4QRciTBFURQemh5tnBsj
	NK6pK/26oRhmZG
Content-Disposition: inline
In-Reply-To: <buozlkcqg0c.fsf@dhapc248.dev.necel.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: -0.07000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100302>

On 2008.11.07 14:09:07 +0900, Miles Bader wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
> >> > git reset --hard C
> >> > git rebase --onto ORIG_HEAD A^
> >>=20
> >> Is that safe...?  Doesn't git-rebase also set ORIG_HEAD?
> >
> > One of the first things rebase does is validating and resolving its
> > arguments. And that's happening before any actions that would touch
> > ORIG_HEAD.
>=20
> Ah, I see.
>=20
> Hmm, I guess using rebase --abort isn't a very good idea in this case
> though... :-/

Why not? I mean, ok, you end up at C, and not where you have been befor=
e
the reset --hard, but there's the reflog to help you get back to
whatever previous state of the branch it is that you want.

Bj=F6rn
