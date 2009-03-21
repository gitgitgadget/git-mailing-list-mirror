From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Documentation: Reworded example text in git-bisect.txt.
Date: Sat, 21 Mar 2009 05:28:32 +0100
Message-ID: <200903210528.32392.chriscool@tuxfamily.org>
References: <1237520134-18044-1-git-send-email-dmellor@whistlingcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: "David J. Mellor" <dmellor@whistlingcat.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 05:35:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LksvZ-0003rI-VI
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 05:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbZCUE3b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2009 00:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbZCUE3a
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 00:29:30 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:53601 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbZCUE3a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Mar 2009 00:29:30 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 0F5A9E0805C;
	Sat, 21 Mar 2009 05:29:20 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 4003CE0806D;
	Sat, 21 Mar 2009 05:29:17 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1237520134-18044-1-git-send-email-dmellor@whistlingcat.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114028>

Le vendredi 20 mars 2009, David J. Mellor a =E9crit :

[...]

> @@ -94,14 +95,14 @@ the bisection state).
>  Bisect visualize
>  ~~~~~~~~~~~~~~~~
>
> -During the bisection process, you issue the command:
> +To see the currently remaining suspects in 'gitk', the following com=
mand
> +is issued during the bisection process:

I think it's better to avoid the passive tone, for example like this:

"To see the currently remaining suspects in 'gitk', you issue the follo=
wing=20
command during the bisection process:"

>  ------------
>  $ git bisect visualize
>  ------------

[...]

> @@ -173,8 +175,8 @@ using the "'<commit1>'..'<commit2>'" notation. Fo=
r
> example: $ git bisect skip v2.5..v2.6
>  ------------
>
> -would mean that no commit between `v2.5` excluded and `v2.6` include=
d
> -can be tested.
> +The effect of this would be that no commit between `v2.5` excluded a=
nd
> +`v2.6` included could be tested.

I'd prefer something like:

"This tells the bisect process that no commit between `v2.5` excluded a=
nd=20
`v2.6` included can be tested."

Otherwise it looks good to me.

Thanks,
Christian.
