From: DeMarcus <demarcus@hotmail.com>
Subject: Re: How can I do an automatic stash when doing a checkout?
Date: Mon, 19 Dec 2011 22:43:07 +0100
Message-ID: <jcob5e$hsp$1@dough.gmane.org>
References: <jcki8u$oip$1@dough.gmane.org> <84ty4ycdcc.fsf@cenderis.demon.co.uk> <jckvpk$i8v$1@dough.gmane.org> <4EEF63CA.4030201@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 22:43:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rckzb-0005wl-E5
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 22:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab1LSVn2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Dec 2011 16:43:28 -0500
Received: from lo.gmane.org ([80.91.229.12]:36011 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752287Ab1LSVn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 16:43:26 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RckzT-0005ta-A5
	for git@vger.kernel.org; Mon, 19 Dec 2011 22:43:23 +0100
Received: from c83-251-142-66.bredband.comhem.se ([83.251.142.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 22:43:23 +0100
Received: from demarcus by c83-251-142-66.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 22:43:23 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c83-251-142-66.bredband.comhem.se
User-Agent: Mozilla/5.0 (Windows NT 6.0; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EEF63CA.4030201@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187477>

On 2011-12-19 17:18, Dirk S=FCsserott wrote:
> Am 18.12.2011 16:10 schrieb DeMarcus:
> [...]
>
>>>> With the git stash command I can clean the directory the way I wan=
t
>>>> but the stash command is not connected to a particular branch.
>>>>
>>>> Is there a way to have git checkout do an automatic stash when doi=
ng a
>>>> checkout to another branch, and then do an automatic git stash app=
ly
>>>> with the correct stash when changing back to the previous branch
>>>> again?
>>>
>>> You probably don't want to use stash. Just commit whatever partial =
work
>>> you've done.
>>>
>>
>> It feels strange doing a commit of partial work. Some of the files m=
ay
>> not even be supposed to be checked in.
>>
>>> You could also just checkout different branches in different
>>> directories. Nothing wrong with doing that in git.
>>>
>>
>> Ok thanks, that would give me the same behavior as I have today.
>>
>> However, I can see some benefits with have everything in the same
>> directory as git allows compared to other VCSs. And since the stashi=
ng
>> feature is already there in git, it would be nice if the git checkou=
t
>> with some flag could use stashing automatically.
>>
>>
>
> DeMarcus,
>
> probably a post-checkout hook could help you with autostashing, but t=
hat
> would need some scripting. Have a look at "git hooks --help".
> I sometimes use such a hook to auto-update submodules when checking o=
ut
> a branch. To be fair: I don't know how to identify the "right" stash =
then.
>

Thanks! I'll check that out. Maybe the right stash could be checked-in=20
itself somehow.
