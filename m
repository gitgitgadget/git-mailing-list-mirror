From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Suggestion: doc restructuring [was: Re: Considering teaching
 plumbing to users harmful]
Date: Fri, 18 Jul 2008 13:26:09 -0500
Message-ID: <4880E041.8070001@freescale.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <48806D03.30603@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Jul 18 20:32:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJukS-00023h-Dn
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 20:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409AbYGRSbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 14:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755565AbYGRSbI
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 14:31:08 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:44153 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118AbYGRSbH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 14:31:07 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m6IIQB7j003706;
	Fri, 18 Jul 2008 11:26:13 -0700 (MST)
Received: from [10.214.73.22] ([10.214.73.22])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m6IIQ7Kn005331;
	Fri, 18 Jul 2008 13:26:07 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48806D03.30603@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89070>

Michael J Gruber wrote:
> Johannes Schindelin venit, vidit, dixit 16.07.2008 19:21:
> ...
>>
>> Am I the only one who deems teaching plumbing to users ("I like it 
>> raw!  So I teach it the same way!") harmful?
>>
>> Ciao,
>> Dscho "who is sad"
> 
> In an attempt at making not only Dscho happier I suggest a restructuring 
> of the man pages in the following way:
> 
> In each man page, put a note which says something like:
> "This is part of linkgit:gitplumbing[7]." and the like
> It should be in a prominent place, such as the last line of "DESCRIPTION".
> 
> gitplumbing[7] etc. pages should contain:
> - a definition of the respective term together with appropriate usage 
> advice (regular use/scripting..., "Let there be dragons.")
> - a list of commands like we have in git[1] right now
> 
> With the current situation, people don't look at git[1] in order to find 
> out what they're supposed to use. It's too long anyways, and could link 
> the above pages instead.
> 
> If there's enough interest/agreement I'd come up with a refactoring patch.
> 
> Michael

I'd like to throw my beef with the main Git man page
out there for consideration as well...

When I hit the man page, which I do on line quite frequently,
I usually use it as an index to get to the real, current man
page for a particular command.  (I am at git.kernel.org for
other reasons all the time, so it is convenient.)

The current sub-setting and organization is painful because
it doesn't have a comprehensive, linear, alphabetized list
of commands from which to select the real man page.  I never
know which "section" to find a given command.  Is it an
Ancillary "manipulator" command?  Or maybe just a "Manipulation"
command, or maybe an "Interrogation" command?  A "Helper"?

I always have to painfully search the page for it instead.

I'm not saying get rid of the Categorical organization.
I am saying, we need a first-page with a straight, alphabetized
command index somewhere easy and located conveniently.

Thanks for listening,
jdl
