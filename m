From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: web-based client for Git, was Re: GSoC 2010
Date: Fri, 12 Feb 2010 12:04:23 +0100
Message-ID: <3af572ac1002120304q798bf3a2q94374595a7783b5@mail.gmail.com>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com>
	 <20100211214833.GU9553@machine.or.cz>
	 <201002120502.43565.chriscool@tuxfamily.org>
	 <e72faaa81002120222p19db9c75u737e2615c14930b1@mail.gmail.com>
	 <e72faaa81002120226y5e4b1c28tbaf6a7dccb9634dc@mail.gmail.com>
	 <alpine.DEB.1.00.1002121149470.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 12 12:04:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NftK2-0002qu-P8
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 12:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab0BLLEZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 06:04:25 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:39977 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab0BLLEY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 06:04:24 -0500
Received: by pzk2 with SMTP id 2so1961769pzk.21
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 03:04:23 -0800 (PST)
Received: by 10.140.248.7 with SMTP id v7mr811955rvh.237.1265972663206; Fri, 
	12 Feb 2010 03:04:23 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002121149470.20986@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139682>

Hello,

Let me suggest Wt ( http://webtoolkit.eu ) for the web development.

It's C++ and GPLv2, therefore he may be able to directly use libgit2
or copy&paste source code from git. In fact, one of the examples Wt
includes in the source tarball is a git viewer:
http://www.webtoolkit.eu/wt/examples/gitmodel/gitview.wt
http://www.webtoolkit.eu/wt#/src/gitmodel

In addition to that, if someone is interested in contributing to
libQtGit ( http://gitorious.org/libqtgit ) as his/her GSoC, I'd be
more than happy to accept contributors. API is done for the most used
commands but is lacking implementation (read: append to a QStringList
the parameters I added to the comments for the Q_ENUMS, then invoke
QProcess and parse output). Some important commands which have not
been translated to the libQtGit API are 'dif', 'log' and 'submodules'.
Some more information on libQtGit here: http://www.elpauer.org/?p=3D419

On Fri, Feb 12, 2010 at 11:56 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Pavan,
>
> [culling the Cc: list to the most likely interested parties]
>
> On Fri, 12 Feb 2010, Pavan Kumar Sunkara wrote:
>
>> =A0 I am Pavan Kumar, a computer science student from Indian Institu=
te of
>> Technology, Madras. I would like to propose a new project for git GS=
oC
>> 2010. I am new to git development community but i would like to star=
t
>> contributing to it by participating as GSoC student to develop a GUI
>> client for git usage. Basically it will be a web client that can be
>> accessed from other computers.
>
> This is great stuff. As you know, the ideas page is really only about
> giving the students ideas what type of projects we'd like to see. But=
 it
> is always better to have a project with your heart and soul behind it=
=2E
>
> Provided that we get accepted, you will have time to put up an applic=
ation
> for this project between March 29 and April 9, according to the timel=
ine:
>
> http://socghop.appspot.com/document/show/gsoc_program/google/gsoc2010=
/faqs#timeline
>
> But I think you wanted to hear some feedback to your idea. So here go=
es my
> feedback:
>
> - It is a very interesting idea. I already know a few users who would=
 be
> =A0happy to use it.
>
> - It is good that you mention the preferred programming language... W=
hile
> =A0I got used to Python, I am by far not good enough to mentor :-)
>
> - There is little chance that this project will become a core part of=
 Git,
> =A0as it is too far outside of the original focus of it, namely allow=
ing
> =A0developers to version-control their source code they have in a loc=
al
> =A0directory.
>
> That latter point does not say that your project is not worth it, tho=
ugh!
> As I said, I think it would be very useful to have.
>
> Ciao,
> Dscho
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
