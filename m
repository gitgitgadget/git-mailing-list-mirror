From: "Zorba" <cr@altmore.co.uk>
Subject: Re: a few scenarios before I create my first repo [Scanned]
Date: Fri, 26 Dec 2008 01:07:15 -0000
Message-ID: <gj1aoj$jas$1@ger.gmane.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D00@ALTMORE-SVR.altmore.local> <7vabajrcfn.fsf@gitster.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 26 02:11:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG1Eq-0004KI-3m
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 02:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbYLZBKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 20:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbYLZBKJ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 20:10:09 -0500
Received: from main.gmane.org ([80.91.229.2]:48758 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbYLZBKI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 20:10:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LG1DG-0003Eh-J2
	for git@vger.kernel.org; Fri, 26 Dec 2008 01:10:02 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 01:10:02 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 01:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.2 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103916>

Junio,

I am deeply priveleged that a guy like you would answer my simple Q's, 
especially in holiday time !
Especially as now I've discovered a seperate list for users at 
gman.comp.version-control.git.user - apologies for posting here...

> What's [scanned]?

sorry, its just something Sophos adds to our outgoing email to show its 
virus checked it

>> (1a) Do I need to install windows git on the same machine I want to
>> store the files on ?  Or can I install git on my workstation PC and
>> create the repo on the server ?
>
> The model employed by git is not "client working with centralized server".
> On whichever machine you want to be recording your changes (aka "running
> 'git commit'"), you would need to have git installed.

Ok, I'll install git on workstation, where I'll be running the bash / gui 
from
but I'll create the repo on the server (for backup purposes) - so won't need 
to install git there I'm assuming?

 >> (1b) if i create a repo on my office PC, can it easily be moved
>> (including all history) to another PC (e.g. LAN server) if we decide to
>> implement git across the team (If not, or its inconvenient, I need to
>> create the repo on the server)
>
> git is a distributed source code management system.  People often deploy
> one (or more, in hierarchical fashion in an advanced set-up) bare server
> repository for everybody to meet and synchronize.  Each developer has one
> repository (or more) on his or her own on his or her machines.  Most
> notably, if you work on your notebook and on your desktop (i.e. two
> machines), you will have (at least) one repository on each of them [*1*].
>
>> (2) if i create a repo on my work PC, can it easily be migrated
>> (including all history) to a repo on github (etc.) ?
>
> I do not know about github in particular (that's #github question) but in
> principle, yes.  Easy exchange of development histories across
> repositories is the whole point of distributedness.

super!
I'm sorry distributed SCM was new to me
last time I used SCM was 10yrs ago - Visual Sourcesafe, PVCS (grrr), 
clearcase (not bad)

>> (3) if I create a repo and commit the first baseline, can I later create
>> an ancestor commit to that baseline, if I subsequently find an older
>> version of the project lying around on the file system (or, same concept
>> i guess, if i find a project version that sits between say version v1.0
>> and v1.1 (where v1.0 is the parent tag of v1.1) can i interleave the
>> project files as say v1.01.
>
> You can graft the older ones behind the root commit and filter-branch the
> result to cast the graft in stone.  You are strongly recommended to do
> that in one repository first, and have reasonable level of confidence in
> the result before you publish it to other repositories, as running
> filter-branch to rewrite the history after people (or yourself) cloned the
> history to multiple places would cause trouble to thoese .

that's great, it will allow us to capture the flow of work in our project so 
far, and amend if some other version turns up !
Your answers are enough for me to proceed and give git a go.

> For more details, see the user-manual.  Don't dive into manual pages for
> individual commands, which are for people who already understood the basic
> concepts in the user manual.

thanks, your overview here has really helped

> [Footnote]
> *1* Maybe we should change our pricing structure to be based on the number
> of repositories, not on the number of users.  Currently we charge $0 per
> user, but we should change $0 per repository ;-)

LOL !
you guys are great, thank you on behalf of people like me

Happy Christmas ! 
