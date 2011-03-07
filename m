From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Newbie question about setting up git repository from svn (git
 svn)
Date: Sun, 06 Mar 2011 20:34:04 -0600
Message-ID: <4D74441C.6000607@gmail.com>
References: <AANLkTi=UG4oq4QHhKoDOi9+4bhF1TDy4Z26ORj9Bdcwc@mail.gmail.com> <4D7441A9.7090505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Hillel (Sabba) Markowitz" <sabbahillel@gmail.com>,
	git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Mar 07 03:34:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwQH9-0004ox-LA
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 03:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988Ab1CGCeK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Mar 2011 21:34:10 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63700 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab1CGCeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 21:34:09 -0500
Received: by yxs7 with SMTP id 7so1456825yxs.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 18:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=mWjO9AKY6LAX4S/o8pY6WU4/Y7asv2E0OrNYHzS2Jis=;
        b=bUSqA8sJj6gDvVZ2guVWDZN8K5ZMiVExW/6Qk3FguCwsallrYkftysmIghQeLShx0W
         6XQDr7i1NwaK4N7p/6iATjq10YSGlQ735+cQT5znMlTooL5eAPiQmLYyDjxqCzhWti9K
         YXpppF6QHU+0XJwdsdYIDO+jSy3SiGJ5HRLH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=aErWHtIelAxbZbOfrzu7o7ClZxtvxpoUcM/4nOxdP425vrrmjqwGEvurESJvko2iUl
         K6KhWuAmFnLmUzTEnaMtsEsBevt6Gk8Itr99rVNFeNephhsYJlSzbgQbpPUJ9toAkTIv
         FbMY2LKdR/+hIs7lJnWPdem6i/YDrMmoVHl9s=
Received: by 10.90.250.23 with SMTP id x23mr4398835agh.8.1299465248479;
        Sun, 06 Mar 2011 18:34:08 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id x37sm3099134ana.28.2011.03.06.18.34.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 18:34:07 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.14) Gecko/20110221 Thunderbird/3.1.8
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4D7441A9.7090505@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168565>

On 3/6/2011 8:23 PM, Neal Kreitzinger wrote:
> On 3/4/2011 9:57 AM, Hillel (Sabba) Markowitz wrote:
>> Please respond directly to sabbahillel@gmail.com as I do not have ti=
me
>> to follow this mailing list.
>>
> It is standard practice on this newsgroup to reply to the sender and =
cc
> the original cclist along with the newgroup. Following this newsgroup
> can be challenging when your schedule is busy, but you can learn alot=
 of
> really cool stuff by perusing it regularly. I try to keep up daily bu=
t
> alas I am a few days behind.
>
>> I am attempting to set up a git repository based on an svn repositor=
y.
>> The idea would be that the members of the project would be able to u=
se
>> git exclusively with the central git repository acting as the
>> coordinator. This git server would be the only one capable of issuin=
g
>> the git svn dcommit and git svn rebase and the members of the projec=
t
>> would not have to worry about it. Eventually, the subversion
>> repository would be transferred to git.
>>
> I have no experience with git-svn (the svn part, that is), but your p=
lan
> sounds good to me. Read on to see my comments on the parts I do have
> experience with...
>
>> I created a separate Ubuntu VM in order to set up the git repository=
=2E
>> I used "git svn clone -s" to set up MyProject.git on "gitserver"
>>
>> The command "git branch -a" shows
>> * master
>> remotes/branch1
>> remotes/branch2
>> remotes/trunk
>>
>>
>> I then went to my main VM and used ssh to clone the repository
>>
>> git clone gitserver:/opt/git/MyProject
>> cd MyProject
>> git branch -a
>> * master
>> remotes/origin/HEAD -> origin/master
>> remotes/origin/master
>>
>> How do I check out the trunk or appropriate branches from the remote=
?
>> I am probably misreading the documentation. Would it be
>>
>> git checkout -b branch1
>>

Correction: (Please ignore my confusion about "trunk" in the previous=20
post. I see that by "trunk" you mean the "remotes/trunk" on gitmaster)

