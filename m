From: "J.H." <warthog9@kernel.org>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Tue, 17 Nov 2009 15:52:23 -0800
Message-ID: <4B033737.4090908@kernel.org>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com> <7vhbssewm7.fsf@alter.siamese.dyndns.org> <7fce93be0911171224r1cfc438ay7b38b81646154a23@mail.gmail.com> <7vd43gerak.fsf@alter.siamese.dyndns.org> <7fce93be0911171454i61e995a1ob0bf80013bcb0727@mail.gmail.com> <7v6398btz4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sylvain Rabot <sylvain@abstraction.fr>, git <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 01:55:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAYpX-0001UC-09
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 01:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbZKRAzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 19:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbZKRAzT
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 19:55:19 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:49657 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbZKRAzS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 19:55:18 -0500
X-Greylist: delayed 3756 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2009 19:55:18 EST
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id nAHNqQVZ013259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 17 Nov 2009 15:52:34 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <7v6398btz4.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/10030/Mon Nov 16 18:38:41 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Tue, 17 Nov 2009 15:52:43 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133121>

Junio C Hamano wrote:
> Sylvain Rabot <sylvain@abstraction.fr> writes:
> 
>> On Tue, Nov 17, 2009 at 23:10, Junio C Hamano <gitster@pobox.com> wrote:
>>> Sylvain Rabot <sylvain@abstraction.fr> writes:
>>>
>>>>> Wouldn't it be a good idea to somehow make this work well together with
>>>>> the --user-path feature of git-daemon?
>>>>>
>>>>> Perhaps the recommended name given in the example shouldn't be ~/gitweb,
>>>>> but more like ~/public_git, as this is like ~/public_html but for git
>>>>> repositories.  Then the end users will browse
>>>> As I said, it's configuration :)
>>> Wrong answer.
>> Am I passing a test ?
> 
> Sorry, but that wasn't what I meant.
> 
>>> Exactly because it is configurable, the document that outlines the
>>> recommended practice should suggest the best convention.  My point was
>>> that it is likely to be tied to "git"-ness of the specified directory
>>> under $HOME/, not limited to "gitweb"-ness, and it is wrong to recommend a
>>> name tied to "gitweb"-ness in this document.
>> Again, git is a brand new world for me and I don't know any of his
>> conventions yet.
> 
> I do not see this as git-specific conventions.
> 
> But suggesting ~/gitweb is perfectly excusable, especially if you did not
> know that git-daemon can respond to "git://host/~user/".
> 
> John warthog19 (hmm, I thought he used to be warthog9)

Yes I'm warthog9 (there's legacy reasons for warthog19 in the e-mail but 
- yeah)

> explained the above
> much better than I did.  People tend to cut and paste without thinking, so
> we should describe a good default layout in our documentation.
> 
>> I am not trying to impose my own conventions, I am just proposing an idea.
> 
> Yeah, I know.  We are all in this to improve things for people who follow
> us.

The biggest problem with the convention is not so much to impose our 
ideas on people, but that people have a tendency to, like I said, 
cut/paste the first thing they come across and never change it.

This isn't a bash on implementers by any stretch of the imagination, 
it's just that most people are not going to be well versed in 
git/gitweb, aren't going to understand some of the subtleties  and 
aren't going to want to actually read the complexities in documentation. 
  So by recommending good, generic, defaults means that people will, by 
default, get a better result.

- John 'Warthog9' Hawley
