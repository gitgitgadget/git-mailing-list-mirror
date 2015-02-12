From: Erik Friesen <erik@aercon.net>
Subject: Re: Windows Bluescreen
Date: Thu, 12 Feb 2015 07:21:33 -0500
Message-ID: <CAEuupiuv=gRnnZm1C75dx35nC=sXR1Hb_PzLXzAKHwaD7kYsXA@mail.gmail.com>
References: <20150209201218.Horde.w9pQrdbL-Mf8IdgtaJtVuQ9@server.aercontechnologies.net>
	<CAFOYHZADerTE88KudrH7LTi3yX4Sg1vJe3Xj0vJH+DNeO6NOEw@mail.gmail.com>
	<CAEuupitA4PHBByLLcqc5pVbn1C+ZyQ6Vzbk-LsOjseOEHhkENw@mail.gmail.com>
	<CAFOYHZAMv5BEmDXGSoo53iSwCYLdhOcM7dHwCMidZBaJh0xmUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>, msysgit@googlegroups.com
To: Chris Packham <judge.packham@gmail.com>
X-From: msysgit+bncBCVNFAEEFQIM5NPSUYCRUBH4O4I4W@googlegroups.com Thu Feb 12 13:21:36 2015
Return-path: <msysgit+bncBCVNFAEEFQIM5NPSUYCRUBH4O4I4W@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f189.google.com ([209.85.220.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCVNFAEEFQIM5NPSUYCRUBH4O4I4W@googlegroups.com>)
	id 1YLslz-00039Y-Fo
	for gcvm-msysgit@m.gmane.org; Thu, 12 Feb 2015 13:21:35 +0100
Received: by mail-vc0-f189.google.com with SMTP id im6sf2558936vcb.6
        for <gcvm-msysgit@m.gmane.org>; Thu, 12 Feb 2015 04:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:list-subscribe:list-unsubscribe;
        bh=uSu/eCBU12bl1h3kpZ6opp5o5u0AFGmOBmk93CZeR04=;
        b=hodd7+8/lZFxJDwhJu0wtGUmgMqTctelq5P5s7RN9or/AnvVVQ7MkLeT5T4mhc1aL9
         LJc0dRKs0/YLnKhf/cDqQ1w/q3PR4HM0rBUOPISrbeuR/QW1PNmX7UAFKNQV9bN3QS2/
         PTMvo/+GLgApDm3jaLAFF9CxPCUW/ANQISSkxZC3UvgBxkiRej9DLNzmkumtM2rqn+oD
         NjcVvYqP5C1jSO6zelKlVo6cr16yk0VvSiASSKPL/RecjUI/IEN2DlXedaibvftz612o
         Hokmm8snBucJ8EBvaLY6PPCebtCJ05yHrexV9/DG7NHM8015QEzgUgrI8gLInH5M4lwV
         zuww==
X-Received: by 10.50.43.228 with SMTP id z4mr57417igl.4.1423743694827;
        Thu, 12 Feb 2015 04:21:34 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.20.161 with SMTP id o1ls195629ige.18.canary; Thu, 12 Feb
 2015 04:21:34 -0800 (PST)
X-Received: by 10.66.190.229 with SMTP id gt5mr3401580pac.27.1423743694257;
        Thu, 12 Feb 2015 04:21:34 -0800 (PST)
Received: from mail-ig0-x233.google.com (mail-ig0-x233.google.com. [2607:f8b0:4001:c05::233])
        by gmr-mx.google.com with ESMTPS id ux1si135283igb.1.2015.02.12.04.21.34
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2015 04:21:34 -0800 (PST)
Received-SPF: pass (google.com: domain of friesendrywall@gmail.com designates 2607:f8b0:4001:c05::233 as permitted sender) client-ip=2607:f8b0:4001:c05::233;
Received: by mail-ig0-x233.google.com with SMTP id l13so3255785iga.0
        for <msysgit@googlegroups.com>; Thu, 12 Feb 2015 04:21:34 -0800 (PST)
X-Received: by 10.50.111.168 with SMTP id ij8mr3363151igb.43.1423743693966;
 Thu, 12 Feb 2015 04:21:33 -0800 (PST)
Sender: msysgit@googlegroups.com
Received: by 10.36.40.16 with HTTP; Thu, 12 Feb 2015 04:21:33 -0800 (PST)
In-Reply-To: <CAFOYHZAMv5BEmDXGSoo53iSwCYLdhOcM7dHwCMidZBaJh0xmUQ@mail.gmail.com>
X-Original-Sender: erik@aercon.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of friesendrywall@gmail.com designates
 2607:f8b0:4001:c05::233 as permitted sender) smtp.mail=friesendrywall@gmail.com;
       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263733>

I'd say this is related.  http://sourceforge.net/p/mingw/bugs/2240/

There isn't much hope, that was filed months ago with no action.  I
suggest moving to another ssh library perhaps?  Anyways, this is a
windows git bug report, so it really needs to stay with mysgit in my
opinion.

I'd say it should reproduce without much effort.  Do a git push using
win7 64 pro or similar, I'd say it will have issues.

At minimum, this should be on the list for others to view.  I have run
across problems from others, but I don't think they realized it could
be an ssh problem.

On Thu, Feb 12, 2015 at 4:33 AM, Chris Packham <judge.packham@gmail.com> wrote:
> On Thu, Feb 12, 2015 at 1:33 AM, Erik Friesen <erik@aercon.net> wrote:
>> Pushing over http and https are unaffected..  My linux nas died, so on
>> rebuild I tried to do the ssh thing, and realized quite soon that
>> things weren't right.
>>
>> As far as other uses of ssh, I don't know, I use putty frequently, but
>> I am not clear if it is using the same libraries or not.
>
> I think putty ships it's own ssh implementation rather than using an
> openSSH port.
>
>> I hunted around for the bugreport email on mysgit but couldn't seem to
>> find it.  It seems in the foggy recesses I remember reading about an
>> ssh issue with windows, but can't find it now.
>>
>
> https://github.com/msysgit/git/issues
>
> Happy hunting :). Actually if it is a ssh problem it might be a
> generic MSYS issue. So there's another bug tracker to look through
>
> http://sourceforge.net/p/mingw/bugs/
>
>
>> On Wed, Feb 11, 2015 at 3:56 AM, Chris Packham <judge.packham@gmail.com> wrote:
>>> Hi Erik,
>>>
>>> On Tue, Feb 10, 2015 at 9:12 AM,  <erik@aercon.net> wrote:
>>>>
>>>> I find that preview 1.8 is bluescreening on about 1 of 3 ssh pushes.  1.9
>>>> preview 12-17-2014 doesn't even bluescreen, the windows gui locks until
>>>> reset.
>>>
>>> Does this mean that pushing over git:// file:// and http:// are
>>> unaffected? Can you successfully do other (non-git) things over ssh?
>>>
>>>>
>>>> Sample command:
>>>> git push omv master\r
>>>>
>>>> config. =
>>>>
>>>> [core]
>>>>         repositoryformatversion = 0
>>>>         filemode = false
>>>>         bare = false
>>>>         logallrefupdates = true
>>>>         symlinks = false
>>>>         ignorecase = true
>>>>         hideDotFiles = dotGitOnly
>>>> [remote "omv"]
>>>>         url = gitpush@192.168.0.100:/git-repos/HexEncrypter
>>>>         fetch = +refs/heads/*:refs/remotes/omv/*
>>>>
>>>
>>> You might get a more helpful response out of the msysgit folks (I've
>>> added them to the Cc list).

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
