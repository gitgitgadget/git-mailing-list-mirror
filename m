From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 04/17] Makefile: a dry-run can error out if no
 perl. Document the issue
Date: Tue, 14 Jul 2015 23:42:13 +0100
Organization: OPDS
Message-ID: <0D1AA32B8D59471B8C528002A460E912@PhilipOakley>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org><1435190633-2208-5-git-send-email-philipoakley@iee.org><xmqq8ub724ls.fsf@gitster.dls.corp.google.com><DBFC4D88D6F34023BA43F5F10134331E@PhilipOakley> <xmqqmvzny1xe.fsf@gitster.dls.corp.google.com> <45344004B4CA4B16BD7FB174B4849D77@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=response
Cc: "GitList" <git@vger.kernel.org>,
	"MsysGitList" <msysgit@googlegroups.com>
To: "Philip Oakley" <philipoakley@iee.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: msysgit+bncBDSOTWHYX4PBBF5AS2WQKGQEIPNUAXQ@googlegroups.com Wed Jul 15 00:41:30 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBF5AS2WQKGQEIPNUAXQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBF5AS2WQKGQEIPNUAXQ@googlegroups.com>)
	id 1ZF8tE-0006VK-MU
	for gcvm-msysgit@m.gmane.org; Wed, 15 Jul 2015 00:41:28 +0200
Received: by widic2 with SMTP id ic2sf14398265wid.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 14 Jul 2015 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=PsRu3oPRyxn0D8pXbggCj0V7qd9nYVTKt9czHMIkM/k=;
        b=lQvSQ4A0IVlYH3jaNNXBYJ8SevY26wmju+jjGAYaIIGAw8M9WBvMnoxrML2c3Ch+cQ
         wTGb97SCRbs/E9nCXUeJDYln3i5on0+LRvIcD40aUyeC5aVcpmjAhvsZrMz1Clydgzx5
         YbYDwOY6CGPnPzZTW/+Iv0Bzs6hfe1bHVzxtt0utGlhahArWfCQjWpyyiH2AKcWOuCfW
         Nm1oC7QwWRe3aLmeZq30jYCG2UHxN4+GHg+mfxiMQyejgLhsmGnpxKtrXXZGE/5Sbz2R
         Tq/u2DXeVBgM7JRBmGOKVL5KlWMys8vpphx/7jSQmolPWy+u3bgeTN34xhvfVOQ9ybWY
         7hUA==
X-Received: by 10.152.37.7 with SMTP id u7mr20549laj.22.1436913688360;
        Tue, 14 Jul 2015 15:41:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.178.164 with SMTP id cz4ls122650lac.3.gmail; Tue, 14 Jul
 2015 15:41:26 -0700 (PDT)
X-Received: by 10.112.122.12 with SMTP id lo12mr468953lbb.5.1436913686746;
        Tue, 14 Jul 2015 15:41:26 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id q10si158723wiz.0.2015.07.14.15.41.26
        for <msysgit@googlegroups.com>;
        Tue, 14 Jul 2015 15:41:26 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2B4EABUj6VVPJK+BlxVBoMTgS8OhlJttCCHYgQEAoFLOxIBAQEBAQEBBgEBAQFBP0EDg1oFAQEBAQIBCAEBLh4BASELAgMFAgEDFQELJRQBBBoGBwMUBgESCAIBAgMBCogLDL9fj2QBAQEBAQEEAQEBAQEdi0yEQ0ODHoEUBYxkh04BgQeMPocnh3mEL4MTTIEJgVqBPz0xgksBAQE
X-IPAS-Result: A2B4EABUj6VVPJK+BlxVBoMTgS8OhlJttCCHYgQEAoFLOxIBAQEBAQEBBgEBAQFBP0EDg1oFAQEBAQIBCAEBLh4BASELAgMFAgEDFQELJRQBBBoGBwMUBgESCAIBAgMBCogLDL9fj2QBAQEBAQEEAQEBAQEdi0yEQ0ODHoEUBYxkh04BgQeMPocnh3mEL4MTTIEJgVqBPz0xgksBAQE
X-IronPort-AV: E=Sophos;i="5.15,475,1432594800"; 
   d="scan'208";a="38816411"
