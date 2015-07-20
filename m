From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 08/16] engine.pl: ignore invalidcontinue.obj
 which is known to MSVC
Date: Mon, 20 Jul 2015 07:13:14 +0100
Organization: OPDS
Message-ID: <53A9335E62C64D578188F002443E6247@PhilipOakley>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org><1437336497-4072-9-git-send-email-philipoakley@iee.org> <CAPig+cRYPVg-YOvUvH=7QViDRChG1Lvwt84-3z8ERjBMVdrvnw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"MsysGit List" <msysgit@googlegroups.com>,
	"Yue Lin Ho" <b8732003@student.nsysu.edu.tw>
To: "Eric Sunshine" <sunshine@sunshineco.com>
X-From: msysgit+bncBDSOTWHYX4PBB3FCWKWQKGQEKODC7NY@googlegroups.com Mon Jul 20 08:13:02 2015
Return-path: <msysgit+bncBDSOTWHYX4PBB3FCWKWQKGQEKODC7NY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f63.google.com ([209.85.215.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB3FCWKWQKGQEKODC7NY@googlegroups.com>)
	id 1ZH4Jy-0006gN-1w
	for gcvm-msysgit@m.gmane.org; Mon, 20 Jul 2015 08:13:02 +0200
Received: by laef2 with SMTP id f2sf53609936lae.1
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 23:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=O2hdbxD4DCxqo7DWVE3DWF1f/SwWZktzTesQ2QzHzD0=;
        b=XA9in6HuxAJiKdtEYffBF5StC309VViwMMRn7Dqrw0y/WPShl17Y0yEriCgXTk3REr
         vA//Ej/34aSzdWGQgYvdUdilerfzyw9SYvbr9wsNVwIXBFdy9yXx+qFV5njkO/ecpqdm
         iWGImUCzQfO9UXN1NhEdrv7ATRqkhOX7dOnc4OCxc7Zi2TTPiOxUdouB/7jc9/bmXKbJ
         PbToKdqgHMxIHkKgFcFrhtJVXumsWKjWpCqmhA/DUcjTaQCc8iCDPFvvFb2byO7KAjZh
         lXZVcTQs/uPs4mglQUL3im8nfGAs7XH/zQkIU9fTG8B4rA9s6nxLKwUWKh7HGAhZRNLs
         uc+Q==
X-Received: by 10.152.18.231 with SMTP id z7mr361723lad.23.1437372781653;
        Sun, 19 Jul 2015 23:13:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.29.7 with SMTP id f7ls681977lah.48.gmail; Sun, 19 Jul 2015
 23:13:00 -0700 (PDT)
X-Received: by 10.152.120.69 with SMTP id la5mr14136493lab.7.1437372780139;
        Sun, 19 Jul 2015 23:13:00 -0700 (PDT)
Received: from out1.ip04ir2.opaltelecom.net (out1.ip04ir2.opaltelecom.net. [62.24.128.240])
        by gmr-mx.google.com with ESMTP id fj7si315592wib.3.2015.07.19.23.12.59
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 23:13:00 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.240 as permitted sender) client-ip=62.24.128.240;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2ARDAA6kaxVPHMBFlxcFoJ9VGmDI4QbtiiFbQQEAoEhTQEBAQEBAQcBAQEBQSQbhB4FAQEBAQIBCAEBGRUeAQEhBQYCAwUCAQMVAQICAgUhAgIUAQQaBgcDFAYTCAIBAgMBiBUMCa5yhleOdyCBIooqhQaCby+BFAWUUgGBCoNkiHVGjmWEOINhgQmBKhwVgT89MQEBgkkBAQE
X-IPAS-Result: A2ARDAA6kaxVPHMBFlxcFoJ9VGmDI4QbtiiFbQQEAoEhTQEBAQEBAQcBAQEBQSQbhB4FAQEBAQIBCAEBGRUeAQEhBQYCAwUCAQMVAQICAgUhAgIUAQQaBgcDFAYTCAIBAgMBiBUMCa5yhleOdyCBIooqhQaCby+BFAWUUgGBCoNkiHVGjmWEOINhgQmBKhwVgT89MQEBgkkBAQE
X-IronPort-AV: E=Sophos;i="5.15,507,1432594800"; 
   d="scan'208";a="547847696"
