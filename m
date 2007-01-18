From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch,
 not .txt
Date: Thu, 18 Jan 2007 15:10:48 +0100
Message-ID: <45AF7FE8.5060003@op5.se>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>	 <87ps9d7j6t.fsf@morpheus.local>	 <7vejptsglj.fsf@assigned-by-dhcp.cox.net>	 <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>	 <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>	 <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>	 <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>	 <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net>	 <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com>	 <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com> <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Josh Boyer <jwboyer@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 15:11:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Xyk-000783-GQ
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 15:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbXAROK4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 09:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbXAROK4
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 09:10:56 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:42116 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbXAROK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 09:10:56 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 2C6B26BCC8; Thu, 18 Jan 2007 15:10:54 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37092>

Alex Riesen wrote:
> On 1/18/07, Josh Boyer <jwboyer@gmail.com> wrote:
>> > As much as like Unix and everything related, I think it is
>> > not reasonable to try to change the majority. Not unless
>> > we have something earth-shattering. Well, git is, but
>> > 0001-fix....patch in email attachment probably not.
>>
>> I would venture to say that the _majority_ of git users are not using
>> Windows.
> 
> The _real_ majority of the programmers desperately need a better
> VCS than CVS, SVN, Perforce, SourceSafe, ClearCase, etc.
> 

They're free to use git ofcourse, provided they install cygwin or help 
migrate it to run natively on windows. I don't think anyone would cry if 
a competent cross-platform programmer stepped up and started submitting 
patches to get git working on windows without having to resort to the 
cygwin emulation layer.

The thing is, no-one's getting paid for it, so until someone *does* step 
up, it won't happen, as 95% of the *current* git users are still running 
what we on this list will indefinitely refer to as "a sane OS".

>> In this enviroment, Linux is likely the dominant OS,
>> followed by other *nix.  So changing the extention to benefit the
>> majorit of _git's_ users is a good thing.
> 
> Yes. For me and you. One of my coworkers knows nothing about patches,
> but wants (and perfectly able to) review my code. He has usable brains
> and is able to figure out what "+" and "-" is (he has, by now). He hasn't
> even realized that it was an automatically generated information, as
> I sent a patch to him first time, thought it was just a funny way to
> document changes (and was surprised when I told him a patch can be
> applied automatically, even if the original file is not exactly the same).
> But he is a typical windows-trained programmer. Lazy, unmotivated and
> happily married. He does programming by accident (was smart enough
> to learn the basics of the trade). Why would he want to take the an
> extra step of figuring out what that strange "0001-...patch" means?
> Now, I know him, would never think about sending him a real patch.
> I'm kinda grown and tired, and need the bastard, too. Someone younger
> will just call him idiot and "improve" the situation by telling him about
> "stupid windows" and "he should the right ways". Just to be answered
> "it worked for some millions programmers before you" and "I told your
> manager you making problems and are hard to communicate with".
> 
> People often understand "funny ways" the others may have. They
> don't like been told they are wrong or stupid (especially when they
> actually are stupid).


I still don't see the problem. When he understands (and uses) git, the 
name and look of the patch will become blindingly clear to him, and then 
it doesn't matter if it's called .txt or .patch. He might even have some 
tool by then that displays patches color-coded and what-not (there are a 
plethora of such tools for Windows already, most of which register 
.patch and .diff as file-types they handle).

Otoh, *until* he uses git, the change doesn't affect him, so why bother 
catering for his needs?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
