From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: submodule terminology
Date: Sun, 20 May 2007 15:59:22 -0700
Message-ID: <7v3b1rje45.fsf@assigned-by-dhcp.cox.net>
References: <20070520214417.GM5412@admingilde.org>
	<200705210006.47266.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 21 00:59:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpuN8-0002r4-E7
	for gcvg-git@gmane.org; Mon, 21 May 2007 00:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757947AbXETW70 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 18:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757868AbXETW70
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 18:59:26 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62219 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757947AbXETW7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 18:59:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520225923.EDQC13995.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 20 May 2007 18:59:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1azN1X00E1kojtg0000000; Sun, 20 May 2007 18:59:23 -0400
In-Reply-To: <200705210006.47266.johan@herland.net> (Johan Herland's message
	of "Mon, 21 May 2007 00:06:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47945>

Johan Herland <johan@herland.net> writes:

> On Sunday 20 May 2007, Martin Waitz wrote:
>> hoi :)
>> 
>> I think we should agree to one name for what currently is named
>> submodule / subproject / dirlink / gitlink.
>> 
>> Or use one name for the low-level plumbing (have a tree entry
>> which points to another commit): dirlink or gitlink and another
>> one for the high-level UI think: submodule or subproject.
>> But then we should use those names consequently.
>> 
>> Oppinions?
>
> For the high-level concept, "subproject" seems to me the best 
> alternative. I think it is much better than "submodule" at 
> describing that the subproject is a stand-alone project/repo in
> itself.

I was wondering if we can get away by just calling them
"projects", "projects containd in the superproject", etc., as I
tend to agree with Linus, who used the term "superproject
support" in his talk, that this is not really about creating
"subproject" which are somehow different from ordinary projects,
but more about supporting superprojects that can contain/point
at other projects, which we did not have before 1.5.2 happened.

> As for the low-level concept, I personally prefer "gitlink", but 
> I don't have any strong feelings.

+1
