From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] help: implement multi-valued "man.viewer" config option
Date: Fri, 14 Mar 2008 06:26:15 +0100
Message-ID: <200803140626.16075.chriscool@tuxfamily.org>
References: <20080311085113.176df1af.chriscool@tuxfamily.org> <200803120823.38100.chriscool@tuxfamily.org> <200803140100.m2E105o5004664@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Xavier Maillard <xma@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 06:21:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja2MT-0006Qx-9g
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 06:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756984AbYCNFUg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 01:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756928AbYCNFUg
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 01:20:36 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:38061 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756897AbYCNFUf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 01:20:35 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 757E71AB2CB;
	Fri, 14 Mar 2008 06:20:34 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 558971AB2B7;
	Fri, 14 Mar 2008 06:20:34 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200803140100.m2E105o5004664@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77182>

Le vendredi 14 mars 2008, Xavier Maillard a =E9crit :
>    > Ok, woma in not supported here and it is reported like this but
>    > would it be possible to just throw an error on stdout and try
>    > another viewer ?
>
>    Yes, with the following patch on top:
>
> See my "tested-by" message.

Thank you Xavier for this message.

>    > We could even imagine something even more
>    > general like the possibility for the user to write his own man
>    > viewer (a bash script for example) and set it as a candidate.
>
>    I will do that in a latter patch, it has been suggested a lot of t=
imes
>    already.
>
> Glad to read that !

I just sent a patch to do that in "git-web--browse.sh" and I will soon =
work=20
on the same stuff for man viewing.

>    > By the way, I do not see any reason to put man as a candidate.
>    > "man" should be the default when nothing is specified or when al=
l
>    > candidates have failed.
>
>    It may be more explicit.
>
> Well, I do not buy this argument and I am pretty sure that a
> simple note into the manual would suffice but, that's me :)

As my patch is now on next and as I am not sure to understand exactly w=
hat=20
you want, I can only suggest to send a patch if you really care.

Thanks,
Christian.
