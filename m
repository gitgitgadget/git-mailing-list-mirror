From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: What is a reasonable mixed workflow for git/git-cvsserver?
Date: Mon, 23 Jul 2007 11:06:01 -0400
Message-ID: <7D018B3B-CE12-46C4-87EA-9BE14EC415E4@silverinsanity.com>
References: <E8B0B250-A428-4CDC-A4D2-FFCF45953076@zib.de> <46a038f90707230359u5fac77a4i7b6a350d3bb29e3b@mail.gmail.com> <AD8AD244-0B20-44E9-AEE6-9D2A75BC5091@zib.de> <46a038f90707230719i106e0576j2868548ef0cb1739@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Steffen Prohaska" <prohaska@zib.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 17:06:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICzUB-0006u8-2z
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 17:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbXGWPGH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 11:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755082AbXGWPGF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 11:06:05 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:45249 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901AbXGWPGE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 11:06:04 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 0007C1FFC01F;
	Mon, 23 Jul 2007 15:06:01 +0000 (UTC)
In-Reply-To: <46a038f90707230719i106e0576j2868548ef0cb1739@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53439>


On Jul 23, 2007, at 10:19 AM, Martin Langhoff wrote:
> On 7/23/07, Steffen Prohaska <prohaska@zib.de> wrote:
>> My question is how to deal with this shared branch on the git
>> side. Should a core developer rebuild a sane history from such
>> a shared/mixed/unsorted branch by cherry picking the commits
>> to one or more topic branches?
>
> I think that's usually frowned upon. As the committer did his/her work
> on a particular state of the tree, and tested it. So every commit at
> least *should* be of a working state. Once you rewrite history as a
> "normal" practice, that flies out of the window. And it's a big loss.

That's only somewhat true.  First, there's never a guarantee that the  
committer tested it, especially if they had to pull before committing  
(less likely they tested the resulting merge than tested their  
original code).  Second, rewriting history isn't a big loss.  It's  
done all the time here on this list.  The patches I've sent in rarely  
appear applied on top of the commit I made them from.  The mob branch  
could just be viewed as a set of patches to use, and it becomes the  
maintainer's job to test the results after cherry-picking from them.

~~ Brian
