From: Gordon Freeman <freemanmtc@gmail.com>
Subject: Re: Workflow on git with 2 branch with specifc code
Date: Sat, 18 Jan 2014 14:07:33 -0200
Message-ID: <52DAA6C5.8060305@gmail.com>
References: <1389960868.21737.2.camel@pc14.intranet>	<20140117230507.GD107228@vauxhall.crustytoothpaste.net> <CAH3Anrq9XbkFj+K7FJ28XAwwYkc1UseDrCdjWCEJ+kJjFsKrUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jon Seymour <jon.seymour@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 18 17:07:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4YQn-0005e2-FV
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 17:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbaARQHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 11:07:30 -0500
Received: from mail-qc0-f179.google.com ([209.85.216.179]:36176 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbaARQH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jan 2014 11:07:28 -0500
Received: by mail-qc0-f179.google.com with SMTP id e16so4746193qcx.10
        for <git@vger.kernel.org>; Sat, 18 Jan 2014 08:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=LAuxeJQZHz+uCYfUhLOJ7xjfkVZYMKvOsrZC1Tr6tMc=;
        b=jzOcbBxbdQ41qAhpxeiaAOz8LpKK/Z4WuBCZXD5WdKZYQ1+NksKTaTxxNZE+6+d/ZU
         AGrO7Am0ehyX1Pn0ohXJzYrMY47GBkO5/ziejpm05nnY1fpJ4gA8P+LUN5KtXBX1c0mW
         K22WWXgwIF1T7R/6+P8YOhdelrEJppWUBMouCsZaGnHwe5QcJD77AdKKDQ89ealpx+bp
         78zCD2qzWoY/bQGcOoAbI2wfeEWneNj2ycyGfIZh1IDjZ/ybHeHbK4zE2K6uTTseGmH8
         4Kb9kRhBFv1sRdpwqSwYPqwSNHCSoDzaLqcrbY67Gu6QspRE8idsLZ8asZn3yPOKN1jG
         TJRA==
X-Received: by 10.224.92.139 with SMTP id r11mr13306129qam.71.1390061248184;
        Sat, 18 Jan 2014 08:07:28 -0800 (PST)
Received: from [192.168.254.154] (200-96-88-29.nhoce701.dsl.brasiltelecom.net.br. [200.96.88.29])
        by mx.google.com with ESMTPSA id q4sm18300535qac.18.2014.01.18.08.07.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 18 Jan 2014 08:07:27 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CAH3Anrq9XbkFj+K7FJ28XAwwYkc1UseDrCdjWCEJ+kJjFsKrUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240648>

Hello!
Thx you all guys for the help. That's no need more explanations here for 
rebases Jon.
I alredy do a lot of  this when i need to change configs  of databases 
and domains and other things,
of my local branch to do some tests, so this is ok for me.
Seems that i just need some. some people organization here.
I will get that info that you guys provide to our devel group and aply that.

Thaks you all for the help.

On 18/01/2014 01:30, Jon Seymour wrote:
> On Sat, Jan 18, 2014 at 10:05 AM, brian m. carlson 
> <sandals@crustytoothpaste.net> wrote:
>> On Fri, Jan 17, 2014 at 10:14:28AM -0200, Gordon Freeman wrote:
>>> Hello guys, im Gordon. I have a question about workflow with git 
>>> that i dont know if im doing it right. I have 1 repo with 2 branchs 
>>> the first is the master of the project. the second is a branch copy 
>>> of the master but he need to have some specifc code because is code 
>>> for a client. so, every time that i updade master i need to merge 
>>> master with client branch and it give me conflicts of course that 
>>> will hapen. Well if was just me who work on this 2 branchs it will 
>>> be easy to fix the conflicts and let all work and shine. But whe 
>>> have here, 10 people woking on master branch and some times code are 
>>> lost on merge and we need to look on commits to search whats goin 
>>> on. What i just asking here is if its correct the workflow that i 
>>> do. If for some problem like this, the community have a standard 
>>> resolution. Or if what im doing here is all wrong. 
>> There are many correct workflows. I personally use the workflow 
>> you've mentioned for the exact same reason (customizations for a 
>> client), but I'm the only developer on that repository. 
> I agree with Brian that there are many correct workflows and which one 
> you choose does depend on details of the branches you are trying to 
> manage. Myself, I would tend to avoid a workflow in which you 
> continually merge from master into the client branch. The reason is 
> that once you have done this 20 times or so it will become quite 
> difficult to understand how and why the client branch diverged from 
> the master branch. Yes, it is in the history, but reasoning about 
> diffs that cross merge points is just hard. Assuming that there is not 
> much actual development on the client branch, but rather a relatively 
> small set of customizations to configuration and things of that kind, 
> then I would tend to maintain the client changes as topic branch, then 
> maintain a client integration branch which represents the merge 
> between master and the client topic branch. Changes that represent 
> divergence of the client from the master branch would be committed to 
> the client topic branch and then merged into the client integration 
> branch. Refreshes from master would be merged into the integration 
> branch. Commits directly to the integration branch would be avoided 
> where possible. Once master has diverged from client enough that there 
> start to be frequent conflicts when merging into the integration 
> branch, then consider rebasing the client topic branch onto the tip of 
> master branch and then repeat the cycle again. There is some risk of 
> history loss with this approach - a later release of the client branch 
> may not be a direct descendent of an earlier release of the client 
> branch, but even this problem can be solved with judicious use of 
> merge -s ours after you have successfully rebased the client topic 
> branch. I can expand on how you do this, if there is interest. jon.
