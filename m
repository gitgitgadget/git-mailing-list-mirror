From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: Feedback outside of the user survey
Date: Mon, 20 Oct 2008 18:57:31 +0200
Message-ID: <48FCB87B.1080207@jaeger.mine.nu>
References: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com> <20081016115628.GA24836@garry-x300.arpnetworks.com> <2d460de70810160618u1803375aj913145a5060e5308@mail.gmail.com> <48F7A4F8.2080600@jaeger.mine.nu> <20081018134906.GA13894@garry-thinkpad.arpnetworks.com> <48F9EC2B.2010200@jaeger.mine.nu> <48FC55F9.3060509@op5.se> <48FC9927.5030903@jaeger.mine.nu> <48FC9D87.3010303@op5.se> <48FCA1BC.3060300@jaeger.mine.nu> <48FCADA0.4020008@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Garry Dolley <gdolley@arpnetworks.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:16:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kry5i-0005GZ-IT
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 18:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbYJTQ5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 12:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbYJTQ5f
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 12:57:35 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:43758 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751715AbYJTQ5e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 12:57:34 -0400
Received: (qmail 2050 invoked from network); 20 Oct 2008 16:57:32 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 20 Oct 2008 16:57:32 -0000
Received: (qmail 23907 invoked from network); 20 Oct 2008 16:57:32 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 20 Oct 2008 16:57:32 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <48FCADA0.4020008@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98723>

Andreas Ericsson wrote:
> Christian Jaeger wrote:
>> Hm, not sure whether you mean to rescue the situation with rewritten 
>> commits here -- but hell no, I certainly don't mean to have different 
>> commit objects for different clones/checkouts.
>>
>
> Then you'll be transferring all objects over the wire anyway

Why? Again, care to differentiate between technical feasibility and 
current implementation.

I did make a list of cases in my pre-previous email which tried to go 
through the implications.

>>> What you'd end up with wouldn't be a git repository at all anymore. It
>>> would be a "stump", as it'd be missing large parts of the tree 
>>> entirely.
>>
>> That was my point, yes.
>>
>
> That's partially implemented, I think (google for Nguy (or something, I'm
> not very god with asian names),

That's not enough information for me to find what you've had in mind. 
"stump Nguy site:marc.info" doesn't yield a result with Google.

> but your original suggestion said to save
> on transferring objects from one machine to another, 

Yes

> which will play poorly
> with git's object database

Why, if we seem to already have agreed that the object database would be 
a "stump"? It may play poorly with the current implementation of the 
database maintainance code, but I don't see why it would play poorly 
with the database's data structure design.

> and which you're now arguing against.

I don't get this part of the sentence.

I did (3 mails ago) say, "(one) could additionally look into 
implementing a kind of shallow cloning". When you said that the kind of 
repository I'm "arguing" for would be a "stump", that sounded exactly 
what I've meant, in the same sense that a shallow clone creates a 
repository that is missing part of the tree (or maybe DAG is a better 
term). So I said "That was my point, yes", maybe I should have said 
"That's what I've meant when I was saying a 'kind of shallow cloning'." 
Ok? I might miss some fine points in the english language as I'm not a 
native speaker.

>
> Please make up your mind.

About what?

Do you mean whether I want to implement the idea? Then no, I don't see 
myself contributing any code for this. I certainly don't have a use case 
personally where it would pay off. My motivation to contributing to this 
thread was to point out that there is, afaik, nothing inherent in the 
Git design (at least the database) which would absolutely prevent one 
from implementing subdirectory checkouts (including even saving on 
bandwith by doing some kind of shallow / stump / lazy cloning).

Christian.
