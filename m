From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 00/17] Make the msvc-build scripts work again
Date: Thu, 25 Jun 2015 20:31:48 +0100
Organization: OPDS
Message-ID: <D5232F937FAC41C89F2DB0806A5ABE7B@PhilipOakley>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org> <xmqqh9pv258w.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "GitList" <git@vger.kernel.org>,
	"MsysGitList" <msysgit@googlegroups.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: msysgit+bncBDSOTWHYX4PBBIFNWGWAKGQEA2JIQSA@googlegroups.com Thu Jun 25 21:29:37 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBIFNWGWAKGQEA2JIQSA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f64.google.com ([74.125.82.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBIFNWGWAKGQEA2JIQSA@googlegroups.com>)
	id 1Z8Cq9-00089E-5i
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 21:29:37 +0200
Received: by wggx12 with SMTP id x12sf23269182wgg.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 25 Jun 2015 12:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=bWnyu4YupFSdeQkUJqB7JAfIppHzhKj6o01Tf3SgYBQ=;
        b=Nwt7t1A9aCyL0HK6e78xczX4CrO7jrTJmPKs9lJjV5Lhfb7lMf6wNDQvgq1ROM1I+g
         iECUWlBTw9ZEC1WmkcS89YfPeoKucItM5BmP3CHLL7DPl+rqbYWafCPpSWBawUXF9LLM
         mZAfWRJDZwG+t/c9hjL4bkZZ9OjNNFBqJHB3kTFslEuWbllX6aclndfCeytDskK1DuzI
         qFGxDZYWxcHF0NLQyq0n8qMW/8n4pOqj0BTPXt+ip9QbH/x/2mBOQ5Sv7iXHwCU0SymP
         XTKWTcsAL5KBejjYTZyDl8bG+pQVwsRSMeeij6alazzA4DcI4v5Pq3egzfH75NfYHY9N
         7gDQ==
X-Received: by 10.152.37.34 with SMTP id v2mr617007laj.16.1435260576853;
        Thu, 25 Jun 2015 12:29:36 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.178.195 with SMTP id da3ls404292lac.43.gmail; Thu, 25 Jun
 2015 12:29:35 -0700 (PDT)
X-Received: by 10.112.28.111 with SMTP id a15mr40472841lbh.21.1435260575635;
        Thu, 25 Jun 2015 12:29:35 -0700 (PDT)
Received: from out1.ip03ir2.opaltelecom.net (out1.ip03ir2.opaltelecom.net. [62.24.128.239])
        by gmr-mx.google.com with ESMTP id t6si190882wiz.0.2015.06.25.12.29.35
        for <msysgit@googlegroups.com>;
        Thu, 25 Jun 2015 12:29:35 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.239 as permitted sender) client-ip=62.24.128.239;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CtNwBmVYxVPHK/BlxbgxFUX4c5sS+GGoVuBAQCgT9NAQEBAQEBBwEBAQFBJBtBA4NZBQEBAQECAQgBAR0RHgEBIQsCAwUCAQMVDCUUAQQaBgcDBgENBhMIAgECAwGIFgwJvx+QI4tKhQaDHoEUBYVahjkBN4c7AYEDg1SIdpY9gQmBKRyBUz0xgkgBAQE
X-IPAS-Result: A2CtNwBmVYxVPHK/BlxbgxFUX4c5sS+GGoVuBAQCgT9NAQEBAQEBBwEBAQFBJBtBA4NZBQEBAQECAQgBAR0RHgEBIQsCAwUCAQMVDCUUAQQaBgcDBgENBhMIAgECAwGIFgwJvx+QI4tKhQaDHoEUBYVahjkBN4c7AYEDg1SIdpY9gQmBKRyBUz0xgkgBAQE
X-IronPort-AV: E=Sophos;i="5.13,679,1427756400"; 
   d="scan'208";a="554797063"
Received: from host-92-6-191-114.as43234.net (HELO PhilipOakley) ([92.6.191.114])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 25 Jun 2015 20:29:36 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.239 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272714>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> Hopefully it's not too late in the cycle for a review of this 
>> contrib/compat
>> item.
>
> Has this been discussed in the Windows land and folks are all happy
> with this change?  If so the only thing we would need review on the
> main list is the top-level change outside compat/ and contrib/, so
> it may be possible to sneak it in before -rc1.

Yes this had been discussed previously on the MsysGit list, and in the 
referenced Pull Request [msysgit/#318] 
https://github.com/msysgit/git/pull/318/files.

I had aspirations of a slightly bigger series that would also allow the 
VS compiled output to be installed but that had stalled, so I cut back 
to fixing the basic 'make it work' steps.

The series has been reordered/rebased, and the recently noticed 05/17 
err msg fix added.

The one unknown is the last patch [17] for the Windows Safe Exception 
Handling in that the default acceptability was flipped in VS2013 so that 
zlib became unacceptable to ceratain OS versions without the addition of 
that option -SAFESEH:NO, but I haven't been able to test that myself (I 
don't have a complaining system).

>
> Otherwise, no, but we can still polish it during the prerelease
> freeze and aim to merge it in the first batch after the upcoming
> release.
>
>
>> Philip Oakley (17):
>>   .gitignore: improve MSVC ignore patterns
>>   .gitignore: ignore library directories created by MSVC VS2008
>>     buildsystem
>>   (msvc-build) Vcproj.pm: remove duplicate GUID
>>   Makefile: a dry-run can error out if no perl. Document the issue
>>   engine.pl: fix error message (lib->link)
>>   engine.pl: Avoid complications with perl support
>>   engine.pl: Properly accept quoted spaces in filenames
>>   engine.pl: Fix i18n -o option in msvc buildsystem generator
>>   engine.pl: ignore invalidcontinue.obj which is known to MSVC
>>   engine.pl: name the msvc buildsystem's makedry error file
>>   engine.pl: delete the captured stderr file if empty
>>   engine.pl: add debug line to capture the dry-run
>>   engine.pl: provide more debug print statements
>>   Vcproj.pm: list git.exe first to be startup project
>>   vcbuild/readme: Improve layout and reference msvc-build script
>>   msvc-build: add complete Microsoft Visual C compilation script
>>   config.mak.uname: add MSVC No_SafeExeceptionHandler option
>>
>>  .gitignore                                |  8 ++-
>>  Makefile                                  |  3 ++
>>  compat/vcbuild/README                     | 27 +++++++---
>>  compat/vcbuild/scripts/msvc-build         | 89 
>> +++++++++++++++++++++++++++++++
>>  config.mak.uname                          |  9 ++++
>>  contrib/buildsystems/Generators/Vcproj.pm | 34 ++++++------
>>  contrib/buildsystems/engine.pl            | 37 ++++++++++---
>>  7 files changed, 174 insertions(+), 33 deletions(-)
>>  create mode 100644 compat/vcbuild/scripts/msvc-build
>
>
>>  mode change 100755 => 100644 contrib/buildsystems/engine.pl
>
> Why?

Mistake on/by Windows? - My mistake, I hadn't noticed it had happened.

I can search out the change step and re-roll.

> --
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
