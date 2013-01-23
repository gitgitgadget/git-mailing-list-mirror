From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Re: Bug in EOL conversion?
Date: Wed, 23 Jan 2013 23:32:40 -0000
Organization: OPDS
Message-ID: <6950538D893A45FF8C5986B3A64067C6@PhilipOakley>
References: <CANrZfmGXtKcB+i_xhNJELftRc1pC2TJKKhOieHm=5Qkni9OKrA@mail.gmail.com> <063ABD39C46D492391698E400A7D1FA9@PhilipOakley> <CABPQNSaqFjvW6Kudc2uN3YWvrZuimN7MDWUeyjyG9vSZHD=C8g@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1; reply-type=original
Cc: "Stefan Norgren" <stefan.norgren@gmail.com>,
	<git@vger.kernel.org>,
	"Git MsysGit" <msysgit@googlegroups.com>
To: <kusmabite@gmail.com>
X-From: msysgit+bncBDSOTWHYX4PBBE7GQGEAKGQEE7JUSCI@googlegroups.com Thu Jan 24 00:32:55 2013
Return-path: <msysgit+bncBDSOTWHYX4PBBE7GQGEAKGQEE7JUSCI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f191.google.com ([209.85.217.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBE7GQGEAKGQEE7JUSCI@googlegroups.com>)
	id 1Ty9oL-0000eb-Tv
	for gcvm-msysgit@m.gmane.org; Thu, 24 Jan 2013 00:32:53 +0100
Received: by mail-lb0-f191.google.com with SMTP id l12sf1111820lbo.18
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Jan 2013 15:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-ironport-anti-spam-filtered:x-ironport-anti-spam-result
         :x-ironport-av:message-id:reply-to:from:to:cc:references:subject
         :date:organization:mime-version:x-priority:x-msmail-priority
         :x-mailer:x-mimeole:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=xq/lWeMkHLpEHr9xsvlgRmbiP6o5Tkez99cLu3S3XQ0=;
        b=p4WN62/X5UcGbhtyYEyuvYaMfEHTTGDr+/93d1Cx2pD358TqN4FUJ9OWQ+K1oP0P8d
         JTWO8QQfoKfBLU8ypUYzEkuFcX74Ymby9vPkEkiMJ60qWkpe1jn6OdEH/P+rh7WCy2wq
         ku32zCMLuYkMcnWm/+/oLJkJDL/Z6c29K8sRWEHosiEoZStzApKnJWeKV2 
X-Received: by 10.180.90.112 with SMTP id bv16mr39567wib.16.1358983956454;
        Wed, 23 Jan 2013 15:32:36 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.106.198 with SMTP id gw6ls293599wib.5.canary; Wed, 23 Jan
 2013 15:32:35 -0800 (PST)
X-Received: by 10.180.83.2 with SMTP id m2mr41503wiy.0.1358983955553;
        Wed, 23 Jan 2013 15:32:35 -0800 (PST)
X-Received: by 10.180.83.2 with SMTP id m2mr41499wiy.0.1358983955517;
        Wed, 23 Jan 2013 15:32:35 -0800 (PST)
Received: from out1.ip03ir2.opaltelecom.net (out1.ip03ir2.opaltelecom.net. [62.24.128.239])
        by gmr-mx.google.com with ESMTP id v2si1608879wix.3.2013.01.23.15.32.35;
        Wed, 23 Jan 2013 15:32:35 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.239 as permitted sender) client-ip=62.24.128.239;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjUFAPBxAFFcHIm8/2dsb2JhbABEjAKwNYIJF3OCGQUBAQUIAQEuHgEBIQsCAwUCAQMVAQIJJRQBBAgSBgcJAQ0GEwgCAQIDAYd3AxO0EA2JVYwEggaCSGEDiCyFUYY5jQ2FEoJ1
X-IronPort-AV: E=Sophos;i="4.84,524,1355097600"; 
   d="scan'208";a="412103558"
Received: from host-92-28-137-188.as13285.net (HELO PhilipOakley) ([92.28.137.188])
  by out1.ip03ir2.opaltelecom.net with SMTP; 23 Jan 2013 23:32:34 +0000
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
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214377>

From: "Erik Faye-Lund" <kusmabite@gmail.com>
Sent: Wednesday, January 23, 2013 10:36 PM
> On Wed, Jan 23, 2013 at 10:55 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> The msysgit list msysgit@googlegroups.com may be a better place for 
>> this.
>>
>> It is likely that you have a windows specific EOL conversion set 
>> within the
>> wider config's (i.e.  --system, --global). You may have core.safecrlf 
>> set
>> which does a round trip test so tests the conversion both ways.
>
> The default for core.safecrlf is "warn", so one does not need a
> setting to get that warning.
>

Thank you confirming the Git for Windows default, which I don't believe 
Stefan had realised was active.

I had responded to Stefan's original 'bug' report as no one had picked 
up on it, and suspected it (core.safecrlf ) was set in Git for Windows, 
though wasn't able to immediately check it myself.

I did not think it was a bug at all, merely a misunderstanding by Stefan 
about the safety features within Git (for Windows). 

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
