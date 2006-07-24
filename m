From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Per branch properties for pull
Date: Mon, 24 Jul 2006 00:31:04 -0700
Message-ID: <7vmzaze9xj.fsf@assigned-by-dhcp.cox.net>
References: <87hd1b9fjq.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 24 09:31:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4uuF-0007T8-6t
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 09:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWGXHbH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 24 Jul 2006 03:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWGXHbH
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 03:31:07 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:23445 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751436AbWGXHbG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jul 2006 03:31:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060724073105.WJHD2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Jul 2006 03:31:05 -0400
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <87hd1b9fjq.fsf@gmail.com> (Santi =?iso-8859-1?Q?B=E9jar's?=
 message of "Fri, 21
	Jul 2006 16:51:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24131>

Santi B=E9jar <sbejar@gmail.com> writes:

> It extracts all the information for pull from the config file.
>
> If you have a config file as:
>
> [branch "master"]
>         remote=3Dorigin
>         merge=3Dnext          #the remote name
>         octopus=3Doctopus
>         twohead=3Drecursive
>
> When doing a "git pull" without extra parameters in the master branch
> it will fetch the origin remote repository and will merge the next
> branch (the remote name).
>
> And you can also put the equivalent of the pull.{octopus,twohead}
> options for each branch.
>
> This only changes the behavour when these keys exist and when
> git-pull is used without extra parameters.
>
> Signed-off-by: Santi B=E9jar <sbejar@gmail.com>

I am in general in agreement with this line of thought and had
an impression that many on the list wanted to have per-branch
configuration.  I am a bit too tired now so I'd just let you
know I am interested but would not apply it tonight.

Opinions?  Comments?  Anything missing or objectionable on
Santi's patch from the list?
