From: david@lang.hm
Subject: Re: [RFC - draft] List of proposed future changes that are backward
 incompatible
Date: Sun, 15 Feb 2009 16:38:36 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0902151636510.14911@asgard.lang.hm>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <alpine.DEB.1.00.0902152358330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.10.0902151613110.14911@asgard.lang.hm>
 <alpine.DEB.1.00.0902160016230.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 00:35:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYqVx-0007Un-Rw
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 00:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbZBOXdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 18:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbZBOXdm
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 18:33:42 -0500
Received: from mail.lang.hm ([64.81.33.126]:33938 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbZBOXdl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 18:33:41 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n1FNXbpf019549;
	Sun, 15 Feb 2009 15:33:37 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.1.00.0902160016230.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110088>

On Mon, 16 Feb 2009, Johannes Schindelin wrote:

> On Sun, 15 Feb 2009, david@lang.hm wrote:
>
>> On Mon, 16 Feb 2009, Johannes Schindelin wrote:
>>
>>> On Sun, 15 Feb 2009, david@lang.hm wrote:
>>>
>>>> On Sun, 15 Feb 2009, Junio C Hamano wrote:
>>>>
>>>>> Thanks.
>>>>>
>>>>> * git-push to update the checked out branch will be refused by default
>>>>>
>>>>>  Make "git push" into a repository to update the branch that is checked
>>>>>  out fail by default.
>>>>>
>>>>>  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
>>>>
>>>> If I understand this one, it will cause grief for quite a few people.
>>>>
>>>> I have a public repository that I push to and then have a trigger that
>>>> checks
>>>> out the current version, compiles it, publishes the compiled version,
>>>> sends an
>>>> announcement, etc
>>>
>>> So you have to set a config variable.  Big deal.

the dashed names were the same way, but they definantly were a big deal.

>>> Compared to that, the thousands of new Git users will no longer be bitten
>>> by the "do not push to a non-bare repository" issue without a useful error
>>> message.
>>>
>>> Please, please, publicize that if there is somebody who is doing the same
>>> as you (which I deem a dangerous workflow; I certainly do not use it
>>> myself) that they will have to adjust their receive.denyCurrentBranch
>>> variable.
>>
>> since this repository isn't use for anything other than publishing for public
>> access, what's so dangerous about it?
>
> Hey, you do what you want...
>
> I just keep in mind that it _is_ a working directory that can go dirty,
> for whatever reasons.
>
> Which is why _I_ do things like your workflow locally, even if that means
> that I log onto another machine (which is then "local").
>
> But again, it is your choice.  And certainly, it will be possible in the
> future, too, just more deprecated than it is already.

please be careful with the term 'deprecated', just becouse you would do 
something a different way doesn't make it 'deprecated', that term should 
only be used for features that are on their way out of the product, but 
haven't been removed yet.

David Lang
