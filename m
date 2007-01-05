From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [RFC] git-remote
Date: Fri, 5 Jan 2007 20:53:22 +0100
Message-ID: <8aa486160701051153h52a93c16k2b190f58e652cb2e@mail.gmail.com>
References: <7vfyarokk7.fsf@assigned-by-dhcp.cox.net>
	 <8aa486160701050459p4da586cdk2c2ddaabda5b4ca7@mail.gmail.com>
	 <Pine.LNX.4.63.0701051448560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 20:53:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2v84-0008C0-Cm
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 20:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbXAETxZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 5 Jan 2007 14:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbXAETxZ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 14:53:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:6369 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbXAETxY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 14:53:24 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5791308uga
        for <git@vger.kernel.org>; Fri, 05 Jan 2007 11:53:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cSRrdPOyn4iHM9J1YM6+ULY9obO1O6KVVEV+xmawH0ItCY+0rNBtN2EHznM58p0XO3+zLC+OEKtNh2d7Gpu7tOSpG+beu0anaWR8HhA65fCGHH2K3UTMAok0asy+oFkIVgMYfahWZQcHe8ONTrSU/sMtEwvyyenfCmTr4598yvE=
Received: by 10.78.204.1 with SMTP id b1mr6057319hug.1168026802680;
        Fri, 05 Jan 2007 11:53:22 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Fri, 5 Jan 2007 11:53:22 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701051448560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36017>

On 1/5/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 5 Jan 2007, Santi B=E9jar wrote:
>
> > * In "git remote add <name> <remote>": git could use the remote url=
 to
> > deduce a <name>, like what git-clone does.
>
> That does not make any sense. For example, I track
> "git://git.kernel.org/.../git.git" and "192.168.0.128:gits/git.git".
> Something very similar applies to the host name: if you track multipl=
e
> Linux repos, chances are that most of them are on git.kernel.org.
>
> I guess _if_ you have more than one upstream you are tracking (which =
is
> not the most common case, but hey, git-remote is for exactly that cas=
e) it
> is not uncommon to have similar urls.
>
> IMHO Junio's proposal is as good as it gets.
>

I was talking about the default name, so you could do:

$ git clone\
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
$ cd linux-2.6
$ git remote add \
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-2.6.git
$ git remote show libata-2.6

Santi
