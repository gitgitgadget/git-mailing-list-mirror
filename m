From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: Git in a Nutshell guide
Date: Thu, 22 Nov 2007 14:19:55 +0000
Message-ID: <128F468C-B1A2-4671-8804-F462D1D4B9D8@steelskies.com>
References: <1195477504.8093.15.camel@localhost> <fhsc7b$k4g$1@ger.gmane.org> <1195737303.19260.27.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Juselius <jonas@iki.fi>
X-From: git-owner@vger.kernel.org Thu Nov 22 15:20:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvCv5-0003dO-K6
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 15:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519AbXKVOT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 09:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbXKVOT6
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 09:19:58 -0500
Received: from smtp1.betherenow.co.uk ([87.194.0.68]:52114 "EHLO
	smtp1.bethere.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbXKVOT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 09:19:58 -0500
Received: from [192.168.1.67] (87-194-43-188.bethere.co.uk [87.194.43.188])
	by smtp1.bethere.co.uk (Postfix) with SMTP id 106FC980E9;
	Thu, 22 Nov 2007 14:19:55 +0000 (GMT)
In-Reply-To: <1195737303.19260.27.camel@localhost>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65825>

On 22 Nov 2007, at 13:15, Jonas Juselius wrote:

> I'm planning to write a section in the "Nutshell guide" on rewriting
> history and rebasing. I have a question related to rewriting  
> history. As
> usual, I'll assume that the part of the history I'm mucking with has  
> not
> been pushed or pulled by anyone.
> Suppose I have been working on some topic branch for a while and been
> overly trigger happy, i.e. I have produced a ridiculous number of
> commits along the way. At some point when I'm done I want to publish  
> my
> changes, but doing so would create an insanely obese history full of
> near nonsense commits. What I want to do is to slim down the commit  
> log
> into pieces that actually makes sense. What is the preferred (or best,
> most convenient) way of doing this? The way I have done this  
> previously
> is essentially:
>
> 1.  git branch -m mytopic tmp_mytopic  # rename
> 2.  git branch mytopci tmp_mytpoic~42  # go back in history
> Loop:
> 3.1 git log; git diff; git annotate...
> 3.2 git diff tmp_mytopic~42..tmp_mytopic~33 | git-apply
> 3.3 git commit -m "sane commit message" -a
> 4.  git branch -d tmp_mytopic
>
> If I need to reorder commits I can first use git-rebase -i to get
> everything streamlined. There must be a better way of doing this,  
> right?


I may be missing something here, but you know that you can edit  
commits and squash commits together (using something like "git rebase  
--interactive mytopic~42"), right?
