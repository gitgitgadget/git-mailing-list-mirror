From: David Kastrup <dak@gnu.org>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 23:02:01 +0200
Message-ID: <85wsjkgr7a.fsf@lola.goethe.zz>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	<32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
	<alpine.DEB.1.00.0807161902400.8986@racer>
	<32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com>
	<alpine.LNX.1.00.0807161605550.19665@iabervon.org>
	<861w1sn4id.fsf@lola.quinscape.zz>
	<m3od4wse30.fsf@localhost.localdomain>
	<86k5fk1ooq.fsf@lola.quinscape.zz>
	<6B9BBA72-6E75-47E3-911A-4A5309090807@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 23:57:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJbTI-00077c-1D
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 23:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190AbYGQV4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 17:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757273AbYGQV4E
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 17:56:04 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:40132 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190AbYGQVz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 17:55:59 -0400
Received: from localhost ([127.0.0.1]:38345 helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.67)
	(envelope-from <dak@gnu.org>)
	id 1KJbRZ-00071e-KV; Thu, 17 Jul 2008 17:55:21 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id C76C91C142BA; Thu, 17 Jul 2008 23:02:01 +0200 (CEST)
In-Reply-To: <6B9BBA72-6E75-47E3-911A-4A5309090807@sb.org> (Kevin Ballard's
	message of "Thu, 17 Jul 2008 13:15:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88927>

Kevin Ballard <kevin@sb.org> writes:

> On Jul 17, 2008, at 9:05 AM, David Kastrup wrote:
>
>> How much have you worked with Subversion so far?  I am doing quite a
>> bit of work with it, and the do-everything-via-copying paradigm does
>> not get in my hair.  It actually means that I have to remember fewer
>> commands.  And it is pretty easy to understand.
>
> Sure, it's simpler, but the overhead in creating and using a branch is
> much larger. I have to extract the URL from the repository (since
> naturally I only have trunk checked out),

Say something like svn info and then use cut&paste.

> issue a command to copy by URL, then issue an `svn switch` command,
> and then I have to remember that I have a switched repository.

Huh?  How is that different to remembering a switched branch?  Anyway,
one tends to check out different branches in different workdirs.

> Switching between branches is a pain, especially if you have
> uncommitted work. There's a reason I never bothered to use branches
> when I used subversion.

Looks like it.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
