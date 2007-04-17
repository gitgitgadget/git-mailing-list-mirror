From: Rene Herman <rene.herman@gmail.com>
Subject: Re: git branch --switch?
Date: Tue, 17 Apr 2007 18:10:55 +0200
Message-ID: <4624F18F.6070906@gmail.com>
References: <4624CD58.90103@gmail.com>	 <C940520E-732A-4F6E-A7F2-0215FD534455@silverinsanity.com>	 <4624EAAA.6040000@gmail.com> <8c5c35580704170855ke426d86vac6e9b3b67fea5ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 18:13:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdqIi-0004R9-55
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 18:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031122AbXDQQNA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 12:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031125AbXDQQNA
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 12:13:00 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:38880 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031122AbXDQQNA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 12:13:00 -0400
Received: from [213.51.130.188] (port=52732 helo=smtp3.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1HdqIc-0008LB-Dy; Tue, 17 Apr 2007 18:12:58 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:60558 helo=[192.168.0.3])
	by smtp3.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1HdqIW-0006Wn-Eb; Tue, 17 Apr 2007 18:12:52 +0200
User-Agent: Thunderbird 1.5.0.10 (X11/20070221)
In-Reply-To: <8c5c35580704170855ke426d86vac6e9b3b67fea5ea@mail.gmail.com>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44791>

On 04/17/2007 05:55 PM, Lars Hjemli wrote:

> On 4/17/07, Rene Herman <rene.herman@gmail.com> wrote:

>> git clone -l -s -n <a local linux repo> local
>> git checkout -b v20 v2.6.20
>> git branch a
>> git branch b
>> git branch c
>>
>> Step 1, 3, 4 and 5 of this are nearly instantaneous but 2 isn't
> 
> I might have misunderstood your goal, but have you tried
> 
> git clone -l -s -n <a local linux repo> local
> git branch a v2.6.20
> git branch b a
> git branch c a
> 
> Now a, b and c all point at v2.6.20, while HEAD points as master.

Well, yes, they do, and I could also do

git branch b v2.6.20
git branch c v2.6.20

directly then (right?) but I do want that "v20" branch in the middle. The 
cloned repo is a linus repo, and that v20 is where I'll be pulling 2.6.20.y 
updates into; a merge branch will then merge v20, a, b and c into what I 
will be compiling.

As said, given that I need to checkout things anyway to do something with 
them it'a all not essential but as a newbie, I just thought that a "branch 
--and-set-as-current new_branch" made sense. My sense of sense may be crap; 
I've largely avoided dealing with souce code management, regarding CVS and 
SVN as unfortunate facts of life to work around and forget, mostly.

Rene.
