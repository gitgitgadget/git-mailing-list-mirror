From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [PATCH] Provide a window icon on Windows platforms
Date: Thu, 31 Dec 2009 23:47:04 +0000
Message-ID: <a5b261830912311547n37c113avcc5089bd15c17bbe@mail.gmail.com>
References: <1262289470-4208-1-git-send-email-kirillathome@gmail.com>
	 <a5b261830912311312if3d71aax5bb693a907dc5c0f@mail.gmail.com>
	 <000701ca8a6a$7c002070$74006150$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Kirill <kirillathome@gmail.com>
X-From: 3-zc9SwkOB7sqbuuipzuthpphmfnbjm.dpnntzthjuhpphmfhspvqt.dpn@listserv.bounces.google.com Fri Jan 01 00:47:25 2010
Return-path: <3-zc9SwkOB7sqbuuipzuthpphmfnbjm.dpnntzthjuhpphmfhspvqt.dpn@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQUjl-0001Zi-JN
	for gcvm-msysgit@m.gmane.org; Fri, 01 Jan 2010 00:47:25 +0100
Received: by yxe1 with SMTP id 1sf31041334yxe.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 31 Dec 2009 15:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:in-reply-to
         :references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        bh=VM6OWdqiF4DZHsLNfg1E9Qt/xi4b6sS1iRpfcAazvAw=;
        b=p7Hpla59n5/7BwQe1au+2OstbFH9GGMdKgxSZAUuMz/FqtJnEdu63PB8KLQzg4DnhE
         BRlLbfgLnnYw9pQ2UElEEgxWSvk+YaoXo9Fljd2LRlNAU4Tr6oBZvlUnIZJ8gs73nwCx
         fvexKD3K4k4Z2MeHx3GZ0rkgWQP90QVcuNUKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        b=JPdk08JGtt83Ty59JV7dAuMgjisK3dfON2JDucDsqChGR8ndB5wPS5lDhTWQtlKMkK
         bvCbcHDcp9JaGtfHt+w1QoTLAaiQG8ivtwMCRguuD0M2vay7I9DS7on+ZxJPA/K90nIT
         tnBrokkYyWf85dXLaQH46fwsbipQC2456AHzo=
Received: by 10.101.151.25 with SMTP id d25mr1630700ano.40.1262303227252;
        Thu, 31 Dec 2009 15:47:07 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.62.209 with SMTP id y17ls779931ebh.1.p; Thu, 31 Dec 2009 
	15:47:06 -0800 (PST)
Received: by 10.213.41.82 with SMTP id n18mr992406ebe.25.1262303225861;
        Thu, 31 Dec 2009 15:47:05 -0800 (PST)
Received: by 10.213.41.82 with SMTP id n18mr992405ebe.25.1262303225838;
        Thu, 31 Dec 2009 15:47:05 -0800 (PST)
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com [209.85.219.220])
        by gmr-mx.google.com with ESMTP id 17si2002843ewy.15.2009.12.31.15.47.04;
        Thu, 31 Dec 2009 15:47:04 -0800 (PST)
Received-SPF: pass (google.com: domain of patthoyts@googlemail.com designates 209.85.219.220 as permitted sender) client-ip=209.85.219.220;
Received: by mail-ew0-f220.google.com with SMTP id 20so1330512ewy.0
        for <msysgit@googlegroups.com>; Thu, 31 Dec 2009 15:47:04 -0800 (PST)
Received: by 10.213.100.156 with SMTP id y28mr4309847ebn.68.1262303224689; 
	Thu, 31 Dec 2009 15:47:04 -0800 (PST)
In-Reply-To: <000701ca8a6a$7c002070$74006150$@com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of patthoyts@googlemail.com designates 209.85.219.220 as permitted 
	sender) smtp.mail=patthoyts@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: patthoyts@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/80f1c5d3df016c97
X-Message-Url: http://groups.google.com/group/msysgit/msg/46357ebc70d8f6a3
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135983>

2009/12/31 Kirill <kirillathome@gmail.com>:
> Unfortunately, I have to insist on my patch :)
>
>> -----Original Message-----
>> From: Pat Thoyts [mailto:patthoyts@googlemail.com]
>> Sent: Thursday, December 31, 2009 4:12 PM
>
>> 2009/12/31 Kirill <kirillathome@gmail.com>:
>> > Looks like 37871b73 by Giuseppe Bilotta does not work very well on
>> > Windows. Instead of a former tcl/tk icon, the window has a black
>> > square as an icon.
>>
>> I've been using versions of gitk on Windows with that patch since it
>> was applied in March and it has been fine. On Windows XP and Windows
>> 7. So there is more to this than you are telling. Are you using
>> windows via remote desktop?
> You're absolutely right about *unintentional* withdrawal of facts in my o=
riginal message, but no, I'm not using Remote Desktop. However, my XP SP3 h=
as 16-bit colors and apparently 8.5.7 can't display those photos correctly =
in this case either. Most probable reason why the issue was first discovere=
d in Remote Desktop is because most of RDP sessions are limited to 16-bit c=
olors.
>
>> If so, this requires an updated Tk and not a patch to gitk -
>> tk 8.5.8 should be ok if this is the problem.
> Unfortunately, the situation is improved with 8.5.8, but definitely not r=
esolved (tested on msysGit devel branch). The sequence image create photo &=
& wm iconphoto on 16-bit displays in XP SP3 renders the background black, n=
ot transparent. The fact that I'm using Classic color schema may play some =
role too. I'd speculate that 8.5.8 on Windows 7 (admittedly, it's much hard=
er to switch to 16-bit colors there) may have exactly the same issue, given=
 that 8.5.7 has exactly the same symptoms.

No - it will be the use of 16bit color. Classic gets used a lot, 16
bit colour - well, you might be the only one now so such a system has
limited testing.

>
> Is there a way to replace the "simplistic"
>
> if {$::tcl_platform(platform) eq {windows}}
>
> with something more elaborate that takes into account 16-bit colors?

That is better done using 'if {[tk windowingsystem] eq "win32"}
{...}'. The windowingsystem command is preferred over platform because
they are not always equivalent (for instance, MacOSX may use either
x11 or aqua).
To test the colour-depth there is [winfo depth .] which returns 16
when using the 16bit color on XP and 32 on Win7 with full color.

Pat Thoyts