> "git checkout -b branch1" will create a new branch called branch1 bas=
ed
> on whatever your current HEAD is. HEAD is the commit that you are
> currently pointing to, ie. the tip of the branch currently checkout o=
ut.
> (see git checkout manpage.) The asterisk indicates above that
> you are currently on master. Therefore, "git checkout -b branch1" wil=
l
> create a new branch called "branch1" that has the same history as
> master. It sounds like you want to checkout "branch1", "branch2", and
> "trunk". Read on...
>
>> does the master on the remote (and here) actually point to the trunk
>> by default?
>> should I checkout the branches on "gitserver"?
>>
> not being familiar with git-svn, but familiar with "git", I would adv=
ise
> you to do the following:
> (1) on "gitserver" perform:
> (a) git branch branch1 remotes/branch1 (this will create a branch cal=
led
> branch1 that tracks remotes/branch1)
> (b) git branch branch2 remotes/branch2
> (c) git branch trunk remotes/trunk
> Now you have the branches master, branch1, branch2, and trunk on
> "gitserver".
> (2) I don't know how to push from a git repo to an svn repo so I can'=
t
> tell you if gitserver master points to svn trunk or not. However, rea=
d
> on for what I do know...
>
>> I also do not see how I can get the list of branches from the remote
>> location.without having to do an ssh into the gitserver, cd to the
>> repository directory, and use a 'branch -a' there. Is there a way to
>> ask for this information? I have not yet been successful in setting =
up
>> gitosis yet because this is on an internal company intranet and I do
>> not have a valid machine name for my accounts as everything is being
>> done on VMs. Thus, my public key ends with
>> "sabbahillel@desktop-ubuntu" rather than an actual machine name or
>> address.
>>
> The way you get the list is by doing a git-fetch on MyProject (AFTER =
you
> create the branches on gitserver). This will create remote tracking
> branches for all the branches on gitserver. Notice I said "branches o=
n
> gitserver" and not "remote tracking branches on gitserver". You can't
> track the remote tracking branches of your remote (at least not sanel=
y).
> Thats why you had to create tracking branches on gitserver that track
> the remote tracking branches that track the svn repo. Now that you ha=
ve
> branches "branch1", "branch2", and "trunk" on gitserver you can track
> them in MyProject. git-fetch will create remotes/origin/branch1,
> remotes/origin/branch2, remotes/origin/trunk in MyProject. Now you ca=
n
> do "git branch branch1 remotes/origin/branch1" to create the branch1
> branch in MyProject. "git checkout branch1" in MyRepo will check it o=
ut.
> Repeat for branch2 and trunk. (I'm not familiar with ssh details, but=
 I
> assume your last ssh comment is made into a non-issue by what I just
> stated above.)
>
>> Would you have a pointer to a HOW-TO that discusses this.
>>
> I assume these links:
>
> http://git-scm.com/course/svn.html
>
> https://git.wiki.kernel.org/index.php/GitSvnCrashCourse
>
> https://git.wiki.kernel.org/index.php/GitSvnSwitch
>
> https://git.wiki.kernel.org/index.php/SvnMigration
>
> http://utsl.gen.nz/talks/git-svn/intro.html
>
> http://www.tfnico.com/presentations/git-and-subversion
>
> or the git-svn manpage:
>
> http://www.kernel.org/pub/software/scm/git/docs/v1.7.1.4/git-svn.html
>
> will help you. (you need to use the git version of the manual that
> corresponds to your installation. 1.7.1.4 is relevant to me, but perh=
aps
> not to you.)
>
>> Thanks for any help that you can give me.
>>
>> --
>> Sabba - =D7=A1=D7=91=D7=90 =D7=94=D7=9C=D7=9C - Hillel
>> Hillel (Sabba) Markowitz | Said the fox to the fish, "Join me ashore=
"
>> SabbaHillel@gmail.com | The fish are the Jews, Torah is our water
>> http://sabbahillel.blogspot.com
>
> Despite my ignorance regarding svn and git-svn, I hope my comments wi=
ll
> be of some help to you or point you in the right direction.
>
> v/r,
> Neal
>
