From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v2 0/2] improve-wincred-compatibility
Date: Tue, 26 Feb 2013 00:39:07 +0100
Message-ID: <512BF61B.4020708@dcon.de>
References: <50E73B80.4070105@gmail.com> <CABPQNSYcOrOZJd0vK=4ESC4qPpcj7RRdhVt3R0dAE-ouhOb5YA@mail.gmail.com> <50EC473A.6060203@gmail.com> <CABPQNSb7MjTKgmeB9TcUV0+-FfjPZ1sgKPsfVDg6+uaw2f_azQ@mail.gmail.com> <50EEAF9A.6020302@gmail.com> <CABPQNSaUizZPVOeeuEyb=o-Qmm4mYCRxV27qkmp62cSpFkinqA@mail.gmail.com> <7vsj4k3nbu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: kusmabite@gmail.com, git@vger.kernel.org, msysgit@googlegroups.com, 
 Jeff King <peff@peff.net>,
 patthoyts@gmail.com, Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBBG7MV6EQKGQEFA5XIVA@googlegroups.com Tue Feb 26 00:39:33 2013
Return-path: <msysgit+bncBCH3XYXLXQDBBG7MV6EQKGQEFA5XIVA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f55.google.com ([209.85.161.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBG7MV6EQKGQEFA5XIVA@googlegroups.com>)
	id 1UA7do-00088p-OB
	for gcvm-msysgit@m.gmane.org; Tue, 26 Feb 2013 00:39:28 +0100
Received: by mail-fa0-f55.google.com with SMTP id t1sf1349302fae.20
        for <gcvm-msysgit@m.gmane.org>; Mon, 25 Feb 2013 15:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=6atiqq/jzpeaFlpyuB7zD+/eetkkbm+SO0mPmB+csbQ=;
        b=H/e9fW3dkJpHy8gicvZ+m8uHJ/CBNC4mHRQ4g0FNGxl2hxZcedGE29HtVBmMQy+iUm
         nPrqHmZUUXEC7P4uZ0tMGelo+wmQYmjj3vcvsztHy59B+J0Sb8RGF7iDhje4wTVgCFs6
         KAqnax5r29uzS9DOuYQTQPmDXokWckYNGWYXUcyTIpDG3GQqTAkH+ob9lHbtMwCKQR4I
         CyK8XhcvZnUQsoIOEVSrn82ijUypPbZXtffL1wBVq+QxUyn9Rs/uc13F9pKyP4WC4Fvu
         eqT5BR+U6/eClnzaBqE1TGfQfpWD+Q 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=6atiqq/jzpeaFlpyuB7zD+/eetkkbm+SO0mPmB+csbQ=;
        b=nuk9VJw1sKrbCfpUYZ3NIujBbp+Qjf0egf3qFbL1eLgsoIgdjIzsaVga0PSYDgjnyZ
         8AMTVREpbYiM0LKkJJ1SwKWHTpZJjQkOC1X7dUnKjIP6okFdGlPPSmBJOs+dp+NQzJRx
         jhV3raz3E/6V7SQHAqlAlPG/aKcG24DsdQfbcFHdX2N3m/Yz1wtAvDEFN7/agCmmJCmI
         sUK8VG+RdSDHb/7zY0CW8VWO1gZttKevXLnBmoWV4kkMqvoXNfa5tDLFkfZNMJv+TbCO
         u2bLwaeKU1sNdUNlEQ7Elt8lpYCKpiPkpYPCA 
X-Received: by 10.180.20.68 with SMTP id l4mr1229306wie.7.1361835547858;
        Mon, 25 Feb 2013 15:39:07 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.73.79 with SMTP id j15ls86541wiv.7.canary; Mon, 25 Feb
 2013 15:39:06 -0800 (PST)
X-Received: by 10.14.184.9 with SMTP id r9mr14132644eem.7.1361835546738;
        Mon, 25 Feb 2013 15:39:06 -0800 (PST)
X-Received: by 10.14.184.9 with SMTP id r9mr14132642eem.7.1361835546728;
        Mon, 25 Feb 2013 15:39:06 -0800 (PST)
Received: from mail-ee0-f68.google.com (mail-ee0-f68.google.com [74.125.83.68])
        by gmr-mx.google.com with ESMTPS id 47si3850895eeh.1.2013.02.25.15.39.06
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 25 Feb 2013 15:39:06 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 74.125.83.68 as permitted sender) client-ip=74.125.83.68;
Received: by mail-ee0-f68.google.com with SMTP id c50so946774eek.3
        for <msysgit@googlegroups.com>; Mon, 25 Feb 2013 15:39:06 -0800 (PST)
X-Received: by 10.14.184.68 with SMTP id r44mr43504284eem.40.1361835546598;
        Mon, 25 Feb 2013 15:39:06 -0800 (PST)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id r4sm20732723eeo.12.2013.02.25.15.39.04
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 25 Feb 2013 15:39:05 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <7vsj4k3nbu.fsf@alter.siamese.dyndns.org>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 74.125.83.68 as
 permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217118>

Am 25.02.2013 07:43, schrieb Junio C Hamano:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
> 
>> On Thu, Jan 10, 2013 at 1:10 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
>>> Changes since initial version (see attached diff for details):
>>> - split in two patches
>>> - removed unused variables
>>> - improved the dll error message
>>> - changed ?: to if else
>>> - added comments
>>>
>>> Also available here:
>>> https://github.com/kblees/git/tree/kb/improve-wincred-compatibility-v2
>>> git pull git://github.com/kblees/git.git kb/improve-wincred-compatibility-v2
>>>
>>> Karsten Blees (2):
>>>   wincred: accept CRLF on stdin to simplify console usage
>>>   wincred: improve compatibility with windows versions
>>>
>>>  .../credential/wincred/git-credential-wincred.c    | 206 ++++++++-------------
>>>  1 file changed, 75 insertions(+), 131 deletions(-)
>>>
>>
>> Wonderful!
>>
>> Acked-by: Erik Faye-Lund <kusmabite@gmail.com>
> 
> I'm in the "marking leftover bits" mode today, and noticed that
> nothing happened for this topic in my tree. Did msysgit folks expect
> me to pick this up directly, or did you guys want to feed this series
> to me (with possibly other changes you worked on outside this list)?
> 

The second patch changes the credential format in a backward-incompatible way, so I think this should be in git.git, too (better than having two incompatible versions around).

@Pat, Dscho: the rebase-merge script should automatically drop patches found in upstream, correct?

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
For more options, visit https://groups.google.com/groups/opt_out.
