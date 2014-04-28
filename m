From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git version 1.9.0 missing git-http-push?
Date: Mon, 28 Apr 2014 21:02:19 +0200
Message-ID: <CABPQNSaOVrUJVQcE8pyfohP4tgvD+bRPScw-igsFj08H3EoRWA@mail.gmail.com>
References: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local>
 <1398670610456-7608792.post@n2.nabble.com> <CABPQNSY-bM2pv7mn2R+wsnn944BkKbW6Hz2EhwrruPuxUJpUEQ@mail.gmail.com>
 <xmqqsioxqp9i.fsf@gitster.dls.corp.google.com> <CAD0k6qSUYANxbjjbE4jTW4EeVwOYgBD=bXkSu=akiYC_CB7Ffw@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Marat Radchenko <marat@slonopotamus.org>, 
	msysGit <msysgit@googlegroups.com>, Pat Thoyts <patthoyts@gmail.com>, 
	Nick Hengeveld <nickh@reactrix.com>, GIT Mailing-list <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: msysgit+bncBDR53PPJ7YHRBY6L7KNAKGQEVFNGTHI@googlegroups.com Mon Apr 28 21:03:05 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBY6L7KNAKGQEVFNGTHI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f192.google.com ([209.85.220.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBY6L7KNAKGQEVFNGTHI@googlegroups.com>)
	id 1WeqpR-00064v-74
	for gcvm-msysgit@m.gmane.org; Mon, 28 Apr 2014 21:03:01 +0200
Received: by mail-vc0-f192.google.com with SMTP id ij19sf1677236vcb.19
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Apr 2014 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=1J1wmK5R8/L1baGItsd672XSTGEzMBYZ159XjaRaXO4=;
        b=sLynLo0fOGEiH6kcz2rROnVU6/m2C1BsGxFVVuPXFEcOmJIp2BpF+s6y5Fd8Ke2rhs
         uwuyWmE+XNtih/w9rd0jflUVaAq++yEUmY+AU2l5C921vkKDGXN9uXkoQ9AQbZy/ZyqX
         ytsXC6NZIFZ37lHCKULKFVjJDqOj8GLY/6QdYja+CNYJxFYjJr6cstZRDvZyomhPTI+E
         2SwR4HO9iUXPi/Jv17z1dbvO4eoQP9sRXeYFjoSxA7gERv4jhlN3+kHZHteEUMmMq5eI
         4nULImMVs6yAD5oh9BsJ4bVf0e1XpoV4LEuOTbuVksG3fo5YvE0uiPUpdX76uDEDFK4M
         EHbA==
X-Received: by 10.140.97.182 with SMTP id m51mr80933qge.12.1398711780444;
        Mon, 28 Apr 2014 12:03:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.49.231 with SMTP id q94ls1133368qga.28.gmail; Mon, 28 Apr
 2014 12:02:59 -0700 (PDT)
X-Received: by 10.236.125.6 with SMTP id y6mr12309584yhh.3.1398711779800;
        Mon, 28 Apr 2014 12:02:59 -0700 (PDT)
Received: from mail-ig0-x22a.google.com (mail-ig0-x22a.google.com [2607:f8b0:4001:c05::22a])
        by gmr-mx.google.com with ESMTPS id m3si2364842igk.2.2014.04.28.12.02.59
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 12:02:59 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22a as permitted sender) client-ip=2607:f8b0:4001:c05::22a;
Received: by mail-ig0-f170.google.com with SMTP id uq10so5075886igb.1
        for <msysgit@googlegroups.com>; Mon, 28 Apr 2014 12:02:59 -0700 (PDT)
X-Received: by 10.42.204.197 with SMTP id fn5mr2579369icb.95.1398711779635;
 Mon, 28 Apr 2014 12:02:59 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 12:02:19 -0700 (PDT)
In-Reply-To: <CAD0k6qSUYANxbjjbE4jTW4EeVwOYgBD=bXkSu=akiYC_CB7Ffw@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22a
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247385>

On Mon, Apr 28, 2014 at 8:39 PM, Dave Borowitz <dborowitz@google.com> wrote:
> On Mon, Apr 28, 2014 at 11:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>>> We're using Curl 7.30.0 in msysGit (and thus also Git for Windows), so
>>> we should be able to include it. However, we do not have curl-config
>>> installed.
>>
>> Hmmm, between 2.0-rc0 and 2.0-rc1 there is 61a64fff (Makefile: use
>> curl-config to determine curl flags, 2014-04-15) merged already,
>> which makes this assumption and a claim based on that assumption:
>>
>>     curl-config should always be installed alongside a curl
>>     distribution, and its purpose is to provide flags for building
>>     against libcurl, so use it instead of guessing flags and
>>     dependent libraries.
>>
>> which may make things worse for you guys, unless you are explicitly
>> setting CURLDIR and other Makefile variables.
>
> Yes, I can see that assumption may not always hold. But I'm slightly
> surprised this worked in the first place; are you saying this is a
> system where:
> -curl-config is not installed
> -but -lcurl still works
> -without setting CURLDIR
> ?

Yes, our cURL is installed globally together with the system libraries.

> I think I should probably re-roll the patch to default to the old
> behavior (blind -lcurl) if curl-config returns the empty string, which
> I believe is also the case when the binary is not found.

That sounds like it would work for MsysGit, yeah.

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
