From: Erik Friesen <erik@aercon.net>
Subject: Re: Windows Bluescreen
Date: Wed, 11 Feb 2015 07:33:22 -0500
Message-ID: <CAEuupitA4PHBByLLcqc5pVbn1C+ZyQ6Vzbk-LsOjseOEHhkENw@mail.gmail.com>
References: <20150209201218.Horde.w9pQrdbL-Mf8IdgtaJtVuQ9@server.aercontechnologies.net>
	<CAFOYHZADerTE88KudrH7LTi3yX4Sg1vJe3Xj0vJH+DNeO6NOEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>, msysgit@googlegroups.com
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 13:33:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLWU1-0003pC-67
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 13:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbbBKMdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 07:33:24 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:38730 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbbBKMdX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2015 07:33:23 -0500
Received: by iecrd18 with SMTP id rd18so3482726iec.5
        for <git@vger.kernel.org>; Wed, 11 Feb 2015 04:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=i0YbGDutklm2vMeWq/tg37U58MhTOSldG5zyRSI2gCk=;
        b=kM6dTfMn4hQUQRs/6jyXoX6oOs1C+bYODoj06f2M4nhTaqML+E04CdGl4V5sHDW2CG
         P2UTR/3OQlv1DmZnWQPi3/zD9BMFK0gaJo6YA3qWxhTqg3WquC/sJ+Pt9XB1UhL3/jL1
         ncsc353rMADRH+wmnsTZLCs7p99agi4LXVmM1yQMuD31cpvabHLR0c2gNye5Ilw8JlgO
         PTNYY7YjQdN6OQviTTuUGTeQrGhwu7ZNhBUqH+EU+hVKFD10bb5vZrtYjAh5AsvnKfzf
         Ql0gaVzwC/a9C59Y5nBnm6FMntBWtwGFwAYdO8OJpu0wxojSDE5dXmUOhwHMjjBJMYBB
         Hl3Q==
X-Received: by 10.43.55.84 with SMTP id vx20mr2692250icb.62.1423658002886;
 Wed, 11 Feb 2015 04:33:22 -0800 (PST)
Received: by 10.36.40.16 with HTTP; Wed, 11 Feb 2015 04:33:22 -0800 (PST)
In-Reply-To: <CAFOYHZADerTE88KudrH7LTi3yX4Sg1vJe3Xj0vJH+DNeO6NOEw@mail.gmail.com>
X-Google-Sender-Auth: y8RCmCSnGpSX48QBCt_1T_Ooqs8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263674>

Pushing over http and https are unaffected..  My linux nas died, so on
rebuild I tried to do the ssh thing, and realized quite soon that
things weren't right.

As far as other uses of ssh, I don't know, I use putty frequently, but
I am not clear if it is using the same libraries or not.

I hunted around for the bugreport email on mysgit but couldn't seem to
find it.  It seems in the foggy recesses I remember reading about an
ssh issue with windows, but can't find it now.

On Wed, Feb 11, 2015 at 3:56 AM, Chris Packham <judge.packham@gmail.com> wrote:
> Hi Erik,
>
> On Tue, Feb 10, 2015 at 9:12 AM,  <erik@aercon.net> wrote:
>>
>> I find that preview 1.8 is bluescreening on about 1 of 3 ssh pushes.  1.9
>> preview 12-17-2014 doesn't even bluescreen, the windows gui locks until
>> reset.
>
> Does this mean that pushing over git:// file:// and http:// are
> unaffected? Can you successfully do other (non-git) things over ssh?
>
>>
>> Sample command:
>> git push omv master\r
>>
>> config. =
>>
>> [core]
>>         repositoryformatversion = 0
>>         filemode = false
>>         bare = false
>>         logallrefupdates = true
>>         symlinks = false
>>         ignorecase = true
>>         hideDotFiles = dotGitOnly
>> [remote "omv"]
>>         url = gitpush@192.168.0.100:/git-repos/HexEncrypter
>>         fetch = +refs/heads/*:refs/remotes/omv/*
>>
>
> You might get a more helpful response out of the msysgit folks (I've
> added them to the Cc list).
