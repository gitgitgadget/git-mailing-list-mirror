From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Mon, 22 Oct 2007 09:24:50 +0200
Message-ID: <20071022072450.GB32763@artemis.corp>
References: <20071022063222.GS14735@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="3V7upXqbjpZ4EhLz";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 09:25:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijrf1-0003l2-CI
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 09:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260AbXJVHYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 03:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754241AbXJVHYx
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 03:24:53 -0400
Received: from pan.madism.org ([88.191.52.104]:33099 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762AbXJVHYw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 03:24:52 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D760026268;
	Mon, 22 Oct 2007 09:24:50 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5BAAC3CC1E0; Mon, 22 Oct 2007 09:24:50 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071022063222.GS14735@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61965>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2007 at 06:32:22AM +0000, Shawn O. Pearce wrote:
> * ph/parseopt (Mon Oct 15 23:06:02 2007 +0200) 22 commits
>  - Make builtin-pack-refs.c use parse_options.
>  - Make builtin-name-rev.c use parse_options.
>  - Make builtin-count-objects.c use parse_options.
>  - Make builtin-fsck.c use parse_options.
>  - Update manpages to reflect new short and long option aliases
>  - Make builtin-for-each-ref.c use parse-opts.
>  - Make builtin-symbolic-ref.c use parse_options.
>  - Make builtin-update-ref.c use parse_options
>  - Make builtin-revert.c use parse_options.
>  - Make builtin-describe.c use parse_options
>  - Make builtin-branch.c use parse_options.
>  - Make builtin-mv.c use parse-options
>  - Make builtin-rm.c use parse_options.
>  - Port builtin-add.c to use the new option parser.
>  - parse-options: allow callbacks to take no arguments at all.
>  - parse-options: Allow abbreviated options when unambiguous
>  - Add shortcuts for very often used options.
>  - parse-options: make some arguments optional, add callbacks.
>  - Rework make_usage to print the usage message immediately
>  - Add tests for parse-options.c
>  - parse-options: be able to generate usages automatically
>  - Add a simple option parser.
>
> There's actually a few other commits (3?) missing from the above
> list that are safely parked away in my tree.  I'm most of the way
> through reviewing these and have made a few bug fixes and style
> nit corrections in the earlier parts of the series.  I'm going to
> try and finish working through this series tomorrow and then will
> probably merge it to next.


> The other 3 commits are hanging off to the side as 2 of them are
> for the top of db/fetch-pack (to port builtin-fetch and friends
> to the new option parser) and the 3rd is a somewhat questionable
> change due to needing to rename a "-h" to a "-H".  I just got
> tired of rebasing these 3 other commits onto the respective topics.
> I'm waiting for the core option parser (above) to freeze on a commit
> SHA-1 before I deal with these again.

  You also can ask me to resubmit them when the first round of parseopt
is merged. I'm actually waiting for that before I work on it again
(that's not the sole reason, $work ate my time as well, so I'm not
pressuring ;P) and I can send those again when things are more ready for
them.

  Like I said to you on IRC, I intend to hack a way to ask parse-options
to dump its options in a machine parseable way, to help {z,ba}sh
completions authors. And obviously I intend to migrate even more
builtins :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHHFBCvGr7W6HudhwRAnTYAKCCf6FW4xo87yx4bUQGqZZCiWuYFQCfWVKo
9ZOaCOYHYKRMG1LNySJaT2c=
=znTL
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
