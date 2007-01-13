From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 11:45:29 -0500
Message-ID: <6C7B9A8F-122D-446A-AF25-409C9DCAA592@silverinsanity.com>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <7virfct737.fsf@assigned-by-dhcp.cox.net> <slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx> <7vejq0t4ij.fsf@assigned-by-dhcp.cox.net> <20070112210403.GB6262@xp.machine.xx> <7v7ivrpx9y.fsf@assigned-by-dhcp.cox.net> <87y7o6x60w.wl%cworth@cworth.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 17:45:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5m0e-0004TX-3b
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 17:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422712AbXAMQpd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 11:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbXAMQpd
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 11:45:33 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:42975 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422712AbXAMQpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 11:45:33 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 36DD61FFC02B;
	Sat, 13 Jan 2007 16:45:32 +0000 (UTC)
In-Reply-To: <87y7o6x60w.wl%cworth@cworth.org>
To: Carl Worth <cworth@cworth.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36759>


On Jan 13, 2007, at 11:09 AM, Carl Worth wrote:

> Also, this would even make it possible to provide an accurate
> index-based description of "commit paths...". Namely, something like:
>
> 	commit paths...
>
> 	This command starts with a new index initialized from the
> 	contents of the current commit (HEAD). It then performs the
> 	following commands:
>
> 		git refresh paths...
> 		git commit
>
> 	[Some extra language needed here about restoring into the
> 	index other changes that were "skipped over".]
>
> So, someone might like to have that kind of description somewhere in
> the technical documentation of git. (I'd still prefer to see "commit
> paths..." documented as simply "commits the working-tree content of
> all specified paths").

I fail to see why this description can't be used with s/refresh/ 
add/.  I also don't think it's a very clear description because of  
the "starting with a new index" and the hand-waving involved in  
"restoring into the index other changes".

I can somewhat understand the desire to split git-add (although I  
don't share it).  But I don't see the need for it to be a new git- 
refresh, since that functionality already exists as git-update- 
index.  Is using git-add to add to the index a conceptual problem or  
is it causing actual problems in people's usage of git?  If it's an  
issue of teaching new users, I _think_ that could be resolved very  
simply as "git add adds content to the index" when we explain the  
index as the staging area for a new commit and wean people off of  
"git commit -a".  A short discussion of "tracking content vs. files"  
is probably also a good idea.  (I honestly haven't read the tutorials  
in a long long time, so this may already be in there.)

~~ Brian
