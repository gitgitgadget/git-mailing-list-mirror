From: Erik Friesen <erik@aercon.net>
Subject: Re: Re: Windows Bluescreen
Date: Thu, 12 Feb 2015 08:21:38 -0500
Message-ID: <CAEuupivCDfpJrT+T921CpMg-+tCnMBZ8x=1uNgKJbcJyX0vGWw@mail.gmail.com>
References: <20150209201218.Horde.w9pQrdbL-Mf8IdgtaJtVuQ9@server.aercontechnologies.net>
	<CAFOYHZADerTE88KudrH7LTi3yX4Sg1vJe3Xj0vJH+DNeO6NOEw@mail.gmail.com>
	<CAEuupitA4PHBByLLcqc5pVbn1C+ZyQ6Vzbk-LsOjseOEHhkENw@mail.gmail.com>
	<CAFOYHZAMv5BEmDXGSoo53iSwCYLdhOcM7dHwCMidZBaJh0xmUQ@mail.gmail.com>
	<CAEuupiuv=gRnnZm1C75dx35nC=sXR1Hb_PzLXzAKHwaD7kYsXA@mail.gmail.com>
	<1423744959.10453.3.camel@thomas-debian-x64>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>, 
	msysgit@googlegroups.com
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: msysgit+bncBCVNFAEEFQIOFUPSUYCRUBD4PCYUE@googlegroups.com Thu Feb 12 14:21:41 2015
Return-path: <msysgit+bncBCVNFAEEFQIOFUPSUYCRUBD4PCYUE@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f55.google.com ([209.85.216.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCVNFAEEFQIOFUPSUYCRUBD4PCYUE@googlegroups.com>)
	id 1YLti7-0008B5-SZ
	for gcvm-msysgit@m.gmane.org; Thu, 12 Feb 2015 14:21:40 +0100
Received: by mail-qa0-f55.google.com with SMTP id i13sf2609474qae.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 12 Feb 2015 05:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:list-subscribe:list-unsubscribe;
        bh=5+GOM7X4NnSTYsvkKDRvuRqQOrApdhCoBDAXtkz57Kw=;
        b=yYrnDCG2JwK4243mbBEzyPgkfpqI1HNPc/FyH9htffjlajHmbMGDtLb/h91+bIGL0/
         5fclJts3hRbk3UP7BLkae/fOO7foPqHhpQ3YUUszaLyxye0jg71GS9/QAGKJdJhsv2tY
         B+IF4B6nINim709EyJg02vE7jyiRWlcbTQOk9iI1doDJ2nnWcOATwAEzuUbpbvOAYXHM
         1Q9FCSlLsWr1FGUg2TjtY6szPLC/PwhWuvo2nCjtfCXv7KGDwA1IbRFNaTxyJeXqiD1l
         ifjGYQyI/TYDhKhrjpVYo2pb4VMUpH8/BRFOwcboBerswE99pUo6bruMI3hs+sqwbUtR
         Sdpw==
X-Received: by 10.50.128.202 with SMTP id nq10mr61206igb.12.1423747299282;
        Thu, 12 Feb 2015 05:21:39 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.17.207 with SMTP id 76ls504886ior.66.gmail; Thu, 12 Feb
 2015 05:21:38 -0800 (PST)
X-Received: by 10.68.245.72 with SMTP id xm8mr3699987pbc.4.1423747298737;
        Thu, 12 Feb 2015 05:21:38 -0800 (PST)
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com. [209.85.223.180])
        by gmr-mx.google.com with ESMTPS id mg3si133099igb.0.2015.02.12.05.21.38
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2015 05:21:38 -0800 (PST)
Received-SPF: pass (google.com: domain of friesendrywall@gmail.com designates 209.85.223.180 as permitted sender) client-ip=209.85.223.180;
Received: by mail-ie0-f180.google.com with SMTP id tr6so1043779ieb.10
        for <msysgit@googlegroups.com>; Thu, 12 Feb 2015 05:21:38 -0800 (PST)
X-Received: by 10.43.89.136 with SMTP id be8mr8182641icc.57.1423747298582;
 Thu, 12 Feb 2015 05:21:38 -0800 (PST)
Sender: msysgit@googlegroups.com
Received: by 10.36.40.16 with HTTP; Thu, 12 Feb 2015 05:21:38 -0800 (PST)
In-Reply-To: <1423744959.10453.3.camel@thomas-debian-x64>
X-Original-Sender: erik@aercon.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of friesendrywall@gmail.com designates 209.85.223.180 as
 permitted sender) smtp.mail=friesendrywall@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263738>

Sorry, I don't know what this TOP posting problem is, and hitting
reply only replies to the last sender.   If you prefer, and you have
some regular bugtracker, I could use that instead of email posting.

To repro-
Set up git user on local linux repo, in my case 192.168.0.100

On a windows 7 64bit machine-
$ cd myproject
$ git init
$ git add .
$ git commit -m 'initial commit'
$ git remote add origin git@192.168.0.100:/opt/git/project.git
$ git push origin master
(Shamelessly copied from git page)

Problem happens after entering password, it may or may not get started.

The nature of a bluescreen doesn't make debugging and reproduction
real easy.  If it helps, I can get the dumps from those crashes.  To
move on, I moved back to local http pushes.

On Thu, Feb 12, 2015 at 7:42 AM, Thomas Braun
<thomas.braun@virtuell-zuhause.de> wrote:
> Am Donnerstag, den 12.02.2015, 07:21 -0500 schrieb Erik Friesen:
>> I'd say this is related.  http://sourceforge.net/p/mingw/bugs/2240/
>>
>> There isn't much hope, that was filed months ago with no action.  I
>> suggest moving to another ssh library perhaps?  Anyways, this is a
>> windows git bug report, so it really needs to stay with mysgit in my
>> opinion.
>>
>> I'd say it should reproduce without much effort.  Do a git push using
>> win7 64 pro or similar, I'd say it will have issues.
>>
>> At minimum, this should be on the list for others to view.  I have run
>> across problems from others, but I don't think they realized it could
>> be an ssh problem.
>
> (Please don't TOP post)
>
> The cited bug report does not correlate to msysgit as we compile and
> ship our own openssh.
>
> Git for Windows Version 1.8.x might still have the old and slow openssh.
> With the newest version I get speeds of up to 30MB/s over Gigabit LAN.
>
> Can you create a minimal test case to reprocude the problem?
>

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
