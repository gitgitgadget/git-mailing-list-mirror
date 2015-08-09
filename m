From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] config.mak.uname: Cygwin: Use renames for creation
Date: Sun, 09 Aug 2015 18:05:00 +0100
Message-ID: <55C7883C.7040504@dinwoodie.org>
References: <1438979428-5888-1-git-send-email-adam@dinwoodie.org> <55C66AF2.3060706@gmail.com> <20150808210627.GB155450@vauxhall.crustytoothpaste.net> <CA+kUOa=KRBSKDqWUj2RiO45PqVYGmN+yqG426jtUoXayxGkduw@mail.gmail.com> <058a7756ada2fa5043ca9b910d6e1543@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 09 19:05:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOU2S-0003xY-KU
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 19:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933105AbbHIRFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 13:05:16 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38174 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933082AbbHIRFO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 13:05:14 -0400
Received: by wibxm9 with SMTP id xm9so122139632wib.1
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=roWTrOM9f2Q0RMqqG1ylgzv7WlMDSj+v2qCojuJOLqM=;
        b=sMMzA+m5+k6cdGa8T/Cfp/onex58JbVQDbFCZydPzIFwIVyOPTAo6eijcv6LwL0sV6
         Dzm3yaXQjWhw8SX41KHn4YU9KsidXZwB6/QhA8LAdmqd6FeUD6lgYavVRT99Kn5AI1sP
         Q3hbbPw2MTE8qjqDhU2N0myYRw6HErxOkNQ2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=roWTrOM9f2Q0RMqqG1ylgzv7WlMDSj+v2qCojuJOLqM=;
        b=AuTUGKg21gP6OCvvm3BMNO+N4jwNoh+gu9U38G8a4LD3BgCH2nOYKb50BeSmdWoSXB
         0CeD86k/3hqEfEWY0M93hHkCJynERm48joYFeru1y4Mugcwj+1W45KkWNBt1Jb9Ba0Kj
         8wLKUbtaF7k+Hc1puTBvf9PEp5ZO5G67yO8K89XUGQhgwkei01QAZ1qZgIjoEBzrgOH+
         UmYOinC22QEFNov0Dq53rRuJ7GPNvT0dZIEYyYt2G0yl7ymlmjnCm3/hTkP8cqqwm+qD
         E9UGU3v5r7+G4KkRKguM//4e04wFth/BdmD5mC7M+hCC3vAjS1AdsgZbiXVX28mV1YB9
         nERQ==
X-Gm-Message-State: ALoCoQm9f8UE4sXd6/rVDw1j3x6xqP1qyGn4QBlcLyB70It0Mbqa+3IsI3M4WcQuRPOSM8Ak8LAR
X-Received: by 10.180.99.193 with SMTP id es1mr10416265wib.29.1439139913081;
        Sun, 09 Aug 2015 10:05:13 -0700 (PDT)
Received: from Adams-Air.default ([95.147.88.49])
        by smtp.gmail.com with ESMTPSA id bu12sm25168379wjb.44.2015.08.09.10.05.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2015 10:05:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <058a7756ada2fa5043ca9b910d6e1543@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275552>

On 09/08/2015 10:01, Johannes Schindelin wrote:
> On 2015-08-09 04:01, Adam Dinwoodie wrote:
>> I do not see any difference between the situation here and the situation
>> for MinGW, which is fundamentally a Cygwin fork, but which already has
>> this build option set for it in config.mak.uname.
> This is incorrect. MinGW is distinctly *not* a Cygwin fork. MinGW means "Minimal GNU on Windows" and that in turn means that it provides an environment to build executables that purely use the Win32 API. Read: no POSIX emulation whatsoever. Most notably, MinGW programs cannot use fork(2); It is simply unavailable.
>
> What you *probably* meant is that Git for Windows relies on MSys2 for its shell and Perl scripts, and that MSys2 in turn is a fork of Cygwin. That affects *only* the scripts, though; Git itself (as in `git.exe`) is still a pure MinGW program (and as a consequence, is quite a bit faster than Cygwin Git, at the price of certain quirks that Cygwin Git does not suffer).

You're quite right; I'd misread the MinGW page. Thank you for pointing 
that out :)

>>> We've gotten a lot of users on the list who ask why their Git
>>> directories on shared drives aren't working (or are broken in some way).
>>> Since I don't use Windows, let me ask: does the Cygwin DLL handle
>>> link(2) properly on shared drives, and if not, would this patch help it
>>> do so?  I can imagine that perhaps SMB doesn't support the necessary
>>> operations to make a POSIX link(2) work properly.
>> I'd need to go back to the Cygwin list to get a definite answer, but as
>> I understand it, yes, this is is exactly the problem -- quoting Corinna,
>> one of the Cygwin project leads, "The MS NFS is not very reliable in
>> keeping up with changes to metadata."
>>
>> We have verified that setting `core.createobject rename` resolves the
>> problem for people who are seeing it, which very strongly implies that
>> this build option would solve the problem similarly, but would fix it
>> for all users, not just those who spend enough time investigating the
>> problem to find that setting.
>  From my experience, it appears that providing Corinna Vinschen (or better put: the Cygwin developers in general) with a sound patch gets things fixed pretty timely.
>
> And since `core.createObject = rename` seems to work around the problem, it should be possible to patch the Cygwin runtime accordingly. Sure, it will take a little investigation *what* code should be changed, and how, but the obvious benefit to *all* Cygwin applications should make that effort worth your while.

Hmm. I'm not sure what a Cygwin fix would look like here. As I 
understand it, using link(2) will fail if the target exists, while using 
rename(2) will just clobber a target file.

If the desired goal is that Cygwin's link(2) acts like POSIX link(2) on 
network drives, I'm not convinced that's possible, at least not by 
emulating `core.createObject = rename` in the Cygwin library layer. The 
only implementations I can think of would introduce a window condition 
between checking for the target file's existence and then clobbering it. 
That'd mean the vast majority of the time the Cygwin command would work 
as expected, but there'd be race conditions where occasionally a file 
gets silently clobbered. Intermittent silent bugs seem much worse than 
the command reliably failing.

I think, given that, the current behaviour is preferable: calling link 
just errors out in this scenario, because there's no way to map it down 
to something that reliably acts like the POSIX call. It's then up to 
whatever program is trying to use the call to find an alternative way to 
achieve its desired result, and the consequences of that workaround are 
the responsibility of the calling application.

In short, as I understand it, this is exactly the scenario 
OBJECT_CREATION_USES_RENAMES is intended for.
