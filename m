From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/7] Documentation: complicate example of "man git-command"
Date: Thu, 3 Jul 2008 08:06:37 +0200
Message-ID: <200807030806.37771.chriscool@tuxfamily.org>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu> <20080701162358.GA18305@fieldses.org> <7vmyl1kvn6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Jonathan Nieder <jrnieder@uchicago.edu>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jon Loeliger <jdl@jdl.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7x-0002yW-7c
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195AbYGCG77 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2008 02:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbYGCG6P
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:58:15 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:45182 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755123AbYGCGCn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2008 02:02:43 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id F329B1AB2D9;
	Thu,  3 Jul 2008 08:02:40 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 71ED11AB2BD;
	Thu,  3 Jul 2008 08:02:40 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vmyl1kvn6.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87255>

Le mercredi 2 juillet 2008, Junio C Hamano a =E9crit :
>
> 	E.g. a typical command description may go like this:
>
>         To propagate the changes you made back to the original subver=
sion
>         repository, you would use 'git-svn dcommit' command.  It does
>         these things (long description here).  Some examples:

We might kill 2 birds with a single stone by describing "git help" inst=
ead=20
of "git svn" (that the user may never use).

>         ------------
> 	$ ... some example command sequence ...
>         $ git svn dcommit
>         ------------
>
>         For full details, type:
>
> 	------------
>         $ man git-svn
>         ------------

I saw that in another thread "git help" is also being ported to Windows=
 and=20
I wonder if we want the tutorial to be usable as is by people on Window=
s=20
too.

I mean what if people on Windows launch "git help tutorial"? Should the=
y see=20
nothing or a tutorial for *nix or a special version of the tutorial for=
=20
Windows or a tutorial that works everywhere? I think the latter would b=
e=20
best but I wonder if it is possible.

Anyway if we want to get there, perhaps we should use "git help svn" ab=
ove=20
instead of "man git-svn". (Yeah "git help help" might be confusing at=20
first.)

Thanks,
Christian.

 =20
