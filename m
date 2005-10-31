From: David Lang <dlang@digitalinsight.com>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild
 bug)
Date: Mon, 31 Oct 2005 13:31:33 -0800 (PST)
Message-ID: <Pine.LNX.4.62.0510311330050.16906@qynat.qvtvafvgr.pbz>
References: <43652934.8000308@zytor.com><7vy84ajl4c.fsf@assigned-by-dhcp.cox.net><20051031064105.GV8041@shell0.pdx.osdl.net><43663EEA.5050102@zytor.com>
 <7v4q6xfpqg.fsf@assigned-by-dhcp.cox.net><46a038f90510311213n565010d6g5586a7484b25da7e@mail.gmail.com><Pine.LNX.4.64.0510311230290.27915@g5.osdl.org>
 <46a038f90510311244n5fc35166k43ea2410e92d83d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	Sebastian Kuzminsky <seb@highlab.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 22:33:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWhGM-00060X-Up
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 22:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVJaVcQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 16:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVJaVcQ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 16:32:16 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:58083 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S964840AbVJaVcP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 16:32:15 -0500
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Mon, 31 Oct 2005 13:27:21 -0800
Received: by atlexc01.digitalinsight.com with Internet Mail Service (5.5.2657.72)
	id <V77WNDXM>; Mon, 31 Oct 2005 16:29:38 -0500
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id V817MXKA; Mon, 31 Oct 2005 13:30:23 -0800
X-X-Sender: dlang@dlang.diginsite.com
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510311244n5fc35166k43ea2410e92d83d4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10890>

On Tue, 1 Nov 2005, Martin Langhoff wrote:

> On 11/1/05, Linus Torvalds <torvalds@osdl.org> wrote:
>> I really really prefer gitk in the core, even if it means that there's
>> that strange tcl/tk dependency.
>
> I agree, but that's kind of a bummer for servers where someone just
> wants to publish a couple of repos. tk depends on xlibs/libx11 and
> that's just _nasty_.
>
> git-core should be good for deployment on a server. Perhaps we want to
> provide a git-scm package that brings in all the goodies you're likely
> to want, including gitk?

for debian make it a reccomendation not a requirement, for RPM the admins 
will just have to override the dependancy (it's not like they don't have 
to do this for a bunch of other packages that have an optional GUI piece, 
RPM just doesn't have the option to list a reccomendation)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
