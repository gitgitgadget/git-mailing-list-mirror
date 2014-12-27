From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Missing inversion in Makefile (ee9be06)
Date: Sat, 27 Dec 2014 20:17:22 -0000
Organization: OPDS
Message-ID: <4C7BB65E9EE445F08645582230EA9782@PhilipOakley>
References: <E3DB9AD2A8914C379FB3371494B0B816@PhilipOakley> <549F0355.5020805@kdbg.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git MsysGit" <msysgit@googlegroups.com>
To: "Johannes Sixt" <j6t@kdbg.org>,
	"Git List" <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBS5H7SSAKGQEWYUHE4I@googlegroups.com Sat Dec 27 21:17:18 2014
Return-path: <msysgit+bncBDSOTWHYX4PBBS5H7SSAKGQEWYUHE4I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBS5H7SSAKGQEWYUHE4I@googlegroups.com>)
	id 1Y4xnY-0003vc-66
	for gcvm-msysgit@m.gmane.org; Sat, 27 Dec 2014 21:17:16 +0100
Received: by mail-wi0-f185.google.com with SMTP id ex7sf1115273wid.12
        for <gcvm-msysgit@m.gmane.org>; Sat, 27 Dec 2014 12:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=5dyJYRFxKph/6IA/znWP1TIaEsvO24dY7IFQdy/PLhc=;
        b=u2WUjSnft2RUq/Q1hvYvMUB4EBiKBuUVtSG9FOyC82w4ntIO9Kp3QEKESgrE3gpkLk
         7JktRDuyAreNoWlQRIxVW5iPKg/s2yb4GcwTpZWRwAheoue3mKdEm4mdGPIgJ9866KCJ
         3wP7QFk7PNMYdJk4DqcPT2zXivUqUCcjB+195iasWkBxk02zcM5lkUVl3TJPrnuOaKRm
         FU0w4Ms5vvqNBODh3ECofbrgUVqMC3KXfZApNkTRbqcNIn1WE7taElIJeqAG+0J+OTQw
         Pzymi+4NCo4/ABjkHmk2yCO98hGTH65fybuOt/+r4y9bBttAKVEm9joCAwQy94oC1bXh
         tNSQ==
X-Received: by 10.152.37.199 with SMTP id a7mr192lak.13.1419711435825;
        Sat, 27 Dec 2014 12:17:15 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.42.234 with SMTP id r10ls1480695lal.17.gmail; Sat, 27 Dec
 2014 12:17:14 -0800 (PST)
X-Received: by 10.112.137.70 with SMTP id qg6mr3396lbb.14.1419711434599;
        Sat, 27 Dec 2014 12:17:14 -0800 (PST)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id gb6si108715wib.3.2014.12.27.12.17.13
        for <msysgit@googlegroups.com>;
        Sat, 27 Dec 2014 12:17:13 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Am4bAH8Tn1QCYJmQPGdsb2JhbABcgwZSWIMFhBa/ToU4MwQCgQgXAQEBAQEBBQEBAQE4IBuEBwYBBQgBARkVHgEBIQsCAwUCAQMOBwUCBSECAhQBBBoGBwMGAQ0GARIIAgECAwGIHwmwEoZTjiwBAQgBAQEBGgSBIY5Wgm8ugRMFjhVNgnKGQYoyhhGEED4xBYI+AQEB
X-IPAS-Result: Am4bAH8Tn1QCYJmQPGdsb2JhbABcgwZSWIMFhBa/ToU4MwQCgQgXAQEBAQEBBQEBAQE4IBuEBwYBBQgBARkVHgEBIQsCAwUCAQMOBwUCBSECAhQBBBoGBwMGAQ0GARIIAgECAwGIHwmwEoZTjiwBAQgBAQEBGgSBIY5Wgm8ugRMFjhVNgnKGQYoyhhGEED4xBYI+AQEB
X-IronPort-AV: E=Sophos;i="5.07,652,1413241200"; 
   d="scan'208";a="769392719"
Received: from host-2-96-153-144.as13285.net (HELO PhilipOakley) ([2.96.153.144])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 27 Dec 2014 20:17:05 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.237 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261839>

From: "Johannes Sixt" <j6t@kdbg.org>
> Am 27.12.2014 um 19:49 schrieb Philip Oakley:
>> Hi,
>>
>> In ee9be06 (perl: detect new files in MakeMaker builds, 2012-07-27)
>> there is a step to detect if there has been an update to the PM.* 
>> files,
>> however it appears that the logic is inverted in the comparison.
>>
>> I need some extra eye's on this to be sure I have it right (I'm 
>> trying
>> to debug an old Windows breakage...).
>>
>> The resultant output of a make dry run included (on my m/c)..:
>>
>>  find perl -type f -name '*.pm' | sort >perl/PM.stamp+ && \
>>   { cmp perl/PM.stamp+ perl/PM.stamp >/dev/null 2>/dev/null || mv
>> perl/PM.stamp+ perl/PM.stamp; } && \
>>   rm -f perl/PM.stamp+
>>  make -C perl  PERL_PATH='/usr/bin/perl' prefix='/c/Documents and
>> Settings/Philip' perl.mak
>>
>> Shouldn't it be `{ ! cmp ` so that when the files are not identical, 
>> the
>> move is performed?
>>
>> https://github.com/git/git/blob/ee9be06770223238c6a22430eb874754dd22dfb0/Makefile#L2097
>
> The existing code looks correct to me. cmp succeeds when the files are
> identical and fails when they are different: When it succeeds (files 
> are
> equal), the mv is not executed. When it fails, either because a file
> does not exist or they are different, the mv is executed.
>
Thanks. The inverse logic had me confused.
It's like 7400's again, for those that remember;-)

I was getting errors from
`cd $git_dir && make -n MSVC=1 V=1 2>MakeDryErrs.txt 1>MakeDry.txt` 
(borrowed from 'msvc-build') which reported the PM.stamp as a problem, 
with the quoted code being the last part of the MakeDry.txt (and no 
PM.stamp seen).

Now that I've been poking and investigating the error's stopped! It's 
all getting rather frustrating. Time to go again on a clean and 
rebuild..

Philip 

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
