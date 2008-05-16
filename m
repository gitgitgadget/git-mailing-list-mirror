From: Paul Gardiner <paul@laser-point.co.uk>
Subject: Re: What am I doing wrong?
Date: Fri, 16 May 2008 22:16:42 +0100
Message-ID: <482DF9BA.1080508@laser-point.co.uk>
References: <482D6F41.2060809@laser-point.co.uk> <g0js1p$l22$1@ger.gmane.org> <482D7EE1.9020503@laser-point.co.uk> <g0jvig$1dn$1@ger.gmane.org> <482D8BEB.6070706@laser-point.co.uk> <alpine.DEB.1.00.0805161439100.30431@racer> <g0k6k7$t4k$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, lists@glidos.net
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri May 16 23:17:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx7J4-0005m8-52
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 23:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260AbYEPVQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 17:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754965AbYEPVQr
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 17:16:47 -0400
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:30895
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754143AbYEPVQq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2008 17:16:46 -0400
X-Trace: 117194259/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$ACCEPTED/pipex-customers/81.86.57.226
X-SBRS: None
X-RemoteIP: 81.86.57.226
X-IP-MAIL-FROM: paul@laser-point.co.uk
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApQAAKuWLUhRVjni/2dsb2JhbAAIrgY
X-IronPort-AV: E=Sophos;i="4.27,499,1204502400"; 
   d="scan'208";a="117194259"
X-IP-Direction: IN
Received: from 81-86-57-226.dsl.pipex.com (HELO [10.0.0.24]) ([81.86.57.226])
  by smtp.pipex.tiscali.co.uk with ESMTP; 16 May 2008 22:16:45 +0100
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <g0k6k7$t4k$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82316>

Michael J Gruber wrote:
> Johannes Schindelin venit, vidit, dixit 16.05.2008 15:40:
>> Hi,
>>
>> On Fri, 16 May 2008, Paul Gardiner wrote:
>>
>>> Michael J Gruber wrote:
>>>> Paul Gardiner venit, vidit, dixit 16.05.2008 14:32:
>>>>> Michael J Gruber wrote:
>>>>>> Paul Gardiner venit, vidit, dixit 16.05.2008 13:25:
>>>>>>> I create the initial repository with
>>>>>>>
>>>>>>>      git-clone /<full-path>/<name>.git/ <folder>
>>>>>>>
>>>>>>> That works fine, but then I can't fetch. git-fetch gives the error
>>>>>>> "fatal: 'origin': unable to chdir or not a git archive"
>>>>>>> "fatal: The remote end hung up unexpectedly"
>>>>>>>
>>>>>>> P.
>>>>>> Are you trying to clone a bare repository?
>>>>>> Or is your repo maybe at /<full-path>/<name> with a .git subdir?
>>>>> Yes, a bare repository.
>>>> Then, maybe the full list of command lines (including cd and git-fetch)
>>>> would be helpful in order to track this down.
>>> Ok, sorry, thought it was probable something really obvious. Here's the
>>> sequence (using git version 1.5.4).
>>>
>>> $ git-clone /big/git/paul.git/ epage
>>> Initialized empty Git repository in /home/paul/epage/.git/
>>> 719749 bolcks
>>
>> Something tells me that this is not a copy/paste ;-)
> 
> Let's just hope that's not units of boelkstoff ;)
> 
>>> $ cd epage
>>> $ git-fetch
>>> fatal: 'origin': unable to chdir or not a git archive
>>> fatal: The remote end hung up unexpectedly
>>
>> Is there a "[remote "origin"]" section in .git/config?  What Git 
>> version is this, anyway?
> 
> 1.5.4
> 
> Could git trip over that trailing slash? git 1.5.5.1 certainly doesn't.

The documentation suggests having the trailing slash, and I think I
tried without, but I'll try again just in case.

> BTW: The above shows something that confused me initially about cloning: 
> git reports the creation of an empty repo, nothing else. But it does 
> much more, of course, just without reporting.

Oh yeah, I realise the fetch is already done by the clone, and that
git-fetch wouldn't bring anything new in right after the clone, but
there are other pushers for that repo.

P.
