From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: fatal: Unable to read current working directory: No error
Date: Tue, 17 Nov 2015 13:00:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511171253190.1686@s15462909.onlinehome-server.info>
References: <CAPkB0GxPghR9Y7YrB9yYq3rA9XZ2HJGN-sxbQgERGsBA2iOX_Q@mail.gmail.com> <20151028211415.GA24501@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean Krauth <spkrauth@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 17 13:00:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyewF-0007Jm-FL
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 13:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbbKQMAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 07:00:39 -0500
Received: from mout.gmx.net ([212.227.15.18]:53430 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbbKQMAi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 07:00:38 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0LvEZe-1aOkGu3SR0-010OHC;
 Tue, 17 Nov 2015 13:00:18 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20151028211415.GA24501@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:s+Bffs7cyJmv0mxVbczKe+9YYQ+FvK2mIfw/OiEl58stzF0Zn32
 fG9J2tZQ46YD7r5DsII25QqE3PplaF0mcybgB3D++GrI1d33tyFgIEX5AyeNDLkXsmDCX+m
 uyP7+nZzv1Lu9eUx8+Nd96v/WYL0v0SRSnROEl9gRv7FpF6db7qVFLdQLdAQn4fyuXoVwxt
 TGeTfzDiTYTDaKBEyPMSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zA1f46uc48c=:MLfLpB8cQqH+8B0D8leWYf
 MGY2UUjU1LHfRjn6DUyP8kuwe84eYcRKg4GUxINgEY4xx/32NK2LMlAcZ5nD93CwM8pXgqk/a
 kBbXWdtHPXNEuNjW7qUu55PJOk1SGa6XFZcw89aTjHZozZ2MmPqHIKZKiUijcVE4YdrGJ/DGp
 MhM07SgDeKy6IW1P1x41DqUn2Mqioei2h748dzQvzKH3/fIrC52muAWM14h1ZCgoD8uuTw5EF
 n83GFIeYeoYCr7LV5OrQqcuFL3e9pVNqWBqGQX88cEomYGic9zbqIrzWrwlQYJcztfMvwWXV5
 0mo50Qu3Qx2sLO2G6YqJnsy6V7giUTILD7eaXrSf/VjYOes3aHaTmtBkPsQfvDsTsEhMcSTdZ
 6GIq6HSKpqYn5IonhS8wxEv6f7q4Ug2FmswvNstxLvU6V/Yv3zUWOFHW4VpqObm4UkpZzETAS
 qPJpYr88nCQfIBMZwsn4H+m1wS616EUgqREPLhtOn/sYApG2C/1YYnyiWpV+qSu5ot6Xy2Q/v
 oTy/FQJkyd1WL19MpDilcgOzWr0Lo896ui6CeT523s/mjCDT1aBVbS9e2vwKPYV53SyxZgqOn
 GcfD8VOT2L1L0imz0TN5im5J+oUEy+XbHdgP/wRxNFx+vbj6tmlineaAmFC8b1gcsJ48Ao6j+
 oHNQ3wOg6BO8AM86tbZI5RIgiXoEs7yyUGmn18zbPtIbpU8QyohtoHDLpdJaKuxGeFvEs3f1o
 SDBA8mAjHS+eVKNoP3/+xGD7NmkgNVfdxJpRQIL65Y0B+K5qYgGY0nVMHPQJLH8fHyC/EJOF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281404>

Hi Peff,

On Wed, 28 Oct 2015, Jeff King wrote:

> On Tue, Oct 27, 2015 at 07:29:39PM -0400, Sean Krauth wrote:
> 
> > This seemed like about as good of an excuse as any to update Git. I
> > was running v. 2.5.1-32-bit and so I downloaded v. 2.6.2-32-bit,
> > installed it. And it ran, kinda. I no longer seem to have access to
> > any of my old commits and when I try to "git init" or "git status" I
> > get the above error, "fatal: Unable to read current working directory:
> > No error". This error pops up for anything, even new files that never
> > had a repository.
> 
> That message means that getcwd() is failing.

Quite possible. If the path is too long, for example, that might happen.
We have support for `core.longpaths` in Git for Windows, but it will only
help to a certain extent.

> It sounds like you're on a Windows system, and the problem may be
> system-specific. You might try asking at the specific Git for Windows
> list:
> 
>   https://groups.google.com/forum/?hl=en#!forum/git-for-windows
> 
> though many of those people do frequent this list, too.

Actually, I would much prefer proper bug reports in the GitHub issue
tracker, as described in https://git-for-windows.github.io/#contribute (in
particular, I would like bug reporters to at least *skim* the guide lines
https://github.com/git-for-windows/git/wiki/Issue-reporting-guidelines;
you would be surprised how many reports leave out pretty much all
interesting metadata, essentially stating "something broke, somewhere",
hoping that I can reproduce magically some vaguely described issue, which
of course I cannot, but I still have to spend hours just to figure that
out).

I would like to keep the Google Group only for Windows-specific questions
that do not necessarily involve a bug in our software.

Ciao,
Dscho
