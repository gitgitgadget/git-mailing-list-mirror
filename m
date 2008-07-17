From: Kevin Ballard <kevin@sb.org>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 13:15:01 -0700
Message-ID: <6B9BBA72-6E75-47E3-911A-4A5309090807@sb.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com> <alpine.DEB.1.00.0807161902400.8986@racer> <32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com> <alpine.LNX.1.00.0807161605550.19665@iabervon.org> <861w1sn4id.fsf@lola.quinscape.zz> <m3od4wse30.fsf@localhost.localdomain> <86k5fk1ooq.fsf@lola.quinscape.zz>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 22:16:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJZtY-0006pU-FW
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 22:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759114AbYGQUPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 16:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758210AbYGQUPG
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 16:15:06 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:42661 "EHLO
	randymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756220AbYGQUPF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2008 16:15:05 -0400
Received: from [10.100.18.129] (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a12.g.dreamhost.com (Postfix) with ESMTP id 1C81FA8DB3;
	Thu, 17 Jul 2008 13:15:02 -0700 (PDT)
In-Reply-To: <86k5fk1ooq.fsf@lola.quinscape.zz>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88908>

On Jul 17, 2008, at 9:05 AM, David Kastrup wrote:

>> Distinguishing between branch part of directory name by _convention_
>> is design mistake; the fact that the tool doesn't help to ensure that
>> (a) tags lie on branch (b) tags _doesn't change_ is an example of  
>> this
>> stupidity.
>
> How much have you worked with Subversion so far?  I am doing quite a  
> bit
> of work with it, and the do-everything-via-copying paradigm does not  
> get
> in my hair.  It actually means that I have to remember fewer commands.
> And it is pretty easy to understand.

Sure, it's simpler, but the overhead in creating and using a branch is  
much larger. I have to extract the URL from the repository (since  
naturally I only have trunk checked out), issue a command to copy by  
URL, then issue an `svn switch` command, and then I have to remember  
that I have a switched repository. Switching between branches is a  
pain, especially if you have uncommitted work. There's a reason I  
never bothered to use branches when I used subversion.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
