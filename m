From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: RFC: Subprojects
Date: Mon, 16 Jan 2006 14:25:02 -0800
Message-ID: <43CC1D3E.1070700@gmail.com>
References: <43C52B1F.8020706@hogyros.de>  <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>  <43C537C9.4090206@hogyros.de>  <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>  <7vacdzkww3.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>  <43C951B6.5030607@gmail.com>  <Pine.LNX.4.64.0601141154590.13339@g5.osdl.org>  <43C95F69.7090200@gmail.com> <7vk6d2fsu6.fsf@assigned-by-dhcp.cox.net> <46a038f90601141628n2ec32e8fy7fc23d8d7884c0f2@mail.gmail.com> <Pine.LNX.4.64.0601152248030.25300@iabervon.org> <43CBEF47.7050607@gmail.com> <Pine.LNX.4.64.0601161414080.25300@iabervon.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 23:25:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eycmm-0003wl-CY
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 23:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWAPWZJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 17:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWAPWZI
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 17:25:08 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:9141 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751225AbWAPWZG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2006 17:25:06 -0500
Received: by wproxy.gmail.com with SMTP id i3so1202776wra
        for <git@vger.kernel.org>; Mon, 16 Jan 2006 14:25:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fMUXj8QCNRyzm3HKLpdbVTXqN8myS/5cw191ULOiMbkM3mTDQ6lPU3LzVMXn1RHBnTa37zB7CwkSIuxj1CzguZIGyS9dQEUUJ4DdG9ZMJ2Bwdww83k9LwcKO0u/LUiUucgHlbR5ct1RRDeYGtLtusmrk9u7IOY/cXH1KqFgVQv4=
Received: by 10.65.233.8 with SMTP id k8mr3376572qbr;
        Mon, 16 Jan 2006 14:25:05 -0800 (PST)
Received: from ?10.0.0.6? ( [68.234.172.144])
        by mx.gmail.com with ESMTP id e15sm1141296qba.2006.01.16.14.25.04;
        Mon, 16 Jan 2006 14:25:05 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0601161414080.25300@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14762>

Daniel Barkalow wrote:
> On Mon, 16 Jan 2006, A Large Angry SCM wrote:
> 
>>Daniel Barkalow wrote:
>>[...]
>>>So the problem with handling subprojects with the build system is that it is
>>>too tempting to use the revision control system directly on the subproject,
>>>at which point the thing you're developing and testing isn't at all what
>>>other people will get if they check out your commit. You want "git status"
>>>to report it as an uncommitted change if you have a different revision of
>>>the subproject than your previous commit had, and it can't tell if this
>>>information is buried in the build system.
>>Using "git-status" is the wrong tool to use there. What you should be using is
>>"make project_status". Claiming "that it is too tempting to use the revision
>>control system on the subproject" is wrong; you should use the SCM (of the
>>subproject) to manage the subproject. You use the build system to manage the
>>_entire_ project.
> 
> I'm talking about using "git status" on the main project, in case you're 
> misunderstanding me. If you can manage the entire project with the build 
> system, then you don't need git or any version control at all, aside from 
> your build system. But you'd also lose the ability to use webgit, bisect, 
> gitk, git log, and so forth on the project as a whole.

When you say "main project", do you mean the top level project and all 
of its subprojects? Or just the top level project without any of its 
subprojects?

A build system and a SCM working together can be a powerful very tool, 
even if one or both of the components is not. Since managing a project 
with a build system and no SCM means that you don't have any history and 
since you seem to want access to the project's history, I'll ignore you 
statement. (Backups and directory snapshots are primitive SCMs.)

Consider the following:

1) For a project to be a sub-project, it must also be a project.

2) So the standard SCM tools will work on the project.

3) The super-project is also a project and the standard SCM tools will 
work on it.

4) Projects managed by an SCM are only considered consistent and usable 
at specific points in that project's history; it may be every recorded 
point in it's history or it may be just a few specific recorded points.

5) A super-project only cares about specific states of its sub-projects, 
corresponding to points in the sub-project's history.

6) For each sub-project, the super-project needs to record the 
sub-project's state identifier for each recorded point in the 
super-project's history.

7) The super-project can record each sub-project's state identifier 
somewhere in the build system.

8) If the super-project's SCM is Git then webgit, bisect, gitk, git log, 
and so forth all work and will identify when and where the recorded 
state identifier of each sub-project is changed.

9) The information is available to the build system to permit using 
git-bisect in the super-project and notice that the breakage occurred 
when the recorded state identifier of a sub-project changed. If the 
sub-project used Git, the build system can automatically start 
git-bisect'ing in the sub-project.

10) The information is available to the build system to permit doing 
similar things for git-log and so forth.

11) Webgit and gitk are a little more work but by creating a git 
repository that contains all of the history and refs of each project in 
the entire project, you can navigate and view the history of any project 
in the entire project.

12) If the SCM of some of the sub-projects is not Git, the build system 
can still do git-bisect, git-log, etc. equivalents for the entire 
project (subject to the limitations of the SCMs involved).


>>>The tricky question is whether we should permit the "subproject" objects to
>>>specify a revision that isn't a hash, for use in identifying revisions of
>>>subprojects in other systems.
>>Why would you want to limit how required versions of subprojects are
>>specified? Your project policies and procedures may require that subprojects
>>be specified by a subproject SCM specific immutable revision but the policies
>>and procedures of other projects may not be so restrictive and could accept a
>>tag identifying the latest "stable" (or something) revision.
> 
> If you accept a tag identifying the latest stable revision, then you might 
> as well not bother. The point of revision controlling a project is to be 
> able to reconstruct previous states. If you allow any event, especially 
> outside, unrelated, events to change the reconstructed state for a 
> revision, then this is not the case. Your normal debugging situation will 
> be "It's broken, and I didn't change anything." because someone somewhere 
> else changed something, and you have no record of what last worked. And 
> you can obviously forget any hope of "git bisect" working.

CVS does not have the concept of "hash" for use in identifying the state 
of a particular set of files but it does have tags and CVS tags work 
like Git tags. The form of identifier that is used to identify the 
particular state of interest of a sub-project is dependent on the 
policies and procedures of the super-project, and the SCM of the 
sub-project.

The need to reproduce a particular state at sometime in the future is 
well understood, even in organizations that use tools that only support 
tags. Implying that it's not possible without using Git's immutable 
hashes as the state identifier is just wrong.

--
