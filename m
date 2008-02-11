From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Improve git-help--browse browser support under OS X
Date: Mon, 11 Feb 2008 06:03:51 +0100
Message-ID: <200802110603.51515.chriscool@tuxfamily.org>
References: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com> <200802101445.16033.chriscool@tuxfamily.org> <76718490802101813n5b2121fcp25b4c65eb32ab14e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org
To: "Jay Soffian" <jaysoffian+git@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 05:58:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOQkf-0002Iy-TI
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 05:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbYBKE5z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 23:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbYBKE5z
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 23:57:55 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:34902 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbYBKE5y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 23:57:54 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id BA1471AB2B8;
	Mon, 11 Feb 2008 05:57:53 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9E3331AB2B4;
	Mon, 11 Feb 2008 05:57:53 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <76718490802101813n5b2121fcp25b4c65eb32ab14e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73467>

Le lundi 11 f=E9vrier 2008, Jay Soffian a =E9crit :
> On Feb 10, 2008 8:45 AM, Christian Couder <chriscool@tuxfamily.org> w=
rote:
> > I wonder if "open" works on OS X outside the OS X GUI environment. =
(And
> > do people use OS X outside the OS X GUI environment ?)
>
> "open" simulates double-clicking on a document icon, so, no it does
> not make sense to use it unless the GUI is active. What I was
> referring to though is that you can't ssh into another OS X host and
> use open, even if there is a user logged into the GUI on that host,
> for obvious security reasons.

Ok, thanks for this information.

> > In the git "next" branch, "git-help--browse" has been
> > renamed "git-web--browse". And the original patch is
> > against "git-web--browse" except in the title where it is
> > about "git-help--browse".
>
> Yeah, my typo in the title.
>
> > Anyway now in "next", "git-web--browse" is used by both "git help" =
and
> > "git instaweb", so the documentation of both commands need an updat=
e.
>
> The git instaweb documentation update should be in a separate patch.
> Though I think maybe the right way to handle this is add a new doc fo=
r
> git-web--browse and then have the instaweb and help docs refer to
> that, no?
>
> BTW, what is the reason for the two-dashes in git-web--browse's name?

The two-dashes means that it's an helper script, and this means that it=
 may=20
not have it's own documentation. Anyway maybe I will create a documenta=
tion=20
for it and move common information from Documentation/git-help.txt and=20
Documentation/git-instaweb.txt into it.

Thanks,
Christian.
