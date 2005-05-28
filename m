From: David Lang <dlang@digitalinsight.com>
Subject: Re: More gitweb queries..
Date: Fri, 27 May 2005 19:51:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0505271949480.15585@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org><20050527235924.GB19491@vrfy.org>
 <f0796bb705052718035cd5dbe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 04:50:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbrOT-0003XZ-VH
	for gcvg-git@gmane.org; Sat, 28 May 2005 04:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVE1Cvy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 27 May 2005 22:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVE1Cvy
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 22:51:54 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:60378 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262429AbVE1Cvw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 22:51:52 -0400
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Fri, 27 May 2005 19:46:47 -0700
Received: by atlexc01.digitalinsight.com with Internet Mail Service (5.5.2657.72)
	id <LN1B3PMX>; Fri, 27 May 2005 22:49:10 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id LNM38CPA; Fri, 27 May 2005 19:51:38 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: Daniel Serpell <daniel.serpell@gmail.com>
In-Reply-To: <f0796bb705052718035cd5dbe2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Hi!
>
> On 5/27/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
>> On Fri, May 27, 2005 at 12:24:20PM -0700, Linus Torvalds wrote:
>>>   Combining some of the features of the two (that =FCber-cool revis=
ion
>>>   history graph from gitk rules, for example) might be cool. I get =
the
>>>   urge to do octopus-merges in the kernel just because of how good =
they
>>>   look in gitk ;) ]
>>
>> I would like to show something like the graph too, but I don't reall=
y know
>> how to do this in html. Seems slippery if not impossible.
>> If anybody has a nice idea how to represent that, I will give it a t=
ry.
>
> Well, you could draw them in javascript, using
> http://www.walterzorn.com/jsgraphics/jsgraphics_e.htm :-)
>
> Alternatively, you could use a fixed set of little images, a bar "|",=
 a
> dot "o" and branches like "Y", "7" and "\". Obviously, octopus-merges
> are very difficult to draw using only those.

you could look into SVG (scaleable vector graphics or some such thing)=20
that are supposed to be in the newest browsers (or soon to be added, I'=
m=20
not sure). this should let you do all the drawing nessasary reasonably=20
easily (if you are willing to limit users to that, which is probably no=
t=20
that big of a problem for git)

David Lang

--=20
There are two ways of constructing a software design. One way is to mak=
e it so simple that there are obviously no deficiencies. And the other =
way is to make it so complicated that there are no obvious deficiencies=
=2E
  -- C.A.R. Hoare
