From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Windows Bluescreen
Date: Thu, 12 Feb 2015 22:33:18 +1300
Message-ID: <CAFOYHZAMv5BEmDXGSoo53iSwCYLdhOcM7dHwCMidZBaJh0xmUQ@mail.gmail.com>
References: <20150209201218.Horde.w9pQrdbL-Mf8IdgtaJtVuQ9@server.aercontechnologies.net>
	<CAFOYHZADerTE88KudrH7LTi3yX4Sg1vJe3Xj0vJH+DNeO6NOEw@mail.gmail.com>
	<CAEuupitA4PHBByLLcqc5pVbn1C+ZyQ6Vzbk-LsOjseOEHhkENw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>, msysgit@googlegroups.com
To: Erik Friesen <erik@aercon.net>
X-From: msysgit+bncBCL33DMYQAARBXXG6GTAKGQEFNIB6AY@googlegroups.com Thu Feb 12 10:33:20 2015
Return-path: <msysgit+bncBCL33DMYQAARBXXG6GTAKGQEFNIB6AY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f191.google.com ([209.85.220.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL33DMYQAARBXXG6GTAKGQEFNIB6AY@googlegroups.com>)
	id 1YLq99-0007Q0-Vc
	for gcvm-msysgit@m.gmane.org; Thu, 12 Feb 2015 10:33:20 +0100
Received: by mail-vc0-f191.google.com with SMTP id kv7sf2345421vcb.8
        for <gcvm-msysgit@m.gmane.org>; Thu, 12 Feb 2015 01:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=qcVYXVwJtB1bPWNXjrTt1t/NAeEIqtGwdiZAlghXSwY=;
        b=HOMbGRl7FaoFbu7vfYQlBnbf6RDaPY2uILs8jIZfz1vRnFV7gHCPWi1n4g50Fk+/PD
         /lANVJhePzWWUPj1lRP3tcAY3mnza8FZTt//3gi+KUwm8bp3AvQtV2NajslrHKDsUqTL
         pEOupyl7O5ozukkX67Z/Bgn20bVM1RDuSPYh+jqsE3X3S8SAMJ8iwU7hPREZTrFoD29t
         Fh8PGWogML6Yov/NKFVky/GWqX/xnTvmN155T0zF0DgVFffyt3Bmu6PP4hGpr1THCqtF
         7UNdX7wzrqDdKn6sWrCbyDg/NshvwrFXPtRL+GOQs4xc894mLTIZTLpZYTfXpgNBmWTq
         bf+w==
X-Received: by 10.50.129.98 with SMTP id nv2mr46784igb.1.1423733599303;
        Thu, 12 Feb 2015 01:33:19 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.17.207 with SMTP id 76ls461640ior.66.gmail; Thu, 12 Feb
 2015 01:33:18 -0800 (PST)
X-Received: by 10.43.144.81 with SMTP id jp17mr6455946icc.25.1423733598791;
        Thu, 12 Feb 2015 01:33:18 -0800 (PST)
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com. [209.85.192.181])
        by gmr-mx.google.com with ESMTPS id bo1si382136pbc.0.2015.02.12.01.33.18
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2015 01:33:18 -0800 (PST)
Received-SPF: pass (google.com: domain of judge.packham@gmail.com designates 209.85.192.181 as permitted sender) client-ip=209.85.192.181;
Received: by pdbfl12 with SMTP id fl12so10813101pdb.4
        for <msysgit@googlegroups.com>; Thu, 12 Feb 2015 01:33:18 -0800 (PST)
X-Received: by 10.66.221.135 with SMTP id qe7mr5220204pac.6.1423733598560;
 Thu, 12 Feb 2015 01:33:18 -0800 (PST)
Received: by 10.70.87.100 with HTTP; Thu, 12 Feb 2015 01:33:18 -0800 (PST)
In-Reply-To: <CAEuupitA4PHBByLLcqc5pVbn1C+ZyQ6Vzbk-LsOjseOEHhkENw@mail.gmail.com>
X-Original-Sender: judge.packham@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of judge.packham@gmail.com designates 209.85.192.181 as
 permitted sender) smtp.mail=judge.packham@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263710>

On Thu, Feb 12, 2015 at 1:33 AM, Erik Friesen <erik@aercon.net> wrote:
> Pushing over http and https are unaffected..  My linux nas died, so on
> rebuild I tried to do the ssh thing, and realized quite soon that
> things weren't right.
>
> As far as other uses of ssh, I don't know, I use putty frequently, but
> I am not clear if it is using the same libraries or not.

I think putty ships it's own ssh implementation rather than using an
openSSH port.

> I hunted around for the bugreport email on mysgit but couldn't seem to
> find it.  It seems in the foggy recesses I remember reading about an
> ssh issue with windows, but can't find it now.
>

https://github.com/msysgit/git/issues

Happy hunting :). Actually if it is a ssh problem it might be a
generic MSYS issue. So there's another bug tracker to look through

http://sourceforge.net/p/mingw/bugs/


> On Wed, Feb 11, 2015 at 3:56 AM, Chris Packham <judge.packham@gmail.com> wrote:
>> Hi Erik,
>>
>> On Tue, Feb 10, 2015 at 9:12 AM,  <erik@aercon.net> wrote:
>>>
>>> I find that preview 1.8 is bluescreening on about 1 of 3 ssh pushes.  1.9
>>> preview 12-17-2014 doesn't even bluescreen, the windows gui locks until
>>> reset.
>>
>> Does this mean that pushing over git:// file:// and http:// are
>> unaffected? Can you successfully do other (non-git) things over ssh?
>>
>>>
>>> Sample command:
>>> git push omv master\r
>>>
>>> config. =
>>>
>>> [core]
>>>         repositoryformatversion = 0
>>>         filemode = false
>>>         bare = false
>>>         logallrefupdates = true
>>>         symlinks = false
>>>         ignorecase = true
>>>         hideDotFiles = dotGitOnly
>>> [remote "omv"]
>>>         url = gitpush@192.168.0.100:/git-repos/HexEncrypter
>>>         fetch = +refs/heads/*:refs/remotes/omv/*
>>>
>>
>> You might get a more helpful response out of the msysgit folks (I've
>> added them to the Cc list).

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
