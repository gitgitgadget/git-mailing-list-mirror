From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 00/13] mingw unicode environment
Date: Thu, 17 Jul 2014 20:09:33 +0200
Message-ID: <53C8115D.8040505@gmail.com>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCH3XYXLXQDBBXFCUCPAKGQEJ7D2MOY@googlegroups.com Thu Jul 17 20:09:35 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBXFCUCPAKGQEJ7D2MOY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f188.google.com ([209.85.217.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBXFCUCPAKGQEJ7D2MOY@googlegroups.com>)
	id 1X7q7Y-0004IV-VF
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 20:09:33 +0200
Received: by mail-lb0-f188.google.com with SMTP id 10sf1877lbg.5
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=aDACUmbmgwWmRFeSWugMfSh5eX46++DBwaf0dEQBxTo=;
        b=bSIN+Mnnltnp9k2KPsQPUa7GvIb1IgJqgwem//BUr5KZVECQHu2KglE/jlbBlBfcy9
         irzFLgUsbhzoC7XxfwDTHYQOCKBKUnWrSwXvaBthoMBdKDZXFjt2V90Mr4yvwNuXuEIn
         40vQAVTSXzFuvwtDELZuaYLg+iqQAeEmaIWg3iHjcSrnkpD9U8CV6OtmE/GsHh+LkVvr
         R2XikUqXjzPkAJUgWw4DLCLc5ohpC8dF8cItKoyhE9rcKYmgaoJ/i7I5f22Mo2Whj8Gt
         wklyVLU5rKHfoKuMYtcB8EsXm7mvUMcSIgo581KMLNTIVtg6YxHh3wpKUBaSfYyurpFu
         TV1w==
X-Received: by 10.180.81.34 with SMTP id w2mr101160wix.2.1405620572775;
        Thu, 17 Jul 2014 11:09:32 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.189.76 with SMTP id gg12ls84731wic.42.gmail; Thu, 17 Jul
 2014 11:09:31 -0700 (PDT)
X-Received: by 10.180.90.13 with SMTP id bs13mr7816wib.6.1405620571598;
        Thu, 17 Jul 2014 11:09:31 -0700 (PDT)
Received: from mail-wg0-x22e.google.com (mail-wg0-x22e.google.com [2a00:1450:400c:c00::22e])
        by gmr-mx.google.com with ESMTPS id iz18si1098653wic.3.2014.07.17.11.09.31
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 11:09:31 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22e as permitted sender) client-ip=2a00:1450:400c:c00::22e;
Received: by mail-wg0-f46.google.com with SMTP id m15so2336101wgh.17
        for <msysgit@googlegroups.com>; Thu, 17 Jul 2014 11:09:31 -0700 (PDT)
X-Received: by 10.180.189.234 with SMTP id gl10mr24453257wic.56.1405620571496;
        Thu, 17 Jul 2014 11:09:31 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id n2sm7804109wjf.40.2014.07.17.11.09.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 11:09:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22e
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253765>

Am 17.07.2014 17:37, schrieb Stepan Kasal:
> Hello,
> 
> this is the remainder of Karsten's unicode branch, that is a time
> proven part of msysGit.  (If this code is accepted, only one patch
> would only remain: gitk and git-gui fixes.)
> 

Thank you so much!

I had to add '#include "../cache.h"' to compile, due to use of
ALLOC_GROW and alloc_nr in some of the patches. In the msysgit HEAD,
Erik's hideDotFile patch does that [1].

[1] https://github.com/msysgit/git/commit/d85d2b75

After that (and applying your mingw test fixes), only t7001 fails
(the 'cp -P' issue).

> When rebasing Karsten's work, I have eliminated two commits:
> https://github.com/msysgit/git/commit/f967550
> https://github.com/msysgit/git/commit/290bf81
> 
> These commits only moved code down and up; this was not necessary, one
> forward declaration was all I needed.
> 

I believe we prefer moving code to the right place over forward
declarations (IIRC I got bashed for the latter in one of the first rounds
of this patch series). If only to justify 'git-blame -M' :-D

> One of the patches differs from the original version: "Enable color..."
> Following Karsten's suggestion, I have changed the value of env. var.
> TERM from "winterm" to "cygwin".  This is because the subprocesses see
> the variable and may try to find it in (their copy of) termcap.
> 

Good! One more step towards getting rid of the git-wrapper.

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
