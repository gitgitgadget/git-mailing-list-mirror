From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 12:48:15 -0800
Message-ID: <7v4q6kxm9c.fsf@assigned-by-dhcp.cox.net>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
	<20051110185423.GA7212@blackbean.org> <4373AE02.9050909@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 21:49:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaJLJ-00075j-K3
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 21:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVKJUsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 15:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVKJUsS
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 15:48:18 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:40627 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932100AbVKJUsR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 15:48:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051110204754.GKFA1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Nov 2005 15:47:54 -0500
To: Andreas Ericsson <ae@op5.se>, Jim Radford <radford@blackbean.org>
In-Reply-To: <4373AE02.9050909@op5.se> (Andreas Ericsson's message of "Thu, 10
	Nov 2005 21:30:58 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11525>

Andreas Ericsson <ae@op5.se> writes:

> Jim Radford wrote:
>> On Thu, Nov 10, 2005 at 12:14:29AM -0800, Junio C Hamano wrote:
>>
>>>   I think archimport part needs to be split out just like its
>>>   svn/cvs cousins,
>> I don't agree...
>
> How is this different for when svnimport and cvsimport was moved out?..
>
>> The main reason I see for splitting cvs and email import out is the
>> non-standard dependencies, cvsps and perl(Email::Valid).
>
> Define "non-standard". String::ShellQuote isn't installed by default on 
> Fedora Core 3 but is required by git-archimport.

I am with Andreas here.

If you are using git to manage development in a tightly knitted
group (e.g. company internal project) and are unlikely to be
exchanging email patches, not having to pull Email::Valid into
your system is a good thing, because you would not be using
git-mail.  If you are not dealing with development history
stored in svn or tla, not having to install git-svn nor git-tla
is a good thing.

Technical reasons like package availablity and required package
size count, but I do not think we should be doing the split
purely for technical reasons.  The split should aim primarily
to give convenience for the users.

That reminds me, Andreas, you said something about feeding me
spec updates last week but Jim beated you.  I am open to
improvements from both of you.  Obviously the invitation is not
limited to two of you ;-).
