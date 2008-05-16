From: Paul Gardiner <paul@laser-point.co.uk>
Subject: Re: What am I doing wrong?
Date: Fri, 16 May 2008 15:56:46 +0100
Message-ID: <482DA0AE.1030301@laser-point.co.uk>
References: <482D6F41.2060809@laser-point.co.uk> <g0js1p$l22$1@ger.gmane.org> <482D7EE1.9020503@laser-point.co.uk> <g0jvig$1dn$1@ger.gmane.org> <482D8BEB.6070706@laser-point.co.uk> <alpine.DEB.1.00.0805161439100.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org, lists@glidos.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 16 17:00:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx1Pq-00039z-8E
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 17:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763426AbYEPO5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 10:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763419AbYEPO47
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 10:56:59 -0400
Received: from mk-outboundfilter-2.mail.uk.tiscali.com ([212.74.114.38]:38746
	"EHLO mk-outboundfilter-2.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763406AbYEPO46 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2008 10:56:58 -0400
X-Trace: 81678873/mk-outboundfilter-2.mail.uk.tiscali.com/PIPEX/$ACCEPTED/pipex-customers/81.86.57.226
X-SBRS: None
X-RemoteIP: 81.86.57.226
X-IP-MAIL-FROM: paul@laser-point.co.uk
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlABAF49LUhRVjni/2dsb2JhbAAIrgM
X-IronPort-AV: E=Sophos;i="4.27,497,1204502400"; 
   d="scan'208";a="81678873"
X-IP-Direction: IN
Received: from 81-86-57-226.dsl.pipex.com (HELO [10.0.0.24]) ([81.86.57.226])
  by smtp.pipex.tiscali.co.uk with ESMTP; 16 May 2008 15:56:48 +0100
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <alpine.DEB.1.00.0805161439100.30431@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82302>

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 16 May 2008, Paul Gardiner wrote:
> 
>> Michael J Gruber wrote:
>>> Paul Gardiner venit, vidit, dixit 16.05.2008 14:32:
>>>> Michael J Gruber wrote:
>>>>> Paul Gardiner venit, vidit, dixit 16.05.2008 13:25:
>>>>>> I create the initial repository with
>>>>>>
>>>>>>      git-clone /<full-path>/<name>.git/ <folder>
>>>>>>
>>>>>> That works fine, but then I can't fetch. git-fetch gives the error
>>>>>> "fatal: 'origin': unable to chdir or not a git archive"
>>>>>> "fatal: The remote end hung up unexpectedly"
>>>>>>
>>>>>> P.
>>>>> Are you trying to clone a bare repository?
>>>>> Or is your repo maybe at /<full-path>/<name> with a .git subdir?
>>>> Yes, a bare repository.
>>> Then, maybe the full list of command lines (including cd and git-fetch)
>>> would be helpful in order to track this down.
>> Ok, sorry, thought it was probable something really obvious. Here's the
>> sequence (using git version 1.5.4).
>>
>> $ git-clone /big/git/paul.git/ epage
>> Initialized empty Git repository in /home/paul/epage/.git/
>> 719749 bolcks
> 
> Something tells me that this is not a copy/paste ;-)

The "big" bit you mean? :-) It just happened to be the name
chosen for the mount of a large disc when added to the
server.

>> $ cd epage
>> $ git-fetch
>> fatal: 'origin': unable to chdir or not a git archive
>> fatal: The remote end hung up unexpectedly
> 
> Is there a "[remote "origin"]" section in .git/config?  What Git version 
> is this, anyway?

No, not in /home/paul/epage/.git/config. There's just a [core] section. 
I guess that's the problem. I thought git-clone set that up automatically.

It's v1.5.4

P.