Received: from host-92-6-190-146.as43234.net (HELO PhilipOakley) ([92.6.190.146])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 14 Jul 2015 23:41:26 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.238 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273978>

From: "Philip Oakley" <philipoakley@iee.org>
Sent: Friday, June 26, 2015 12:34 AM
> From: "Junio C Hamano" <gitster@pobox.com>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> From: "Junio C Hamano" <gitster@pobox.com>
>>>>
>>>> I am not sure what this patch is trying to achieve.

I have been able to repeat the issue, more below.

>>>
>>> It was probably a bit of 'don't mess with working code', given that
>>> I'd used the NO_PERL solution, rather 'document the issue'....
>>
>> Then this part applies, I think.
>>
>>>> If you are not touching what this Makefile actually does, then I
>>>> would imagine that you are running the "buildsystems code" that
>>>> actually drives 'make -n' with some "available solution" (perhaps
>>>> you are running 'make -n NO_PERL=NoThanks' or something like that)?
>>>> Then instead of a command like this that nobody would read in this
>>>> file, the same command can instead go there to explain what the
>>>> "workaround" (e.g. unusual-looking 'make -n NO_PERL=NoThanks') is
>>>> doing?

The command sequence:
 $ git clean -dfx
 $ make -n MSVC=1 V=1 2>ErrsFile.txt 1>MakeDry.txt

produces the error
 make[1]: *** No rule to make target 'PM.stamp', needed by 'perl.mak'. 
Stop.
 make: *** [perl/perl.mak] Error 2

the actual MakeDry.txt reaches

 echo "$FLAGS" >GIT-CFLAGS; \
            fi
 make[2]: Leaving directory '/c/msysgit195/git'
 make[1]: Leaving directory '/c/msysgit195/git/perl'
 Makefile:1758: recipe for target 'perl/perl.mak' failed

My understanding of the error is that, first, the PM.stamp is removed by 
the clean, then the dryrun has by the error time passed the initial 
PM.stamp update code, but doesn't execute it (being a dry run), thus the 
file PM.stamp still does not exist.

The makefile then descends into the 'perl/Makefile' pre-requisite to 
'perl/perl.mak', and (IIUC) at this point the L25#$(makfile): PM.stamp 
then barfs because there is no PM.stamp to be a prerequisite for that 
line.

As noted in the patch, my response at the time (not fully understanding 
why) was simply to annotate the Makefile's PM.stamp (which is where the 
error would first leads any future debugging).

Possibly other options would be to add an extra PM.stamp target which, 
for a dry-run (+recipe), creates any empty PM.stamp file if one does not 
exist, simply to allow the perl/perl.mak to succeed. Or perhaps simply 
add the PM.stamp file to the code (or maybe not).

A third option would be to simply convert the PM.stamp recipe to a 
+recipe so that it's executed during the dry-run, but that may be 
contrary to the idea of being a dry-run.

Do you have any preference for how I should resolve this? Ideally I like 
to drop the use of the NO_PERL in the dry run.

--
Philip

>>
> I was more of the view that this was about prevention (here), rather
> than retrospective explanation of the code (there).
>
> In my case the errors were showing problems with the PM.stamp in the
> makefile (I didn't have the solution at that point).
>
> So either a short comment "#  consider using 'NO_PERL=YesPlease' for 
> dry
> run invocations" (beware your double negative ;-), or the addition of
> the '+recipe', would still be my preferred change, rather than leaving
> the open manhole for others to fall into.
>
> The thread on my difficulties is at $gmane/263656 (2015-02-10 22:51)
> "
>    At the moment I'm getting (on my old WinXP machine, using Msysgit
>    1.9.5 as a basis)
>
>    $ make -n MSVC=1 V=1 1>makedry.txt
>    make[1]: *** No rule to make target `PM.stamp', needed by 
> `perl.mak'.
>    Stop.
>    make: *** [perl/perl.mak] Error 2
> "
> As you can see, at that time the place to look would be the makefile,
> so I would do think a 'fix' there would still be appropriate.
>
> Do you have a preference among the three options (comment, +recipe, 
> drop)?
> --
> Philip
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
