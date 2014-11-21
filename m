From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC 1/4] Fix i18n -o option in msvc engine.pl
Date: Fri, 21 Nov 2014 20:27:37 -0000
Organization: OPDS
Message-ID: <A86C2AE45DB643018C05D8C766FB04F3@PhilipOakley>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org> <1416526682-6024-2-git-send-email-philipoakley@iee.org> <alpine.DEB.1.00.1411211038570.13845@s15462909.onlinehome-server.info>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "GitList" <git@vger.kernel.org>,
	"Marius Storm-Olsen" <mstormo@gmail.com>,
	"Ramsay Jones" <ramsay@ramsay1.demon.co.uk>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Michael Wookey" <michaelwookey@gmail.com>,
	"Msysgit" <msysgit@googlegroups.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDSOTWHYX4PBB7V7X2RQKGQECBXFFWY@googlegroups.com Fri Nov 21 21:26:39 2014
Return-path: <msysgit+bncBDSOTWHYX4PBB7V7X2RQKGQECBXFFWY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f185.google.com ([209.85.217.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB7V7X2RQKGQECBXFFWY@googlegroups.com>)
	id 1Xrumt-0000LU-4k
	for gcvm-msysgit@m.gmane.org; Fri, 21 Nov 2014 21:26:39 +0100
Received: by mail-lb0-f185.google.com with SMTP id z12sf176927lbi.22
        for <gcvm-msysgit@m.gmane.org>; Fri, 21 Nov 2014 12:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=Zq5fVCKXcQBqgqDqxtbpNyGZL4pTGSoQC+M9CLFa+Nw=;
        b=KGW8XPsu0vAz8EvzlUcIe/nCLeFI/TqgOMNWJrv961yYyFnWrdcil6+hqd4ODiwotz
         tbUbhKCJp8tcLLhKTSZTpD/fmI5LVpjeVgNAFAkISfgkr4Itts3teittXfjF7hMtoqzG
         i1kNctSoPJPdh8pVjOQVPjWkcWljijM6pFSSuStAKwwlheP/+dyQgzG9mWpGAWB+okxq
         Am+lLUmyZtmjYaV8g+7SSpJWuGU4I52O8Y8h5uxAqA0hQIQuTe32FkqSoEd6V2ELs5st
         6X5zMswpH2PJIc31b5gpUVnP7ie6a9oi6jwC8s/fRARG7YwFP4F4jWUxq2AtcJyelT/K
         8Wzw==
X-Received: by 10.180.211.239 with SMTP id nf15mr1838wic.0.1416601598923;
        Fri, 21 Nov 2014 12:26:38 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.93.65 with SMTP id cs1ls24405wib.12.canary; Fri, 21 Nov
 2014 12:26:37 -0800 (PST)
X-Received: by 10.194.109.131 with SMTP id hs3mr2190080wjb.0.1416601597941;
        Fri, 21 Nov 2014 12:26:37 -0800 (PST)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id el8si23015wib.3.2014.11.21.12.26.37
        for <msysgit@googlegroups.com>;
        Fri, 21 Nov 2014 12:26:37 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApYQAGWfb1RZ8YpUPGdsb2JhbABcgw5VWYgNw2MiDIZjAQMBAYEHFwEBAQEBAQUBAQEBODuDfQUBAQEBAgEIAQEuFggBASELAgMFAgEDFQMJJRQBBBgCBgcDFAYICwgCAQIDAQwEiAsDCQ0JvVKQHwEfjk6CPYM2gR8Fi2iGfGuDeokkmR1IMAGCSgEBAQ
X-IPAS-Result: ApYQAGWfb1RZ8YpUPGdsb2JhbABcgw5VWYgNw2MiDIZjAQMBAYEHFwEBAQEBAQUBAQEBODuDfQUBAQEBAgEIAQEuFggBASELAgMFAgEDFQMJJRQBBBgCBgcDFAYICwgCAQIDAQwEiAsDCQ0JvVKQHwEfjk6CPYM2gR8Fi2iGfGuDeokkmR1IMAGCSgEBAQ
X-IronPort-AV: E=Sophos;i="5.07,432,1413241200"; 
   d="scan'208";a="16965693"
Received: from host-89-241-138-84.as13285.net (HELO PhilipOakley) ([89.241.138.84])
  by out1.ip02ir2.opaltelecom.net with SMTP; 21 Nov 2014 20:26:37 +0000
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
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi Philip,
>
> On Thu, 20 Nov 2014, Philip Oakley wrote:
>
>>     The i18n 5e9637c6 introduced an extra '-o' option
>>     into the make file,
>
> I take it you are referring to
>
> https://github.com/git/git/commit/5e9637c6#diff-b67911656ef5d18c4ae36cb6741b7965R2195

Yes, Makefile#L2195 (of the new version)
>
>> diff --git a/contrib/buildsystems/engine.pl 
>> b/contrib/buildsystems/engine.pl
>> index 23da787..9144ea7 100755
>> --- a/contrib/buildsystems/engine.pl
>> +++ b/contrib/buildsystems/engine.pl
>> @@ -140,6 +140,18 @@ sub parseMakeOutput
>>              next;
>>          }
>>
>> +        if ($text =~ /^mkdir /) {
>> +            # options to the Portable Object translations in the 
>> line
>> +            # mkdir -p po/... && msgfmt ... (eg -o) may be mistaken 
>> for linker options
>
> Maybe better
>
> # the line "mkdir ... && msgfmt ..." contains no linker options

OK will use.
>
>> +            next;
>> +        }
>> +
>> +        if ($text =~ /^msgfmt /) {
>> +            # options to the Portable Object translations in the 
>> line
>> +            # mkdir -p po/... && msgfmt ... (eg -o) may be mistaken 
>> for linker options
>> +            next;
>> +        }
>
> These two if clauses do the same, maybe call it
>
> if ($test =~ /^(mkdir|msgfmt) /)

That's good, will use.

>
> Ciao,
> Johannes
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
