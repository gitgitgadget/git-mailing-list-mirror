From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: git gui does not open bare repositories
Date: Mon, 01 Oct 2012 08:22:21 +0200
Message-ID: <5069369D.40402@atlas-elektronik.com>
References: <CAB9Jk9CA+e8xR9sz7cW+5+990FmTeYN3pjxs4ZKFpkzb6OL35Q@mail.gmail.com> <CAH6sp9N1cFH7orPNmfbhgHq6oUNtQNe=-5f5jkYNXzr+6Xp_pQ@mail.gmail.com> <CAB9Jk9BivVrH7daMR=u5Y6Ut=pZGRBcgKNZ_afZ53XFxhFBnZw@mail.gmail.com> <CAH6sp9ME0og0E-=oW6MBFMBv8hD0y8PpmdpyaV4qqr7Mb7c5VA@mail.gmail.com> <50656388.3050400@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 08:23:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIZPT-0005Pc-SQ
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 08:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132Ab2JAGWZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Oct 2012 02:22:25 -0400
Received: from mail96.atlas.de ([194.156.172.86]:33483 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822Ab2JAGWY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 02:22:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 8718A100F0;
	Mon,  1 Oct 2012 08:22:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id wvF0_zc6l2E2; Mon,  1 Oct 2012 08:22:22 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Mon,  1 Oct 2012 08:22:22 +0200 (CEST)
Received: from [141.200.59.243] (pcndmc01.atlas.de [141.200.59.243])
	by mgsrv01.atlas.de (Postfix) with ESMTP id BEBCF2716A;
	Mon,  1 Oct 2012 08:22:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <50656388.3050400@atlas-elektronik.com>
X-Enigmail-Version: 1.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206716>

Am 28.09.2012 10:44, schrieb Stefan N=C3=A4we:

> I get "Not a Git repository: remote.git" as well, when I run
> git gui "somewhere" (i.e. not in "remote.git")=20

i.e.:

  $ cd /not/a/repo
  $ git gui

> and the select "Open Existing Repository".
>=20
> I get "Cannot use bare repository: .../remote.git" when I run git gui
> from inside the "remote.git" directory.

i.e.:

  $ cd /path/to/bare-repo.git
  $ git gui

> Both on WinXP with msysGit.

And the same on Linux with Git v1.7.12

Stefan
--=20
----------------------------------------------------------------
/dev/random says: Press any key to continue or any other key to quit...
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"
