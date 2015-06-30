From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: 4th release candidate of Git for Windows 2.x, was Re:
 3rd release candidate of Git for Windows 2.x
Date: Tue, 30 Jun 2015 20:57:59 +0200
Message-ID: <5592E6B7.10201@virtuell-zuhause.de>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>	<b085dab2e617742b690ccb99ba4a3076@www.dscho.org>	<8224736a18724f751312d57e67967d69@www.dscho.org>	<55910AE7.3000206@atlas-elektronik.com>	<426859781bd04ca4ebb13719350537ed@www.dscho.org>	<20150629185430.5dfbab069b5dbdf32398d290@domain007.com>	<2abf219bf0235717eaa84889f94eb03c@www.dscho.org> <20150630201523.3a00a2afe9321fb28a6fc82d@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?windows-1252?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>, 
 Git Mailing List <git@vger.kernel.org>,
 msysgit@googlegroups.com, git-for-windows@googlegroups.com
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>, 
 Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: msysgit+bncBCL7JHHTPAILTTOLVQCRUBFF5DEJU@googlegroups.com Tue Jun 30 20:58:02 2015
Return-path: <msysgit+bncBCL7JHHTPAILTTOLVQCRUBFF5DEJU@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f60.google.com ([74.125.82.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAILTTOLVQCRUBFF5DEJU@googlegroups.com>)
	id 1ZA0jK-00054y-LX
	for gcvm-msysgit@m.gmane.org; Tue, 30 Jun 2015 20:58:02 +0200
Received: by wggx12 with SMTP id x12sf8678676wgg.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Jun 2015 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=4XSjzFubRv/Z6nkTUS3KJfE4fQu8b9BQKeOUhBbXpQA=;
        b=V+faXNVjZlG7bkYNPWVt7fV1Zofaw/qs2cK4A5kYgSqHUJESMji7HwzsLuhoKJwA0Q
         uMXqlz/K7e+yZem93S+X8rZDQ98pN2OLozirHCo5taU+GTf+NLYxnPkiHlgG0oIDCeyQ
         PtL3UjZG/qFqYbiBshpAwLxLmu09alHQeAQN2H0aUo6BLr5ylV6j6LKbWkyRritDVExX
         bOcYmcVXKSDg97SsQVjVtGAcs/Xu7uKDKqbcIis7/uWFSuTomZJ8HSzCF1QR9Lvs0mqL
         bht3RizAdXAe/xTOctqsIiSi339vJ1U37bN7aNDnMV6Xr0P0CyoMDOJ/TXwyBtXHdcfW
         uG9Q==
X-Received: by 10.152.5.3 with SMTP id o3mr204372lao.2.1435690682022;
        Tue, 30 Jun 2015 11:58:02 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.36.34 with SMTP id n2ls83108laj.15.gmail; Tue, 30 Jun 2015
 11:58:01 -0700 (PDT)
X-Received: by 10.152.22.71 with SMTP id b7mr14822499laf.3.1435690681169;
        Tue, 30 Jun 2015 11:58:01 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [80.237.132.163])
        by gmr-mx.google.com with ESMTPS id eo3si640508wib.0.2015.06.30.11.58.01
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 11:58:01 -0700 (PDT)
Received-SPF: neutral (google.com: 80.237.132.163 is neither permitted nor denied by best guess record for domain of thomas.braun@virtuell-zuhause.de) client-ip=80.237.132.163;
Received: from p5dd6fcbd.dip0.t-ipconnect.de ([93.214.252.189] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1ZA0jI-00042P-Cd; Tue, 30 Jun 2015 20:58:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150630201523.3a00a2afe9321fb28a6fc82d@domain007.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1435690681;3763cf8f;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 80.237.132.163 is neither permitted nor denied by best guess
 record for domain of thomas.braun@virtuell-zuhause.de) smtp.mail=thomas.braun@virtuell-zuhause.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273096>

Am 30.06.2015 um 19:15 schrieb Konstantin Khomoutov:
> On Mon, 29 Jun 2015 18:19:09 +0200
> Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> 
>>> I've finally took time to switch from my old "msys1" release to this
>>> RC4, and immediately got hit by the fact Git is now speaking to me
>>> in Russian, which is not what I want (previously this behaviour was
>>> only exhibited by `git gui` and `gitk`).
>>>
>>> Should I make Git see LC_MESSAGES=en (or other thing like LANG) in
>>> the environment or is there some Git-local method to affect this
>>> behaviour? I tried to grep the release notes using relevant
>>> keywords but was left empty-handed.
>>
>> Personally, I would use LC_ALL=C. Maybe that's good for you, too?
> 
> After reading [1], I've ended up installing LANG=C into my user's
> environment variables -- so far so good, thanks for the tip!

Just for the record.
I created the file lang.sh with contents
export LC_ALL=C
in
/etc/profile.d
which also fixes the problem. And also survives new versions of git.

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
