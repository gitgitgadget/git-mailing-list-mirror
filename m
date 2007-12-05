From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: How to jump between two repositories ...
Date: Wed, 5 Dec 2007 01:14:25 -0500
Message-ID: <20071205061425.GE11098@fieldses.org>
References: <C6AF7922-B2F7-42EB-B5DD-25353BC0AF2A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: g2 <gerald.gutierrez@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 07:14:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IznWx-00067x-FZ
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 07:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbXLEGO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 01:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbXLEGO0
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 01:14:26 -0500
Received: from mail.fieldses.org ([66.93.2.214]:58276 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbXLEGO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 01:14:26 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IznWb-0004mA-6g; Wed, 05 Dec 2007 01:14:25 -0500
Content-Disposition: inline
In-Reply-To: <C6AF7922-B2F7-42EB-B5DD-25353BC0AF2A@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67105>

On Tue, Dec 04, 2007 at 09:59:57PM -0800, g2 wrote:
> Hello all,
>
> I am currently working on some code at the office that I also want to work 
> with at home. Seems like a good candidate for git. So I created a 
> repository at work and did a "git clone" at home. I've run into some 
> strange behaviour that I don't understand and would appreciate if someone 
> can clarify for me.
>
> Imagine this scenario. At work:
> git init
> edit test.c
> git add test.c
> git commit
>
> Then at home:
> git clone <work git url>
> edit test.c
> git commit -a
> git push

You'll be much happier at this point if you ssh into work and then git
pull from home....

> At this point, I wanted to push my changes back to my work repository so I 
> can continue work the next day. So at home, I did a git push. I expect that 
> my work repository has the newest material, but I find that when I do "git 
> status" at work the next day, it tells me that my test.c is "modified" and 
> has already staged it for commit. I need to do a "git reset" followed by 
> "git checkout" to update my work folder to the latest stuff.
>
> Totally different from my expectation of the repository knowing that it is 
> out of date and then kindly suggesting that I should do a "git update" of 
> some sort. What piece of understanding am I missing to properly "get" what 
> is going on here, and how am I supposed to properly work with this setup?

Git doesn't support pushing to any branch that's checked out somewhere.

--b.
