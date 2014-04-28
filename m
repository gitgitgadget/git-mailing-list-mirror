From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: git version 1.9.0 missing git-http-push?
Date: Mon, 28 Apr 2014 15:53:58 +0200
Message-ID: <CABPQNSYuoTP6wyQQs5dm5y+3++4m7__c3QZtLTb76=zREWE4Bg@mail.gmail.com>
References: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local>
 <1398670610456-7608792.post@n2.nabble.com> <CABPQNSY-bM2pv7mn2R+wsnn944BkKbW6Hz2EhwrruPuxUJpUEQ@mail.gmail.com>
 <CABPQNSZh1GePGwm6_cC9Zf7N1LaeiavbnOxG4JoWMAab4GcfQQ@mail.gmail.com>
 <alpine.DEB.1.00.1404281519060.14982@s15462909.onlinehome-server.info> <20140428134742.GA18447@seldon>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, msysGit <msysgit@googlegroups.com>, 
	Pat Thoyts <patthoyts@gmail.com>, GIT Mailing-list <git@vger.kernel.org>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBDR53PPJ7YHRBI537GNAKGQE2ARFEAI@googlegroups.com Mon Apr 28 15:54:46 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBI537GNAKGQE2ARFEAI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f190.google.com ([209.85.216.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBI537GNAKGQE2ARFEAI@googlegroups.com>)
	id 1Wem16-00071n-U4
	for gcvm-msysgit@m.gmane.org; Mon, 28 Apr 2014 15:54:45 +0200
Received: by mail-qc0-f190.google.com with SMTP id w7sf1582695qcr.27
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Apr 2014 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=8DwnqJqh8LK9rLC2drGrqBXQSZGldNazxVxzME+zTsU=;
        b=X7wfqW2SE6lDVCb3YddqaUCPnD5XqC638zYp/s+QoK4S3zDHpeJX/4m4nh6vMJnTBE
         CjfDZxZa9j10iW5cm5Rb/o9VbHRXek9RpfEwkupRx08Pdkw5bSVVbi3zklTtm2dMVbrE
         uKU5f108iwR/Ln2i6EDx8LuQkLYFppBd4IUwRXoWq7iDX0ZpwETnZAnBUEN303mZUxVC
         frftIUXq0TMy5hasRWiThIJZ6Ud3RzIMQBDIEhqqFutHGizcl4RxsYZUIB9VSrMX1K9b
         3Znai3PN5xndfSFg2ypds6XvpDHi/6Jgydyr3B+9zsryeJVu5lD71AiNLxEtCzWVR0Xk
         pd3w==
X-Received: by 10.140.86.50 with SMTP id o47mr5960qgd.40.1398693284178;
        Mon, 28 Apr 2014 06:54:44 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.36.33 with SMTP id o30ls2571413qgo.23.gmail; Mon, 28 Apr
 2014 06:54:38 -0700 (PDT)
X-Received: by 10.236.128.112 with SMTP id e76mr11721492yhi.38.1398693278407;
        Mon, 28 Apr 2014 06:54:38 -0700 (PDT)
Received: from mail-ie0-x235.google.com (mail-ie0-x235.google.com [2607:f8b0:4001:c03::235])
        by gmr-mx.google.com with ESMTPS id m3si2091713igk.2.2014.04.28.06.54.38
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 06:54:38 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::235 as permitted sender) client-ip=2607:f8b0:4001:c03::235;
Received: by mail-ie0-f181.google.com with SMTP id y20so4656458ier.40
        for <msysgit@googlegroups.com>; Mon, 28 Apr 2014 06:54:38 -0700 (PDT)
X-Received: by 10.50.36.66 with SMTP id o2mr23803649igj.24.1398693278276; Mon,
 28 Apr 2014 06:54:38 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 06:53:58 -0700 (PDT)
In-Reply-To: <20140428134742.GA18447@seldon>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::235
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247337>

On Mon, Apr 28, 2014 at 3:47 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> On Mon, Apr 28, 2014 at 03:20:46PM +0200, Johannes Schindelin wrote:
>> That way, upstream Git does not have anything to change (and we avoid
>> discussing five versions of essentially the same patch :-P).
>
> This bug isn't specific to msysGit but also affects all environments
> where curl-config is not available or cannot be run for some reason,
> for example during cross-compilation.

True. I think the assumption simply was a bad one, and it has probably
gone unnoticed for a while because pushing over WebDAV is not all that
common.

If anyone turns up a system with an old enough libcurl, they should
probably consult curlver.h instead. And if so, they are probably on a
system so crippled they need to run automake anyway.

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
