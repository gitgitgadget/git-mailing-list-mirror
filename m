From: Andreas Ericsson <ae@op5.se>
Subject: Re: Switching from CVS to GIT
Date: Sun, 14 Oct 2007 21:09:11 +0200
Message-ID: <47126957.1020204@op5.se>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>,
	git list <git@vger.kernel.org>, Eli Zaretskii <eliz@gnu.org>,
	Make Windows <make-w32@gnu.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 21:09:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih8qB-0001nF-Qn
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 21:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbXJNTJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 15:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbXJNTJR
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 15:09:17 -0400
Received: from mail.op5.se ([193.201.96.20]:56880 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbXJNTJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 15:09:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D354D173068B;
	Sun, 14 Oct 2007 21:07:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NBpY9EoqLAwO; Sun, 14 Oct 2007 21:07:17 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id D82501730656;
	Sun, 14 Oct 2007 21:07:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0710141934310.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60893>

Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 14 Oct 2007, Andreas Ericsson wrote:
> 
>> Benoit SIGOURE wrote:
>>> Context: GNU make seems to be willing to switch from CVS to ... something
>>> else.
>>>
>>> On Oct 14, 2007, at 6:57 PM, Paul Smith wrote:
>>>
>>>> [...] the big thing no one else seems to have addressed much in
>>>> other discussions I've seen is portability.  It LOOKS like there are
>>>> native ports of GIT to MINGW, but I have no idea how complete and usable
>>>> they are.  If someone who has a Windows system could look into that it
>>>> would be a big help.
>>> I think the best thing to do is to ask directly on the Git ML.
>>>
>>> Someone already pointed out that he'd like to use Git on Windows but 
>>> doesn't want to install either Cygwin or MSYS.  Is this possible, or 
>>> will it be possible in the near future?
>> It is sort of possible. Without cygwin he'll be in the black for the few 
>> features that are still implemented as shell-scripts, but perhaps he/she 
>> will then be inclined to help us migrate those scripts to C builtins.
> 
> Umm.  There are quite a few shell scripts still _necessary_ to run git: 
> git-commit, git-fetch and git-merge being the most prominent ones.  The 
> first two are in the process of being rewritten _right_ _now_, but no 
> official git release has them yet.
> 

Ah, right. I think of "accepted into git.git" as being released.

> And I have to disagree strongly with the "black": In msysGit (which brings 
> its own minimal version of MSys), it is very smooth.
> 

Oh? I didn't know that. Windows and its unixifying toolboxes is unknown
territory to me, as I happily spend all my time on various unices.

>>>  Is it possible to use one of the various GUIs (git-gui, gitk, qgit) 
>>> on Windows without requiring a POSIXish shell etc.?
>>>
>> qgit is possible to use natively, if one installs the qgit4 libraries 
>> for windows, but it's more of a viewer than an action gui. git-gui and 
>> gitk are usable if you have the windows TCL port. I haven't tried it, 
>> but there are installers available, so testing it out (with all 
>> dependencies) shouldn't take too long.
> 
> FWIW msysGit comes with Tcl.  You can run git gui and gitk without any 
> hassles.
> 

Yes, my phrasing there was a bit obscure. I meant that all dependencies
are installed by the installer package.

>>>  (if Git is available as a library, and if this library works on 
>>> Windows, it will greatly help truly native Windows ports).
>> Yup. I believe the primary reason for libification is to easier support 
>> both porting and fully-fledged gui's.
> 
> Why?
> 
> I do not see any reason why libification helps the user experience on 
> Windows.
> 

I was under the impression that the windows port suffers from Windows'
lack of a proper fork() and friends and that a proper library would
help solving those problems. Perhaps I was misinformed.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
