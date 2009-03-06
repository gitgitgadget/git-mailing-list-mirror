From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Documentation: More examples for git bisect
Date: Fri, 6 Mar 2009 21:08:09 +0100
Message-ID: <200903062108.09758.chriscool@tuxfamily.org>
References: <1236332255-15712-1-git-send-email-johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 21:10:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfgNU-0002bw-A2
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 21:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641AbZCFUJI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 15:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753270AbZCFUJH
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 15:09:07 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:53899 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbZCFUJF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 15:09:05 -0500
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 4F54C94018E;
	Fri,  6 Mar 2009 21:08:56 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 657FE9400D6;
	Fri,  6 Mar 2009 21:08:54 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1236332255-15712-1-git-send-email-johnflux@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112477>

Le vendredi 6 mars 2009, John Tapsell a =E9crit :
> Including passing parameters to the programs, and running more
> complicated checks without requiring a seperate shell script.
>
> Signed-off-by: John Tapsell <johnflux@gmail.com>
> ---
>  Documentation/git-bisect.txt |   27 ++++++++++++++++++++++++++-
>  1 files changed, 26 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.=
txt
> index 147ea38..7b8cfdd 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -212,7 +212,7 @@ If you have a script that can tell if the current
> source code is good or bad, you can automatically bisect using:
>
>  ------------
> -$ git bisect run my_script
> +$ git bisect run my_script arguments
>  ------------
>
>  Note that the "run" script (`my_script` in the above example) should
> @@ -251,6 +251,22 @@ EXAMPLES
>  $ git bisect start HEAD v1.2 --      # HEAD is bad, v1.2 is good
>  $ git bisect run make                # "make" builds the app
>  ------------
> ++
> +This looks for the first revision that fails to build between HEAD a=
nd
> +the tag 'v1.2'.

There are a few trailing spaces in the above line but otherwise the pat=
ch=20
looks good to me.

Acked-by: Christian Couder <chriscool@tuxfamily.org>

By the way, it would be nice if you could put me in CC.

Thanks,
Christian.
