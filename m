Received: from libero.it (smtp-18-vd.italiaonline.it [213.209.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A8F2594AD
	for <git@vger.kernel.org>; Sun, 29 Dec 2024 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735462867; cv=none; b=j3IXbmptnd0AW5go9YExZlOjnS8CDLIWV8USo2QddbVyN0LRxd6FYycGj4R0tdFeL+o8luWYfixMYQ1sbHKDfVhU9H2xD+JxCSCw+X8PMeIoaqAy9GzxQflDCj+kRLfUJhzuIYpGN20eIoL+xObiubR4UOUptwCph9jDzKZN8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735462867; c=relaxed/simple;
	bh=1zbr+T3KJAtcxlENATmZE3BjfsP8FaEssOe84bjD9fc=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uxsY9nv8k2TMQkE24HCAuYoHaGqKnXiNuXAi8DSAEfy8leM8LHFYMTUCGWid4nvs9G2DMFnFXewKB20QJ12ODtzSqdB9xtRx6l4sRczVTvLzR6jiE27pZ9Ne/IfK4DLDyYwu/7ExbHHDdDP0y1GzjIyCUGNseDD+xAf+p08TZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=U3rhV2yk; arc=none smtp.client-ip=213.209.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="U3rhV2yk"
Received: from [192.168.0.129] ([188.27.146.10])
	by smtp-18.iol.local with ESMTPA
	id RpATtnOh7getmRpATtRD6F; Sun, 29 Dec 2024 10:01:02 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1735462862; bh=Yzf2voaHeOPwLtqpYa/GcAjejONHg8z9oztn6q9PJHI=;
	h=From;
	b=U3rhV2ykJmsrD+tuq781ltlf3g08BTRVOyi8Us1mjHgBPTX6BgJgnGpd74ynr5fhF
	 QYWpKGMQHfdt85R8m1eSQoZK2IWPvHf24EHq85ENESgAZyqa0D3IMHKI9IGJfz2NJk
	 SbBWQRxeSHWKihnKfE3EQp9IVDTkIYHGTgcJkzX1p5SSHbXw7YMiHmfaCVk76K9nCs
	 aYbQ6SK9Ob1i6Ow6qm8GpEH6Vf9XJZSufISIE5k5xBzzZUp/pNlCicPKK8+cMKHbuL
	 H01Eylt0iouz1ac84eHiC+SxfmyhQYStoehJe4DhtwvrtMqdSJ8jq783liwlaOfI8a
	 pdCS/Y42dM6kQ==
X-CNFS-Analysis: v=2.4 cv=QPmjRRLL c=1 sm=1 tr=0 ts=67710fce cx=a_exe
 a=nouTapptOgoxzTc4WCMdog==:117 a=nouTapptOgoxzTc4WCMdog==:17
 a=IkcTkHD0fZMA:10 a=f7IdgyKtn90A:10 a=Dx4yW56zAAAA:8 a=uHY6J-XUl6GYtki2P7UA:9
 a=QEXdDO2ut3YA:10 a=X_u8qhY6y2Nm79co_leF:22
Subject: Re: connecting the local main branch to the remote origin/main
 without pushing
To: rsbecker@nexbridge.com, git@vger.kernel.org
References: <a69c4e2e-cbb0-c242-a34a-8997a84fefb7@libero.it>
 <027f01db5943$340b2c70$9c218550$@nexbridge.com>
From: crstml@libero.it
Message-ID: <e6d9bd13-eddb-2cc7-f27c-13d2b64b487a@libero.it>
Date: Sun, 29 Dec 2024 10:01:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <027f01db5943$340b2c70$9c218550$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEGZQ730RQkdde2+tPwOCMhxoRXIK5TFRFc7zXQE1yZPBqbSCe1MknrbZ06p++a38jmySLLjjMOjLfz/ObM9IMhNIApXCl5o9/QIN7vxm5BF5JqyAOfC
 kbvyKTWuYvOtpoKylEFYYFphHD1+LnpH6GYxnPWwjbU79eCgtp5WbFx1eYwgcfeuutd54nPAc77ucYbEqAdGeJFSYbiGEAfy+WDYW1DRBPf5RZ6nL04ViNKx

rsbecker@nexbridge.com wrote:
> On December 28, 2024 10:47 AM crstml@libero.it wrote:
>> I would like to put a set of files under version control and I have some issues with
>> the workflow. Let me explain:
>>
>> First I create the bare repository with the command:
>>
>>      git init --bare -b main ~/rps/project-x.git
>>
>> Then I can proceed in one of the following ways:
>>
>>
>> ---- Method 1 ----
>>
>>     By first cloning the remote repository locally and next
>>     putting the files under version control. All running the
>>     following commands:
>>
>>     1    cd ~/projects;
>>     2    git clone ~/rps/project-x.git project-x
>>     3    cp ~/my-existing-project-x-files/* project-x
>>     4    cd project-x
>>     5    git add .
>>     6    git commit -m "fc"
>>     7    git push origin
>>     8    rm -rf ~/my-existing-project-x-files   # clean your home folder
>>
>> ---- Method 2 ----
>>
>>     By putting the existing files under version control and next
>>     adding the remote. Running the following commands:
>>
>>     1    cd ~/projects/project-x
>>     2    git init -b main
>>     3    git add .
>>     4    git commit -m "fc"
>>     5    git remote add origin ~/rps/project-x.git
>>     6    git push --set-upstream origin main
>>
>>
>> Let me discuss both these methods:
>>
>> Method 1:
>>
>>    Everything works but the cp statement may be problematic. If
>>    you have hidden files (starting with .) or if you want to
>>    preserve the file permissions and owenership, the invokation
>>    of the cp command is trickier.
>>
>>    After you copy the files all the next statements work well.
>>    The main branch in the cloned repository is connected to the
>>    upstream origin/main branch and "git push" will work.
>>
>>    There is one more small problem with this workflow: the
>>    statement 8 is ugly.
>>
>>
>>
>> Method 2
>>
>>    Everything is very clean (apparently). We don't have to think
>>    to file permissions, hidden files, tricky cp invocations and
>>    there is no need to clean your home folder at the end. We are
>>    interested to put files under version control, so we focus only
>>    the version control system.
>>
>>
>>    The problem  with this workflow (from my point of view) is the
>>    statement 6. This statement makes two things which is contrary
>>    to the UNIX philosophy: programs that do one thing and do it well.
>>
>>        1) The command connects the local main branch to the
>>           remote origin/main branch.
>>
>>        2) Pushes the files to the remote.
>>
>>    From my point of view instead of executing the statement 6 I would
>>    like to execute the following two statements that I will number
>>    here as 6.1 and 6.2:
>>
>>     6.1  # To connect the main branch to origin/main
>>          #
>>          git branch -u origin/main main
>>
>>     6.2  # To push to the remote.
>>          #
>>          git push origin
>>
>>     However, the statement 6.1 does not work. Git prints the following
>>     message.
>>
>>     hint: If you are planning on basing your work on an upstream
>>     hint: branch that already exists at the remote, you may need to
>>     hint: run "git fetch" to retrieve it.
>>     hint:
>>     hint: If you are planning to push out a new local branch that
>>     hint: will track its remote counterpart, you may want to use
>>     hint: "git push -u" to set the upstream config as you push.
>>     hint: Disable this message with "git config advice.setUpstreamFailure false"
>>
>>     The end solution it suggests to use with "git push -u" which
>>     is the same as the statement on line 6 that I would like to
>>     avoid.  I would add that by issuing a "git fecth" before 6.1
>>     would not bring the remote branch origin/main in the local
>>     repository.
>>
>>     The core of the problem is that the local branch main is not connected
>>     to the origin/main branch.
>>
>> My question is:
>>       Is it possible when applying the method 2 to have (without pushing)
>>       the local main branch connected to the remote origin/main branch as
>>       in the case of method 1 which by cloning connects these branches.
> 
> I think method 2 is failing for you because you do not have origin/main in your
> local repository. That requires a git fetch. Git fetch will not overwrite your
> working area, but is needed so that tracking can occur with an existing
> remote branch.
>
> The reason git push -u works is that the resolution of your branch tracking
> can be worked out by git as part of the push, where the remote reference
> is known. Without that, the git branch -u does not work (no reference).
> 
> So do the git fetch as 5.9 in Method 2, then 6.1 should work, assuming origin/main
> exists in your remote. This downloads the clone history without modifying
> your work area, so it should be fine.
> 
Good observations.

I've imagined that the commit history and the configuration of the remote
repository is necessary to be known to the local git and I've also performed
a test in which I've executed a "git fetch" before 6.1 (without "git fetch"
no information from the remote repository exists locally).

Unfortunately it did not work and git printed out the following message:

hint:
hint: If you are planning on basing your work on an upstream
hint: branch that already exists at the remote, you may need to
hint: run "git fetch" to retrieve it.
hint:
hint: If you are planning to push out a new local branch that
hint: will track its remote counterpart, you may want to use
hint: "git push -u" to set the upstream config as you push.
hint: Disable this message with "git config advice.setUpstreamFailure false"


> --Randall
> 

