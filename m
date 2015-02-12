From: Erik Friesen <erik@aercon.net>
Subject: Re: Windows Bluescreen
Date: Thu, 12 Feb 2015 07:25:38 -0500
Message-ID: <CAEuupisGv4d9ys4J9tpcwAGjzgogSdgxxC7fQHF=-=Y-C9eWJg@mail.gmail.com>
References: <20150209201218.Horde.w9pQrdbL-Mf8IdgtaJtVuQ9@server.aercontechnologies.net>
	<CAFOYHZADerTE88KudrH7LTi3yX4Sg1vJe3Xj0vJH+DNeO6NOEw@mail.gmail.com>
	<CAEuupitA4PHBByLLcqc5pVbn1C+ZyQ6Vzbk-LsOjseOEHhkENw@mail.gmail.com>
	<CAFOYHZAMv5BEmDXGSoo53iSwCYLdhOcM7dHwCMidZBaJh0xmUQ@mail.gmail.com>
	<CAEuupiuv=gRnnZm1C75dx35nC=sXR1Hb_PzLXzAKHwaD7kYsXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>, msysgit@googlegroups.com
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 13:25:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLsq0-0005EZ-FL
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 13:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbbBLMZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 07:25:40 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:37226 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216AbbBLMZj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 07:25:39 -0500
Received: by iecrl12 with SMTP id rl12so8966676iec.4
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 04:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=U/u6fSM9KobgkLVtT0qQAALIBrxYN3bhZsoIB9EPFgw=;
        b=Jd9PT84aJB1ceY+cxaq0qYBdprHMXZgXlEn9qXzMbuBT8rZ3dcBvGmNxkTH6970qun
         emYPpx0PNKYKL4oBXGu56E1WCxf0KiwMSIlg6PBUma4Ykxbdn+FWVCmg9YF/HOwyUka4
         2RZtHS9lKdLOn2Gf0+COZ6Ui6Hap7IhqSUegbth8/TlLO5yP/0hxYNRsKvgPs3QT12wa
         U2Yq7Kgz7Qjy3PbUfZrBAmjJHUZj8QGhq2J3dB+uVKsf89MDgbRL1x9w9x5cuFxDVK17
         XbQzsODD090MbhroxZePujJ9kvyw6FUIcs3S5AvVBowV82ImaDVHsZ68yp12MvD+zpuk
         qpcw==
X-Received: by 10.50.66.212 with SMTP id h20mr3375747igt.43.1423743939026;
 Thu, 12 Feb 2015 04:25:39 -0800 (PST)
Received: by 10.36.40.16 with HTTP; Thu, 12 Feb 2015 04:25:38 -0800 (PST)
In-Reply-To: <CAEuupiuv=gRnnZm1C75dx35nC=sXR1Hb_PzLXzAKHwaD7kYsXA@mail.gmail.com>
X-Google-Sender-Auth: wT_TjQG5YOCUX-r65LxvWjjwe7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263734>

Also, as another nuance of this bug, this destroyed the local repo in
the process, inserting >>>>>> HEAD, ========, <<<<<<<md5hashes, and
doubling up on stuff everywhere.

On Thu, Feb 12, 2015 at 7:21 AM, Erik Friesen <erik@aercon.net> wrote:
> I'd say this is related.  http://sourceforge.net/p/mingw/bugs/2240/
>
> There isn't much hope, that was filed months ago with no action.  I
> suggest moving to another ssh library perhaps?  Anyways, this is a
> windows git bug report, so it really needs to stay with mysgit in my
> opinion.
>
> I'd say it should reproduce without much effort.  Do a git push using
> win7 64 pro or similar, I'd say it will have issues.
>
> At minimum, this should be on the list for others to view.  I have run
> across problems from others, but I don't think they realized it could
> be an ssh problem.
>
> On Thu, Feb 12, 2015 at 4:33 AM, Chris Packham <judge.packham@gmail.com> wrote:
>> On Thu, Feb 12, 2015 at 1:33 AM, Erik Friesen <erik@aercon.net> wrote:
>>> Pushing over http and https are unaffected..  My linux nas died, so on
>>> rebuild I tried to do the ssh thing, and realized quite soon that
>>> things weren't right.
>>>
>>> As far as other uses of ssh, I don't know, I use putty frequently, but
>>> I am not clear if it is using the same libraries or not.
>>
>> I think putty ships it's own ssh implementation rather than using an
>> openSSH port.
>>
>>> I hunted around for the bugreport email on mysgit but couldn't seem to
>>> find it.  It seems in the foggy recesses I remember reading about an
>>> ssh issue with windows, but can't find it now.
>>>
>>
>> https://github.com/msysgit/git/issues
>>
>> Happy hunting :). Actually if it is a ssh problem it might be a
>> generic MSYS issue. So there's another bug tracker to look through
>>
>> http://sourceforge.net/p/mingw/bugs/
>>
>>
>>> On Wed, Feb 11, 2015 at 3:56 AM, Chris Packham <judge.packham@gmail.com> wrote:
>>>> Hi Erik,
>>>>
>>>> On Tue, Feb 10, 2015 at 9:12 AM,  <erik@aercon.net> wrote:
>>>>>
>>>>> I find that preview 1.8 is bluescreening on about 1 of 3 ssh pushes.  1.9
>>>>> preview 12-17-2014 doesn't even bluescreen, the windows gui locks until
>>>>> reset.
>>>>
>>>> Does this mean that pushing over git:// file:// and http:// are
>>>> unaffected? Can you successfully do other (non-git) things over ssh?
>>>>
>>>>>
>>>>> Sample command:
>>>>> git push omv master\r
>>>>>
>>>>> config. =
>>>>>
>>>>> [core]
>>>>>         repositoryformatversion = 0
>>>>>         filemode = false
>>>>>         bare = false
>>>>>         logallrefupdates = true
>>>>>         symlinks = false
>>>>>         ignorecase = true
>>>>>         hideDotFiles = dotGitOnly
>>>>> [remote "omv"]
>>>>>         url = gitpush@192.168.0.100:/git-repos/HexEncrypter
>>>>>         fetch = +refs/heads/*:refs/remotes/omv/*
>>>>>
>>>>
>>>> You might get a more helpful response out of the msysgit folks (I've
>>>> added them to the Cc list).
