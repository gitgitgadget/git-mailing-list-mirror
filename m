From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT] add FreeBSD support
Date: Fri, 9 Aug 2013 11:20:46 -0400
Message-ID: <20130809152046.GL22686@poseidon.cudanet.local>
References: <1376051548-3126-1-git-send-email-wenqing.lz@taobao.com>
 <20130809144641.GK22686@poseidon.cudanet.local>
 <68E9B1AC-A3A3-47DD-B0A7-07752428D16D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "gnehzuil.liu" <gnehzuil.liu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 17:20:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7oUn-0005Et-EH
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 17:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934366Ab3HIPUt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Aug 2013 11:20:49 -0400
Received: from josefsipek.net ([64.9.206.49]:1594 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934081Ab3HIPUs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 11:20:48 -0400
Received: from poseidon.cudanet.local (unknown [64.235.151.250])
	by josefsipek.net (Postfix) with ESMTPSA id C4337554D8;
	Fri,  9 Aug 2013 11:20:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <68E9B1AC-A3A3-47DD-B0A7-07752428D16D@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231988>

On Fri, Aug 09, 2013 at 11:04:45PM +0800, gnehzuil.liu wrote:
> =D4=DA 2013-8-9=A3=AC=CF=C2=CE=E710:46=A3=ACJosef 'Jeff' Sipek <jeffp=
c@josefsipek.net> =D0=B4=B5=C0=A3=BA
>=20
> > On Fri, Aug 09, 2013 at 08:32:28PM +0800, Zheng Liu wrote:
> >> From: Zheng Liu <gnehzuil.liu@gmail.com>
> >>=20
> >> Currently guilt doesn't support FreeBSD platform.  This commit tri=
es to
> >> add this support.  The file called 'os.FreeBSD' is copied from os.=
Darwin
> >> due to these two platforms have almost the same command tools.
> >=20
> > Out of curiosity, is it identical?  I eyeballed it, and they do loo=
k
> > identical.  There's probably a better way to do this whole os-speci=
fic
> > thing, but this will work well enough for now.
>=20
> Yes, it is identical.  Sorry, I am a newbie for guilt, but I am happy=
 to
> improve this os-specific thing.    Any idea?

So, I'm a bit torn between some "build-time" checking that generates
something like an "os" file based on what it detects and something that
happens at runtime.  I like that currently there's nothing to do - you =
just
clone the repo and you're set.  At the same time, the more code can be
avoided executing the faster (in theory) guilt gets.

=46eel free to experiment.

Jeff.

--=20
The reasonable man adapts himself to the world; the unreasonable one
persists in trying to adapt the world to himself. Therefore all progres=
s
depends on the unreasonable man.
		- George Bernard Shaw
