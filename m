From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 14/16] vcbuild/readme: Improve layout and
 reference msvc-build script
Date: Sun, 19 Jul 2015 21:21:50 +0100
Organization: OPDS
Message-ID: <E38778D2F5964B60974C9E95C88E2559@PhilipOakley>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org> <1437336497-4072-15-git-send-email-philipoakley@iee.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"MsysGit List" <msysgit@googlegroups.com>,
	"Yue Lin Ho" <b8732003@student.nsysu.edu.tw>
To: "Philip Oakley" <philipoakley@iee.org>,
	"Git List" <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBXENWCWQKGQEXASBQ6A@googlegroups.com Sun Jul 19 22:21:49 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBXENWCWQKGQEXASBQ6A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBXENWCWQKGQEXASBQ6A@googlegroups.com>)
	id 1ZGv5p-0007o7-Hg
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:21:49 +0200
Received: by wgjf7 with SMTP id f7sf462994wgj.0
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=d184DlTPkmYHIsNV61ZVT7/FgZevg0rEKNYwGPQeZj8=;
        b=qbTR+4djozNGFmjPsc24C5DnMrAEnInJJml3A4EYuwv2PafYKgfhF/w74IhObX3tNW
         PasGaCpTnmJ7Xbit7h0z/4HlOqsNT0+h6Ru8P/5P7JZEGZpON7N7i2SMotB62qYXZIVc
         +N9pZVxC7JxadzkER+0/cBcX8qNLQYS8XWo092qAmmJQXQL6GcTOV8TrFPzxXknu7IS6
         /srqTPXiclSMWFE2Ymcy3ZTFt1UKnZoyzdlDZu+H6jXUiAGgzfzIt0WDk8gmpGUNeVFC
         PqfY8L9Z2bKJAt0m//NaaEQzZcg7wFKie+SPpvX2bqFdkUz7r8ZkGWbBMQzCo6HzwR3r
         qIzw==
X-Received: by 10.152.87.243 with SMTP id bb19mr16397lab.7.1437337309149;
        Sun, 19 Jul 2015 13:21:49 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.120.102 with SMTP id lb6ls780857lab.49.gmail; Sun, 19 Jul
 2015 13:21:48 -0700 (PDT)
X-Received: by 10.152.27.130 with SMTP id t2mr13213393lag.2.1437337308053;
        Sun, 19 Jul 2015 13:21:48 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id hm7si279923wib.0.2015.07.19.13.21.47
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:21:47 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AzCgAPBqxVPN4GFlxcgxOBLw6GUW20JwmHYgQEAoEcORQBAQEBAQEBBgEBAQFAASQbhB4FAQEBAQIBCAEBLh4BASEFBgIDBQIBAxUBCyUUAQQaBgcDFAYBEggCAQIDAYgVDLVqjmUBAQgBAQEBHotMhQaDHoEUAQSMcIdiAYEKixeBQoQakl5MgQmBW4E/PTGCSwEBAQ
X-IPAS-Result: A2AzCgAPBqxVPN4GFlxcgxOBLw6GUW20JwmHYgQEAoEcORQBAQEBAQEBBgEBAQFAASQbhB4FAQEBAQIBCAEBLh4BASEFBgIDBQIBAxUBCyUUAQQaBgcDFAYBEggCAQIDAYgVDLVqjmUBAQgBAQEBHotMhQaDHoEUAQSMcIdiAYEKixeBQoQakl5MgQmBW4E/PTGCSwEBAQ
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39119553"
Received: from host-92-22-6-222.as13285.net (HELO PhilipOakley) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:21:47 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274294>

From: "Philip Oakley" <philipoakley@iee.org>
Sent: Sunday, July 19, 2015 9:08 PM

This "14/16" is the wrong version accidently left over from a previous 
draft.
Please use the other version with the shorter subject line.

Sorry for the noise / mistake.

> Layout the 'either/or' with more white space to clarify
> which alternatives are matched up.
>
> Reference the Msysgit build script which automates one sequence of 
> options.

This part has been dropped.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
[...]
> Done!
> +
> +Or, use the Msysgit msvc-build script; available from that project.
... has gone.

> -- 
> 2.4.2.windows.1.5.gd32afb6
>
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
