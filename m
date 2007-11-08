From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Inconsistencies with git log
Date: Thu, 8 Nov 2007 09:29:14 +0100
Message-ID: <20071108082914.GA28800@xp.machine.xx>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> <Pine.LNX.4.64.0711072242230.4362@racer.site> <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> <Pine.LNX.4.64.0711072255420.4362@racer.site> <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com> <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com> <47325415.1070205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:29:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2lZ-0002gr-07
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbXKHI3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbXKHI3R
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:29:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:51899 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751295AbXKHI3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:29:16 -0500
Received: (qmail invoked by alias); 08 Nov 2007 08:29:14 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp047) with SMTP; 08 Nov 2007 09:29:14 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/e3+lGAULeW8QUknutgrTKCFfxDOkU1dZte6SG8w
	VLOdV8Yk2XuUKd
Content-Disposition: inline
In-Reply-To: <47325415.1070205@op5.se>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63964>

On Thu, Nov 08, 2007 at 01:11:01AM +0100, Andreas Ericsson wrote:
> David Symonds wrote:
>> On Nov 8, 2007 10:19 AM, Brian Gernhardt <benji@silverinsanity.com> wrote:
>>> However, Dave's suggestion of altering git-status output to be
>>> relative to (but not limited by) CWD has merit.  Too bad I don't have
>>> time to work on it right now.
>>
>> I am happy to hack on this if there's not widespread revolt against the concept.
>>
>
> I'd definitely like that feature, but I wonder how many people will run
> "git commit -a" in a subdir after seeing only what they want to see in the
> output, and then accidentally committing junk somewhere else in the repo.
>
> So perhaps git-commit -a should also be path-delimited, but where would we
> end up then? It might be better to just let git-status accept a path
> delimiter and let the path delimiter default to current work-dir.
>

I agree that 'git status' should show the *whole* tree and if it will work
in subdirectories with 'git status .' or 'git status Documentation', it
would be a nice UI improvement.

But please don't make it always show only the current subdir.

-Peter
