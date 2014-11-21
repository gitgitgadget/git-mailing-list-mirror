From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC 4/4] Improve layout and reference msvc-build script
Date: Fri, 21 Nov 2014 21:05:48 -0000
Organization: OPDS
Message-ID: <6D7BD7DD7E3A49EE8D7B04BC86F88F74@PhilipOakley>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org> <1416526682-6024-5-git-send-email-philipoakley@iee.org> <alpine.DEB.1.00.1411211049100.13845@s15462909.onlinehome-server.info>
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
X-From: msysgit+bncBDSOTWHYX4PBB4WRX2RQKGQEQNIVFAQ@googlegroups.com Fri Nov 21 22:04:51 2014
Return-path: <msysgit+bncBDSOTWHYX4PBB4WRX2RQKGQEQNIVFAQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f58.google.com ([209.85.215.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB4WRX2RQKGQEQNIVFAQ@googlegroups.com>)
	id 1XrvNq-000622-SU
	for gcvm-msysgit@m.gmane.org; Fri, 21 Nov 2014 22:04:50 +0100
Received: by mail-la0-f58.google.com with SMTP id q1sf532279lam.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 21 Nov 2014 13:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=8urbaV2qmbUOryoaqpvPzeVCbswnE96P4Jty0dnNwCo=;
        b=lAnZKxjE5py2Qhqlfxf1fVfwrw9vAdtfdUslemF1KfEbDYqNq+oVqMx34CFI0e1PGy
         OERIuFfXWF9TFRvW2GlOVYXgGHdiUP7JCa5qETpKZXZXmFYdZtS2rOuT3PWrJSW/l97w
         QYnqTSayy58hrH4fUB78kEjf9i5x7Ad50/+DXmR0dP2OCvF8TdKt2jNQ7p6VGninX4gu
         ODwD3ykwWoXT2Uw+nmHgkm9ERjEc7lfDy2unBj0uRkEh2bypCFZoY5u8rjeHFeHYxm5Z
         Ybm7WlQ3LG5KGRmhXnKdrVbCN87VU1vIbx7a6/iirYZPGIC1CLr1Qd3VDkLU6Wlr4KuE
         uxcQ==
X-Received: by 10.180.20.203 with SMTP id p11mr2628wie.13.1416603890718;
        Fri, 21 Nov 2014 13:04:50 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.79.165 with SMTP id k5ls29847wix.4.canary; Fri, 21 Nov
 2014 13:04:50 -0800 (PST)
X-Received: by 10.180.102.228 with SMTP id fr4mr96191wib.1.1416603890037;
        Fri, 21 Nov 2014 13:04:50 -0800 (PST)
Received: from out1.ip03ir2.opaltelecom.net (out1.ip03ir2.opaltelecom.net. [62.24.128.239])
        by gmr-mx.google.com with ESMTP id d18si36204wiv.0.2014.11.21.13.04.49
        for <msysgit@googlegroups.com>;
        Fri, 21 Nov 2014 13:04:50 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.239 as permitted sender) client-ip=62.24.128.239;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlMLADSnb1RZ8YpUPGdsb2JhbABSCoMOgS6HCYEEynUEAoEGFwEBAQEBAQUBAQEBODuDfQUBAQEBAgEIAQEuHgEBIQsCAwUCAQMVAwklFAEEGgYHAwYBDQYTCAIBAgMBCogRAwkNvW+QPY5OgWFcgzaBHwWFL4Y5hnxrjF+DWZYDSDCCSwEBAQ
X-IPAS-Result: AlMLADSnb1RZ8YpUPGdsb2JhbABSCoMOgS6HCYEEynUEAoEGFwEBAQEBAQUBAQEBODuDfQUBAQEBAgEIAQEuHgEBIQsCAwUCAQMVAwklFAEEGgYHAwYBDQYTCAIBAgMBCogRAwkNvW+QPY5OgWFcgzaBHwWFL4Y5hnxrjF+DWZYDSDCCSwEBAQ
X-IronPort-AV: E=Sophos;i="5.07,432,1413241200"; 
   d="scan'208";a="533206421"
Received: from host-89-241-138-84.as13285.net (HELO PhilipOakley) ([89.241.138.84])
  by out1.ip03ir2.opaltelecom.net with SMTP; 21 Nov 2014 21:04:49 +0000
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
>> [...]
>> +Or, use the msvc-build script; also in /msysgit/bin/msvc-build
>
> As I mentioned before, from a Git Bash on Windows, the path is
> /bin/msvc-build (no /msysgit/). That is quite likely to stay the same 
> with
> the upcoming Git for Windows SDK, too (once I add the file to the 
> SDK).

I was trying to identify the source file (as I see it in my Msysgit 
install). However it will all need tidying to distinguish what is seen 
if you have G4W-SDK, rather just installing the new G4W (when ready)
>
> By the way, I think we should also start thinking about a Jenkins job 
> to
> verify that upstream changes such as invalidcontinue.obj do not break 
> the
> MSVC build. Please let me know if you want to give it a try, I have a
> Windows Azure instance with a Jenkins instance, sponsored by 
> Microsoft.

This is not something I'm familiar with, but it's something I could have 
a look at.
On my list is also the 'git bundle' symref problem, which we've got a 
solution for that 'just' needs coding, along with thoughts about 
narrow/sparse checkout/clone/fetch.

One of the confusions I have is the distinction between building with 
the MSVC compiler (cl command line) and building within VS2008, and 
whether they are different things (i.e. does VS2008 bring extra 
baggage?).
--
Philip


>
> Ciao,
> Johannes
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
