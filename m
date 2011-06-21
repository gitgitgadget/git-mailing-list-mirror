From: Paul Ebermann <Paul.Ebermann@esperanto.de>
Subject: Re: [PATCH] stash: Add --clean option to stash and remove all untracked
 files
Date: Tue, 21 Jun 2011 18:11:41 +0200
Message-ID: <4E00C2BD.6000903@esperanto.de>
References: <1308612986-26593-1-git-send-email-david@porkrind.org> <20110621003852.GB2050@sigill.intra.peff.net> <4DFFF5AA.4030401@porkrind.org> <4E002762.3050803@sohovfx.com> <4E003A0F.5080601@viscovery.net> <20110621141843.GA18700@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Andrew Wong <andrew.w@sohovfx.com>,
	David Caldwell <david@porkrind.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 21 18:11:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ3YQ-0006jo-6J
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 18:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756940Ab1FUQLt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jun 2011 12:11:49 -0400
Received: from njoerd.mathematik.hu-berlin.de ([141.20.53.126]:40404 "EHLO
	njoerd.mathematik.hu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751559Ab1FUQLt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2011 12:11:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by njoerd.mathematik.hu-berlin.de (Postfix) with ESMTP id F173A36A857;
	Tue, 21 Jun 2011 18:11:47 +0200 (CEST)
Received: from njoerd.mathematik.hu-berlin.de ([127.0.0.1])
 by localhost (njoerd.mathematik.hu-berlin.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08880-04; Tue, 21 Jun 2011 18:11:43 +0200 (CEST)
Received: from [141.20.50.149] (stilgar.mathematik.hu-berlin.de [141.20.50.149])
	by njoerd.mathematik.hu-berlin.de (Postfix) with ESMTP id 46E5636A84C;
	Tue, 21 Jun 2011 18:11:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.19) Gecko/20110420 SUSE/2.0.14-0.2.1 SeaMonkey/2.0.14
In-Reply-To: <20110621141843.GA18700@sigill.intra.peff.net>
X-Virus-Scanned: amavisd-new at mathematik.hu-berlin.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176168>

Jeff King schrieb:

> I would be happy with something that indicated "untracked files in
> addition to the regular stash". I just think it should be about "add
> these other files into the stash", not "end up in this directory stat=
e".
>=20
> Something like "--untracked-too" fits that, but is horribly ugly. I a=
lso
> think it makes sense to have some way of stashing everything, includi=
ng
> excluded files.  That could just be "-x" in conjunction with whatever
> this option is (which matches "git clean"), or it could be a separate
> option name (like "--all" or "--ignored").
>=20
> Things like "git stash --all" or "git stash --thorough" indicate that
> you are stashing more, but it's hard to remember what the "more" is.
>=20
> So I don't have any brilliant suggestions. Doing:
>=20
>   $ git stash --untracked-too --ignored-too
>=20
> is fairly clear, but somehow strikes me as unnecessarily ugly and
> verbose.

I think `--also-untracked` sounds better. It is even longer, though.

There could also be `--only-untracked`, which would stack only the
untracked files (and let changes of tracked files there).


Pa=C5=ADlo
