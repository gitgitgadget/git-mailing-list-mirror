From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: testsuite problems
Date: Mon, 17 Sep 2007 23:50:32 +0200
Message-ID: <46EEF6A8.1030308@lsrfire.ath.cx>
References: <20070917211742.GF19019@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 23:54:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXOXX-0008A2-C0
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 23:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760159AbXIQVuv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 17:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760134AbXIQVuu
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 17:50:50 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:50499
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760125AbXIQVut (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2007 17:50:49 -0400
Received: from [10.0.1.201] (p57B7E410.dip.t-dialin.net [87.183.228.16])
	by neapel230.server4you.de (Postfix) with ESMTP id 4038F873BA;
	Mon, 17 Sep 2007 23:50:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070917211742.GF19019@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58484>

Miklos Vajna schrieb:
> *   ok 18: git archive --format=3Dzip
> *   ok 19: extract ZIP archive
> *   ok 20: validate filenames
> * FAIL 21: validate file contents
>         diff -r a d/a
> *   ok 22: git archive --format=3Dzip with prefix
> *   ok 23: extract ZIP archive with prefix
> *   ok 24: validate filenames with prefix
> * FAIL 25: validate file contents with prefix
>         diff -r a e/prefix/a
> *   ok 26: git archive --list outside of a git repo
> * failed 2 among 26 test(s)
> make[1]: *** [t5000-tar-tree.sh] Error 1
> make[1]: Leaving directory `/home/vmiklos/git/git/t'
> make: *** [test] Error 2
>=20
> $ tar --version
> tar (GNU tar) 1.18
>=20
> $ diff --version
> diff (GNU diffutils) 2.8.1
>=20
> maybe these versions are too new or old? if i missed any needed info,
> please let me know.

The failing tests check ZIP file creation, not tar file creation.
Perhaps your unzip command works a bit differently from Info-ZIP's?

Also, what is the difference between t/trash/a and t/trash/d/a after
running the test script (that's what test 21 is comparing)?

Ren=E9
