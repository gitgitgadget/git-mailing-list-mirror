From: Diego Viola <diego.viola@gmail.com>
Subject: Re: Please consider adding a -f switch to git-clone (or something similar)
Date: Sat, 7 Mar 2015 22:53:13 -0300
Message-ID: <CA+ToGPFSbOjfd5gJg+r-7WkwMB=m=4sOupaZo1WUn+O0bxAAXw@mail.gmail.com>
References: <CA+ToGPEZN7TBcYF3o5YgbayjZ8WKok-fjTPeq5nbt2vAG1wDDQ@mail.gmail.com>
	<87d24kzbor.fsf@igel.home>
	<CA+ToGPHOM9mu_ng4wVc7QUGyvf09y=nDjE32oSh9JzKbpbzN2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Mar 08 02:53:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUQPC-0000O3-8J
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 02:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbbCHBxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 20:53:16 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:38223 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbbCHBxP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 20:53:15 -0500
Received: by labgf13 with SMTP id gf13so40053672lab.5
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 17:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OwXQbyPHO8FS/RVeK1D1WJ2LJILRTbOhyttgSaF3fGM=;
        b=0A2ebks1rmWZevhSGmo9wVTcrpJIpaplcF5s5gxtOHpdJANdNAr41zEJdZ7O7v7WAb
         kDM9Vn19oTfT9CfFph0INTZkSQ0XMoI+L6m0hH8adC6asw8t+W8NjsKCxFUHYzu7BgpF
         tCAm5G7htKBA0sRF54IHuLP4ZruwXfM/n4cWcPcq1DMV0hrOxtWMGXkpUocw5nn5j08O
         nG9KjR+wI1tH5GCZgj3cI3+ZDek/0HGGABSSuwp27LgMgQGyqQZjaF8bXfoLaz63YcI9
         TAG8gnZo4yifh/9ZxKVVRLDYOk0SCfnaVgedCQe9xi1gsu9YQMF8ufk5MpMv1DCw8q/8
         HVCg==
X-Received: by 10.112.12.196 with SMTP id a4mr19598659lbc.8.1425779593898;
 Sat, 07 Mar 2015 17:53:13 -0800 (PST)
Received: by 10.114.1.208 with HTTP; Sat, 7 Mar 2015 17:53:13 -0800 (PST)
In-Reply-To: <CA+ToGPHOM9mu_ng4wVc7QUGyvf09y=nDjE32oSh9JzKbpbzN2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265023>

Something like this is the scenario I'm talking about:

$ mkdir non-empty-dir
$ cd non-empty-dir
$ touch foo bar baz
$ git clone -f url:user/dotfiles.git .
$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Untracked files:
  (use "git add <file>..." to include in what will be committed)

    bar
    baz
    foo

nothing added to commit but untracked files present (use "git add" to track)


On Sat, Mar 7, 2015 at 9:02 PM, Diego Viola <diego.viola@gmail.com> wrote:
> Sorry, I wanted to say: I know I can git-clone in a empty directory
> and then move the files over to $HOME.
>
> I know I can git init in a non-empty directory. :-)
>
> Thanks,
>
> Diego
>
> On Sat, Mar 7, 2015 at 7:26 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> Diego Viola <diego.viola@gmail.com> writes:
>>
>>> I know I could git-init in a empty directory
>>
>> You can also git init a non-empty directory.
>>
>> Andreas.
>>
>> --
>> Andreas Schwab, schwab@linux-m68k.org
>> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
>> "And now for something completely different."
