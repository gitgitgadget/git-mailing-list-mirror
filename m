From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: What am I doing wrong?
Date: Fri, 16 May 2008 16:44:21 +0200
Message-ID: <g0k6k7$t4k$1@ger.gmane.org>
References: <482D6F41.2060809@laser-point.co.uk> <g0js1p$l22$1@ger.gmane.org> <482D7EE1.9020503@laser-point.co.uk> <g0jvig$1dn$1@ger.gmane.org> <482D8BEB.6070706@laser-point.co.uk> <alpine.DEB.1.00.0805161439100.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 16:49:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx1Dd-0004nF-5I
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 16:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbYEPOon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 10:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758658AbYEPOom
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 10:44:42 -0400
Received: from main.gmane.org ([80.91.229.2]:51811 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758012AbYEPOoj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 10:44:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jx1Ad-0007aK-TL
	for git@vger.kernel.org; Fri, 16 May 2008 14:44:32 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 May 2008 14:44:31 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 May 2008 14:44:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <alpine.DEB.1.00.0805161439100.30431@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82300>

Johannes Schindelin venit, vidit, dixit 16.05.2008 15:40:
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

Let's just hope that's not units of boelkstoff ;)

>> $ cd epage
>> $ git-fetch
>> fatal: 'origin': unable to chdir or not a git archive
>> fatal: The remote end hung up unexpectedly
> 
> Is there a "[remote "origin"]" section in .git/config?  What Git version 
> is this, anyway?

1.5.4

Could git trip over that trailing slash? git 1.5.5.1 certainly doesn't.

BTW: The above shows something that confused me initially about cloning: 
git reports the creation of an empty repo, nothing else. But it does 
much more, of course, just without reporting.

Michael
