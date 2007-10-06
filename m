From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [msysGit] Re: Git Inno Setup based installer
Date: Sun, 7 Oct 2007 00:15:19 +0200
Message-ID: <461A17DA-91D5-4F17-BD61-0C2840CE0E32@zib.de>
References: <898798EC-8486-4B18-B4FE-52015035BC2F@zib.de> <1191682524.589150.297160@22g2000hsm.googlegroups.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: kirillathome@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 07 00:14:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeHuX-0003aG-Ed
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 00:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbXJFWOA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Oct 2007 18:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbXJFWOA
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 18:14:00 -0400
Received: from mailer.zib.de ([130.73.108.11]:36741 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbXJFWN7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2007 18:13:59 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l96MDlFL017007;
	Sun, 7 Oct 2007 00:13:47 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1ac3b.pool.einsundeins.de [77.177.172.59])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l96MDjgH017665
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 7 Oct 2007 00:13:46 +0200 (MEST)
In-Reply-To: <1191682524.589150.297160@22g2000hsm.googlegroups.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60160>

Dear Kirill,
Thanks for your feedback. I very much appreciate any comments on the
installer. They all help to improve our work.


On Oct 6, 2007, at 4:55 PM, Kirill wrote:
> Great! Thanks to you I finally got git-1.5.3 that works on Windows (a=
t
> least locally)! Appreciated!

good to hear.


> Now, didn't you ask for a feedback? :)
>
> I. Each time I start git-gui it tells me that:
> Git version cannot be determined.
> C:/wingit/bin/git.exe claims it is version '1.5.3.mingw.1.99.ga821'.
> Git Gui requires at least Git 1.5.0 or later.
> Assume '1.5.3.mingw.1.99.ga821' is version 1.5.0?
>
> Before I try to hunt it down, is it an easy fix?

It is easy to fixed and I already have a patch in the pipeline.
I know it's a bit annoying but it's not really a critical issue.
Therefore I'll not create a new installer right away.


> II. I noticed that in the latest version of Git Gui then Branch menu
> does not have items to quickly switch to another branch (basically
> items, named after branches). Is it very hard to get them back?
>
> I did not report it earlier because all my previous attempts to get
> fully working version failed.

Note, I'm currently focusing on the Windows installer, while git-gui
is a project of it's own. Git gui is not specific to Windows but a
cross platform tool that runs on Unix as well. git-gui is part of the
official git repository. I just take what git-gui offers and pack it
into the installer. Most of the real work was done by Shawn O. Pearce.

The right platform for discussing git-gui specific issues is the
official git mailing list (not the msysgit list). I added the list
in CC. I can't comment on this issue in detail because I'm not using
Git Gui that frequently. Maybe someone else from the git mailing list
has a comment?



> III. Also, I was pleasantly surprised that git-gui is localized to
> Russian (probably among many other languages). However, the above
> message is missing from localization. So on Russian system I got an
> empty message, asking Yes or No. Is it easy to fix too? If you want
> real Russian there, here you are:
> =D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BE=D0=BF=D1=80=D0=B5=D0=B4=D0=
=B5=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E Git.
> =D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F C:/wingit/bin/git.exe: '1.5.3.mi=
ngw.1.99.ga821'.
> Git Gui =D1=82=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82 =D0=BA=D0=B0=D0=BA=
 =D0=BC=D0=B8=D0=BD=D0=B8=D0=BC=D1=83=D0=BC Git 1.5.0.
> =D0=A1=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C '1.5.3.mingw.1.99.ga821' =D0=
=B2=D0=B5=D1=80=D1=81=D0=B8=D0=B5=D0=B9 1.5.0?

I know about the localization efforts but I did not closely follow
them. All the cedits go to people on the git mailing list who worked
on the localization.

Maybe someone could pick up your suggestion and prepare a patch for
git-gui? Personally, I don't know how to do this.

	Steffen

> On Oct 5, 3:30 pm, Steffen wrote:
>
>> I also created an installer, which you can find at
>>
>> http://www.zib.de/prohaska/2007/git/Git-1.5.3-preview20071005.exe
>>
>> The installer contains the branches devel merged with
>> steffen/shawn-git-gui.
