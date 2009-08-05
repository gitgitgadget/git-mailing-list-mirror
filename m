From: "lists@mgreg.com" <lists@mgreg.com>
Subject: Re: Merging to and from non-current branches.
Date: Tue, 4 Aug 2009 22:48:41 -0400
Message-ID: <518952FC-626C-43FB-BD53-98DE849C9751@mgreg.com>
References: <D5200130-C7D7-4010-BF62-3A3374F2E3B0@mgreg.com> <alpine.LNX.2.00.0908042236240.2147@iabervon.org>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 04:48:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYWYd-0006M8-VE
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 04:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933414AbZHECso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 22:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933389AbZHECso
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 22:48:44 -0400
Received: from smtpauth05.prod.mesa1.secureserver.net ([64.202.165.99]:47028
	"HELO smtpauth05.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933209AbZHECsn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 22:48:43 -0400
Received: (qmail 2022 invoked from network); 5 Aug 2009 02:48:42 -0000
Received: from unknown (76.177.133.127)
  by smtpauth05.prod.mesa1.secureserver.net (64.202.165.99) with ESMTP; 05 Aug 2009 02:48:42 -0000
In-Reply-To: <alpine.LNX.2.00.0908042236240.2147@iabervon.org>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124839>


On Aug 4, 2009, at 10:45 PM, Daniel Barkalow wrote:

> On Tue, 4 Aug 2009, lists@mgreg.com wrote:
>
>> Hi All,
>>
>> I've been reading up on some of the GIT commands and I'm not sure  
>> if what I
>> want/need exists.  Basically I want to merge all changes from one  
>> branch to
>> another, regardless of whether I'm in either of those branches.  At  
>> the very
>> least I would like to merge an existing "development" branch with  
>> the "master"
>> branch without needing to first check out master.  I've seen  
>> rebase, but I'm
>> not absolutely sure what that's doing.  Thoughts?
>
> It can't work, because you need to be able to use the working tree to
> resolve any conflicts that arise during the merge. Merging without
> checking out a branch is a bit like building without checking out a
> branch; it would be avoiding using the filesystem for what it's  
> there for.
>
> 	-Daniel
> *This .sig left intentionally blank*
>


Hi Daniel,

I appreciate your post.  I understand what you're saying, and I'm not  
so much concerned about the logistics of what need to occur so much as  
a single command to intuitively handle it.  I've been doing a great  
deal of incremental development lately and it becomes rather tedious  
to have to checkout master, merge dev, re-checkout dev and proceed.   
I'm not sure why this isn't currently possible with a single command.   
I suppose I could write a shell script to do so, but that's a little  
less "native" than I'd like.

Best,

Michael
