From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Same test-path-utils behaves differently on different
 Windows systems
Date: Thu, 10 Oct 2013 22:27:00 +0200
Message-ID: <CAHGBnuO_yDuv5b1r8imWKgRcN7hjcidg+Uv-jD8LOkJD-Mtn+w@mail.gmail.com>
References: <CAHGBnuNaVWxa2kNqf3n9GmZZxFryLfJqKB5TxmDK5BiG5x53VQ@mail.gmail.com>
	<CAHGBnuORD-nTaYVVMt5WJhFnHU4oj0=5WiLXMAMa2Y4mz-vNXg@mail.gmail.com>
	<5256EA82.7020504@kdbg.org>
	<CAHGBnuO8ATSQu6HpJTm8bBg0akm+LUsZGRFoZPhzs89q7gTWqQ@mail.gmail.com>
	<52570860.3060503@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: worldhello.net@gmail.com, Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
	Git Mailing List <git@vger.kernel.org>, msysGit Mailinglist <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBDZMLEGXWQLBBFE33SJAKGQE5DP6CBQ@googlegroups.com Thu Oct 10 22:27:02 2013
Return-path: <msysgit+bncBDZMLEGXWQLBBFE33SJAKGQE5DP6CBQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f63.google.com ([74.125.83.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBBFE33SJAKGQE5DP6CBQ@googlegroups.com>)
	id 1VUMp3-0007P2-Dg
	for gcvm-msysgit@m.gmane.org; Thu, 10 Oct 2013 22:27:01 +0200
Received: by mail-ee0-f63.google.com with SMTP id c50sf294058eek.28
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Oct 2013 13:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=a8BtEmIuvCvVK0p3atPqnhu+kKOafWGWV/XnJ9O+1R4=;
        b=d/C0nCCxKAqzmm1H91LBEYJMj3f4AMGFEpoYV77ULU2W5ZVWMhJwg/m0h+Z2YQp/Os
         ZexUg7x2OcIDUEWL5fnNFAiIZo7G+j4Mv31eLRKc5vQ2ACX3b9wi1Z0xyXvCzt03ZHlr
         zOR9hyWik6RMqeCMbxsIXk5bYX6VoxQvrC7sJ7xe08N/e0FRpRc24p/vdVTSb9FdgEES
         etyYhsuZIMjx4zcaTp04phx8hrtt+wCdx5opIY4+SlOcScPSivz7Zk9OAzwfeag5dyOe
         epWBatZ0DKP7CJ5ROZfoqFCvdFjdkbSM+YURkLWw53wOCj7ar8ashisIGCJnACIuDpbq
         5B7w==
X-Received: by 10.180.87.101 with SMTP id w5mr3023wiz.5.1381436821159;
        Thu, 10 Oct 2013 13:27:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.188.100 with SMTP id fz4ls33801wic.29.gmail; Thu, 10 Oct
 2013 13:27:00 -0700 (PDT)
X-Received: by 10.180.126.99 with SMTP id mx3mr90239wib.2.1381436820261;
        Thu, 10 Oct 2013 13:27:00 -0700 (PDT)
Received: from mail-la0-x22b.google.com (mail-la0-x22b.google.com [2a00:1450:4010:c03::22b])
        by gmr-mx.google.com with ESMTPS id ra8si4068234bkb.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 13:27:00 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c03::22b as permitted sender) client-ip=2a00:1450:4010:c03::22b;
Received: by mail-la0-x22b.google.com with SMTP id ep20so2550001lab.2
        for <msysgit@googlegroups.com>; Thu, 10 Oct 2013 13:27:00 -0700 (PDT)
X-Received: by 10.112.29.17 with SMTP id f17mr2851694lbh.45.1381436820130;
 Thu, 10 Oct 2013 13:27:00 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Thu, 10 Oct 2013 13:27:00 -0700 (PDT)
In-Reply-To: <52570860.3060503@kdbg.org>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c03::22b
 as permitted sender) smtp.mail=sschuberth@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235880>

On Thu, Oct 10, 2013 at 10:04 PM, Johannes Sixt <j6t@kdbg.org> wrote:

>> So the obvious thing would be to replace /a/b/ with
>> /foo/bar/ in the tests, but that just masks the problem, or?
>
> The strange behavior is not a problem in Git, it is a problem of MSYS.
> Using /foo/bar instead of /a/b in Git's test suite is a reasonable
> work-around.
>
> If you mean that you get ../../C:/something from the relative_path
> computation, that *is* a problem in Git, which is addressed by the topic
> jx/relative-path-regression-fix.

Thanks for pointing out that topic to me. As it turn out, it already
has a commit to use /foo/bar instead of /a/b [1]. However, it again
mixes up MSYS with MinGW in several places. I'll reply to the patch
mails.

[1] https://github.com/gitster/git/commit/15b0ae73520895caffc2eb65732dbf618fb22c62

-- 
Sebastian Schuberth

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
