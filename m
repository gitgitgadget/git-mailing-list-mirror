From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Wed, 24 Oct 2007 23:06:24 +0200
Message-ID: <471FB3D0.4040800@op5.se>
References: <Pine.LNX.4.64.0710221445170.25221@racer.site> <471CB443.9070606@op5.se> <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 23:07:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IknR5-0001Yo-KU
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 23:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbXJXVGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 17:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754182AbXJXVG3
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 17:06:29 -0400
Received: from mail.op5.se ([193.201.96.20]:36606 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754142AbXJXVG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 17:06:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id AC34917306B9;
	Wed, 24 Oct 2007 23:06:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dIka03PyBpIV; Wed, 24 Oct 2007 23:06:25 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 5667B17306B0;
	Wed, 24 Oct 2007 23:06:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071024203335.GJ29830@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62239>

J. Bruce Fields wrote:
> On Wed, Oct 24, 2007 at 10:12:29PM +0200, Steffen Prohaska wrote:
>> On Oct 24, 2007, at 9:48 PM, J. Bruce Fields wrote:
>>
>>>> I want git pull to work like git push.
>>> That strikes me as a less complete solution, since it only helps in the
>>> case where the other branches all happen to be unmodified locally (hence
>>> can be fast-forwarded).  In other cases the "git push" will still emit a
>>> spurious error.
>> Well, but then there's something you should really think
>> about.
> 
> Perhaps, but not necessarily; you may have some branches with local
> changes that you're content to leave unpushed (and un-updated).
> 

Sure, but that won't change. The only thing I'm proposing is that
local copies of remote branches are automatically fast-forwarded
on every pull, but only if

* the branch has no modifications what so ever
* the branch is set up to auto-merge with the particular branch
fetched from the particular remote

I really don't see any downsides what so ever with this. Those
of you who do, please enlighten me.

> 	- the user has one or more unmodified copies of remote branches
> 	  lying around, and

Extremely common case for a large group of users. The worst part is
that this problem can get extremely annoying pretty quickly, with a
large number of repos and a large number of branches, whereas the
one dev per repo folks will never have big worries about it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
