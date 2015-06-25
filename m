From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 01/17] .gitignore: improve MSVC ignore patterns
Date: Thu, 25 Jun 2015 20:32:10 +0100
Organization: OPDS
Message-ID: <DDC36A35EBC548718762478AA7B80F67@PhilipOakley>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org><1435190633-2208-2-git-send-email-philipoakley@iee.org> <xmqqd20j253w.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "GitList" <git@vger.kernel.org>,
	"MsysGitList" <msysgit@googlegroups.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: msysgit+bncBDSOTWHYX4PBBNNNWGWAKGQELQNUECQ@googlegroups.com Thu Jun 25 21:29:59 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBNNNWGWAKGQELQNUECQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f55.google.com ([209.85.215.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBNNNWGWAKGQELQNUECQ@googlegroups.com>)
	id 1Z8CqU-0008SH-ML
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 21:29:58 +0200
Received: by lamq1 with SMTP id q1sf23341969lam.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 25 Jun 2015 12:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=m36iLYu8HHAVzDYC9n0URUOYvAO/IzmkFppiEOBwxx4=;
        b=VmnozlFm7uPRlgfcCyO/8BfNBw4ddDTKRiNf8fwmsY6Kkf0GNoepDziq/1bTDqYeWS
         U1cNmafuUUBe4tDuoj9Mpt6CNvWbx7+vxwlT65a9irowqsUIwx2UATET+tmLEuo9Gs4a
         KXH/3w+5CAl5bVHvAD7m/tSPBqeuibCHNUs3EqpN16HP0ZCqsGM7XmyY3BczlQ+WtJXW
         JKaWkolx6PV0UVnzMB8NxDODgIgr2E4RWVYkTTnmiKHkrlU+n0HlWKcYlQYRKfByfXUt
         BlL+7FQk5aIw1e4Zc+zuCUdrcm8/EXBiA4Eb4weTgbTSFIl16fMDO9dfpllJfbSsH1ra
         E2QA==
X-Received: by 10.152.121.34 with SMTP id lh2mr340887lab.26.1435260598295;
        Thu, 25 Jun 2015 12:29:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.120.9 with SMTP id ky9ls344058lab.98.gmail; Thu, 25 Jun
 2015 12:29:57 -0700 (PDT)
X-Received: by 10.113.11.3 with SMTP id ee3mr40953235lbd.9.1435260597256;
        Thu, 25 Jun 2015 12:29:57 -0700 (PDT)
Received: from out1.ip03ir2.opaltelecom.net (out1.ip03ir2.opaltelecom.net. [62.24.128.239])
        by gmr-mx.google.com with ESMTP id eo3si362410wib.0.2015.06.25.12.29.57
        for <msysgit@googlegroups.com>;
        Thu, 25 Jun 2015 12:29:57 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.239 as permitted sender) client-ip=62.24.128.239;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CXawBmVYxVPHK/BlxbgxGBM4ZMbbEvjAgEBAKBP00BAQEBAQEHAQEBAUEkG0EBAgKDVwYBAQQIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBiCK/KJAji0qFBoMegRQFhVqGcYc7AYEDoweBCWaCMj0xgkgBAQE
X-IPAS-Result: A2CXawBmVYxVPHK/BlxbgxGBM4ZMbbEvjAgEBAKBP00BAQEBAQEHAQEBAUEkG0EBAgKDVwYBAQQIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBiCK/KJAji0qFBoMegRQFhVqGcYc7AYEDoweBCWaCMj0xgkgBAQE
X-Header: TalkTalk
X-IronPort-AV: E=Sophos;i="5.13,679,1427756400"; 
   d="scan'208";a="554797108"
Received: from host-92-6-191-114.as43234.net (HELO PhilipOakley) ([92.6.191.114])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 25 Jun 2015 20:29:58 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272715>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> Add the Microsoft .manifest pattern, and correct the generic 'Debug'
>> and 'Release' directory patterns which were mechanically adjusted way
>> back in c591d5f (gitignore: root most patterns at the top-level 
>> directory,
>> 2009-10-26) to allow multi-level projects within the Git suite.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>  .gitignore | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 422c538..55498c1 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -246,5 +246,6 @@
>>  *.user
>>  *.idb
>>  *.pdb
>> -/Debug/
>> -/Release/
>> +*.manifest
>> +**/Debug/
>> +**/Release/
>
> Why "**/" there?  Wouldn't
>
> *.manifest
> Debug/
> Release/
>
> suffice?
>
Probably. I was thinking of the 'at any level' aspect because some of 
the 'projects' appeared two levels down and weren't caught by the rooted 
ignore. Can change.

--
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
