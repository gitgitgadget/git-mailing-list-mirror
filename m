From: Andreas Ericsson <ae@op5.se>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Sat, 30 Aug 2008 10:13:46 +0200
Message-ID: <48B9013A.70201@op5.se>
References: <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu>	 <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu>	 <20080828212346.GA27867@coredump.intra.peff.net>	 <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu>	 <20080828215907.GE27867@coredump.intra.peff.net>	 <3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu>	 <881C17DA-2FE2-49A7-A4A9-FACA7720599C@cs.indiana.edu>	 <20080829152451.GA20629@yugib.highrise.ca>	 <94a0d4530808290911j32bf5ee0q869dfe39483297f8@mail.gmail.com>	 <20080829162420.GB20629@yugib.highrise.ca> <94a0d4530808290928w3b1decd4o2e77349d793ffff0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Aidan Van Dyk <aidan@highrise.ca>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 10:14:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZLbi-0008Rn-2U
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 10:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbYH3INt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 04:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbYH3INs
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 04:13:48 -0400
Received: from mail.op5.se ([193.201.96.20]:53700 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbYH3INr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 04:13:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C76A11B8008F;
	Sat, 30 Aug 2008 10:18:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AtdRNDg1+MfI; Sat, 30 Aug 2008 10:18:46 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 607BE1B80369;
	Sat, 30 Aug 2008 10:18:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <94a0d4530808290928w3b1decd4o2e77349d793ffff0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94359>

Felipe Contreras wrote:
> On Fri, Aug 29, 2008 at 7:24 PM, Aidan Van Dyk <aidan@highrise.ca> wrote:
>> * Felipe Contreras <felipe.contreras@gmail.com> [080829 12:11]:
>>> On Fri, Aug 29, 2008 at 6:24 PM, Aidan Van Dyk <aidan@highrise.ca> wrote:
>>>> * Perry Wagle <wagle@cs.indiana.edu> [080801 00:00]:
>>>>> Jeff King has convinced me that it's perfectly legitimate to introduce
>>>>> non-upward compatibilities in minor version releases of "young"
>>>>> software.
>>>> This is the gist of the problem.  You keep hammering about a
>>>> "non-upwards compatibilities in minor version releases", yet you have
>>>> *not* pointed out one such in-compatibility in a minor version release..
>>>>
>>>> Remember, in git, 1.6 is a "major version" release, with release notes, etc.
>>>> 1.5.X is a "minor version" release.
>>>> 1.5.X.Y is a "patch" release.
>>> What is X (2.0)?
>> X would be a digit, like 0, 1, 2, 3, 4, 5, 6, 7, 8, or 9, as in the git
>> 1.5 releases:
>>        1.5.0
>>        1.5.1
>>        1.5.2
>>        1.5.3
>>        1.5.4
>>        1.5.4
>>        1.5.6
>>
>> And now also:
>>        1.6.0, being the first of the 1.6 releases...
> 
> I meant 'X.0.0', if 1.X is major, what is X.0? Huge?
> 

X.0 is "technically backwards incompatible".

If, for example, SHA1 turns out to be horribly broken, git might have
to be updated to use something else instead. Such a switch would
require a version bump from 1.x to 2.x.

That might come some day anyway, assuming we decide to make a flag-day
and just remove older-version compatibility code from git or some
such.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