Received: from host-92-22-1-115.as13285.net (HELO PhilipOakley) ([92.22.1.115])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 20 Jul 2015 07:12:52 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.240 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274314>

From: "Eric Sunshine" <sunshine@sunshineco.com> Sent: Monday, July 20, 
2015 2:54 AM
> On Sun, Jul 19, 2015 at 4:08 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> Commit 4b623d8 (MSVC: link in invalidcontinue.obj for better
>> POSIX compatibility, 2014-03-29) is not processed correctly
>> by the buildsystem. Ignore it.
>
> What does "not processed correctly" mean? For a person reading the
> commit message, but lacking your experience with this, "not processed
> correctly" seems akin to "it doesn't work"[1].
True, it didn't work...

>              Can the commit message
> provide a bit more detail?

In fact it is `parsing` (not just `processing`) the output of a 
'make --dry-run', and essentially the old parser did not handle .obj 
files correctly. The deliberate introduction of this .obj file had to be 
handled, and given it's deliberate inclusion I wanted some deliberate 
handling code.

A subsequent patch then fixes the generic .obj issue.

I'll update the commit message. Thanks for noticing the slack writing.

>
> [1]: http://www.chiark.greenend.org.uk/~sgtatham/bugs.html

A timely reminder of this article...
>
>> Also split the .o and .obj processing; 'make' does not produce .obj
>> files. Only substitute filenames ending with .o when generating the
>> source .c filename.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>  contrib/buildsystems/engine.pl | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/contrib/buildsystems/engine.pl 
>> b/contrib/buildsystems/engine.pl
>> index 60c7a7d..9db3d43 100755
>> --- a/contrib/buildsystems/engine.pl
>> +++ b/contrib/buildsystems/engine.pl
>> @@ -289,7 +289,7 @@ sub handleLibLine
>>  #    exit(1);
>>      foreach (@objfiles) {
>>          my $sourcefile = $_;
>> -        $sourcefile =~ s/\.o/.c/;
>> +        $sourcefile =~ s/\.o$/.c/;
>>          push(@sources, $sourcefile);
>>          push(@cflags, @{$compile_options{"${sourcefile}_CFLAGS"}});
>>          push(@defines, 
>> @{$compile_options{"${sourcefile}_DEFINES"}});
>> @@ -333,8 +333,12 @@ sub handleLinkLine
>>          } elsif ($part =~ /\.(a|lib)$/) {
>>              $part =~ s/\.a$/.lib/;
>>              push(@libs, $part);
>> -        } elsif ($part =~ /\.(o|obj)$/) {
>> +        } elsif ($part eq 'invalidcontinue.obj') {
>> +            # ignore - known to MSVC
>> +        } elsif ($part =~ /\.o$/) {
>>              push(@objfiles, $part);
>> +        } elsif ($part =~ /\.obj$/) {
>> +            # do nothing, 'make' should not be producing .obj, only 
>> .o files
>>          } else {
>>              die "Unhandled link option @ line $lineno: $part";
>>          }
>> @@ -343,7 +347,7 @@ sub handleLinkLine
>>  #    exit(1);
>>      foreach (@objfiles) {
>>          my $sourcefile = $_;
>> -        $sourcefile =~ s/\.o/.c/;
>> +        $sourcefile =~ s/\.o$/.c/;
>>          push(@sources, $sourcefile);
>>          push(@cflags, @{$compile_options{"${sourcefile}_CFLAGS"}});
>>          push(@defines, 
>> @{$compile_options{"${sourcefile}_DEFINES"}});
>> --
>> 2.4.2.windows.1.5.gd32afb6
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
