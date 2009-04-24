From: David Abrahams <dave@boostpro.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 00:06:12 -0400
Message-ID: <C30426B2-CF6F-48D0-A7D3-F96D4D153057@boostpro.com>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090424022900.GB6321@fieldses.org>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Apr 24 06:08:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxChj-0000kJ-OD
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 06:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbZDXEG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 00:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbZDXEGZ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 00:06:25 -0400
Received: from boost-consulting.com ([206.71.190.141]:58289 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbZDXEGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 00:06:25 -0400
Received: from [192.168.188.150] (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id DFA891CC22;
	Thu, 23 Apr 2009 21:03:49 -0700 (PDT)
In-Reply-To: <20090424022900.GB6321@fieldses.org>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117405>


On Apr 23, 2009, at 10:29 PM, J. Bruce Fields wrote:

> On Thu, Apr 23, 2009 at 01:37:05PM -0500, Michael Witten wrote:
>> On Thu, Apr 23, 2009 at 12:57, J. Bruce Fields  
>> <bfields@fieldses.org> wrote:
>>> On Wed, Apr 22, 2009 at 03:38:52PM -0400, David Abrahams wrote:
>>>>
>>>> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#how-to-check-out
>>>> covers "git reset" way too early, IMO, before one has the  
>>>> conceptual
>>>> foundation necessary to understand what it means to "modify the  
>>>> current
>>>> branch to point at v2.6.17".  If this operation must be covered  
>>>> this
>>>> early in the manual, it should probably not be until
>>>> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#manipulating-branches
>>>
>>> I agree; we should suggest just a git-checkout (to a detached HEAD)
>>> instead, though that needs a little explanation so people aren't  
>>> scared
>>> by the warning message it gives.
>>
>> Everyone talks about "before one has the conceptual foundation
>> necessary to understand". Well, here's an idea: The git documentation
>> should start with the concepts!
>>
>> Why don't the docs start out defining blobs and trees and the object
>> database and references into that database? The reason everything is
>> so confusing is that the understanding is brushed under the tutorial
>> rug. People need to learn how to think before they can effectively
>> learn to start doing.
>
> OK, but let's not over-generalize: the person that just wants to  
> figure
> out whether the driver for their network card was fixed in today's
> network devel tree shouldn't have to sit through a discussion of the
> object database.

Those people don't need a VCS.  They should download a snapshot or use  
a web interface.  Seriously.  There's no way you can make even the  
best-designed VCS simple enough to justify the time it takes to learn  
enough just to use it for that.

> And even among readers that are in it for the long
> haul, I think many people will react better to something that gives  
> them
> at least a little concrete how-to information up front.

People (well, people like me) should get a brief "hello, world" demo  
up front, to give them a feel for the flavor of the system, but  
[important:] it shouldn't attempt to be instructive.  Fundamental  
concepts are next.  How-to information can come after that, or after  
the reference information.

> So the goal was always to find a tutorial route through the material
> that would allow us to introduce the concepts as we go along.

Maybe that will work for some people, but it *really* won't work for  
me.  You can't start throwing around terms of art without defining  
them unless you want to raise more questions than you're answering.  I  
would be surprised if it wasn't the same for many tech people.


--
David Abrahams
BoostPro Computing
http://boostpro.com
