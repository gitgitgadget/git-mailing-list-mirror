From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 2/2 v4] Git.pm: add test suite
Date: Wed, 18 Jun 2008 22:32:16 +0200
Message-ID: <485970D0.8020104@free.fr>
References: <d94c2a62edfdec22c32ef5d9649078430b30ecfd.1213685306.git.LeWiemann@gmail.com> <4db23d5b625de1aa026cf4630d49b57fd3a09d07.1213685306.git.LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 22:33:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K94LA-0003iH-H0
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 22:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbYFRUcL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2008 16:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753884AbYFRUcL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 16:32:11 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:33508 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626AbYFRUcK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 16:32:10 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id E47F912B6FF;
	Wed, 18 Jun 2008 22:32:08 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 85F3512B74F;
	Wed, 18 Jun 2008 22:32:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <4db23d5b625de1aa026cf4630d49b57fd3a09d07.1213685306.git.LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85411>

Lea Wiemann a =E9crit :
>=20
> diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
> new file mode 100755
> index 0000000..592d79a
> --- /dev/null
> +++ b/t/t9700-perl-git.sh
> @@ -0,0 +1,39 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2008 Lea Wiemann
> +#
> +
> +test_description=3D'perl interface (Git.pm)'
> +. ./test-lib.sh
> +
> +# set up test repository
> +
> +test_expect_success \
> +    'set up test repository' \
> +    'echo "test file 1" > file1 &&
> +     echo "test file 2" > file2 &&
> +     mkdir directory1 &&
> +     echo "in directory1" >> directory1/file &&
> +     mkdir directory2 &&
> +     echo "in directory2" >> directory2/file &&
> +     git add . &&
> +     git commit -m "first commit" &&
> +
> +     echo "changed file 1" > file1 &&
> +     git commit -a -m "second commit" &&
> +
> +     git-config --add color.test.slot1 green &&
> +     git-config --add test.string value &&
> +     git-config --add test.dupstring value1 &&
> +     git-config --add test.dupstring value2 &

While I was running the whole test suite, your test cases randomly
failed. I did not understand until I see the missing & here. ;-)

Olivier.
