From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/6] git svn: Fix launching of pager
Date: Sun, 14 Feb 2010 23:58:24 -0800
Message-ID: <20100215075824.GA9997@dcvr.yhbt.net>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com> <20100213235156.GA9054@coredump.intra.peff.net> <20100214115430.GA1849@progeny.tock> <20100214120610.GD3499@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 08:58:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngvqh-0001Rm-3V
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 08:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab0BOH60 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2010 02:58:26 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:40291 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824Ab0BOH6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 02:58:25 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 598081F488;
	Mon, 15 Feb 2010 07:58:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100214120610.GD3499@progeny.tock>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139996>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> In commit dec543e (am -i, git-svn: use "git var GIT_PAGER"), I tried
> to teach git svn to defer to git var on what pager to use. In the
> process, I introduced two bugs:
>=20
>  - The value set for $pager in config_pager has local scope, so
>    run_pager never sees it;
>=20
>  - git var cannot tell whether git svn=E2=80=99s output is going to a
>    terminal, so the value chosen for $pager does not reflect that
>    information.
>=20
> Fix them.
>=20
> Reported-by: Sebastian Celis <sebastian@sebastiancelis.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Oops.  Eric, this bug is masked by another bug in "git var" whose fix
> is patch 2 from this series I sent to the list, but whatever happens,
> I think this is an improvement.  Sorry for the breakage.

Thanks Jonathan, confirmed this works with patch 2 of this series.

Acked-by: Eric Wong <normalperson@yhbt.net>

--=20
Eric Wong
