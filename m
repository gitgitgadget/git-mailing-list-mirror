From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Topic sk/mingw-unicode-spawn-args breaks tests
Date: Fri, 11 Jul 2014 21:49:15 +0200
Message-ID: <53C03FBB.1080807@gmail.com>
References: <53BEF21E.9090007@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>, Git Mailing List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBCH3XYXLXQDBBOX7QCPAKGQE235F2OQ@googlegroups.com Fri Jul 11 21:49:20 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBOX7QCPAKGQE235F2OQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f192.google.com ([74.125.82.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBOX7QCPAKGQE235F2OQ@googlegroups.com>)
	id 1X5gop-0002Jb-2S
	for gcvm-msysgit@m.gmane.org; Fri, 11 Jul 2014 21:49:19 +0200
Received: by mail-we0-f192.google.com with SMTP id u57sf150921wes.19
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 12:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=XZU4oFvTyiunHcdG0gDZfIk8sfJWXaM+GFNbGvhb6CE=;
        b=VOwRERp65FPOBhwVW0MnYJJgPIdzHvDuEqFP1KxQ2y8lOeL5xV7GlY2vvWIxNQf5wO
         PVvSIdOdWzb9TWgkgyHXjc/AMylJaRKHDyBajEj3mBuiPbf6i8EFcomKGtBzz05/TdaD
         ynQB5ythHyc6ATtS+uXao5Mk3AHfD1CpWgT/99IOVvhXhkRpl6ZdUJnDi9rWcRHCpWRa
         Iqxbu17OPVLAzm2soXs9t9X71Ta0nVRlPx8WAyJzOiiwlOEKMBkCtxk0kQZf4ZpqEZKF
         0McfQYFnfYCSrL03YvaNI4Mpdlf5Dx+pnIoqcm+dVN7OypCdhPTelkSeLiWpJYPO2/di
         7ljA==
X-Received: by 10.152.36.37 with SMTP id n5mr10251laj.3.1405108155550;
        Fri, 11 Jul 2014 12:49:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.216.135 with SMTP id oq7ls92605lac.39.gmail; Fri, 11 Jul
 2014 12:49:14 -0700 (PDT)
X-Received: by 10.112.54.169 with SMTP id k9mr94050lbp.1.1405108154449;
        Fri, 11 Jul 2014 12:49:14 -0700 (PDT)
Received: from mail-wi0-x236.google.com (mail-wi0-x236.google.com [2a00:1450:400c:c05::236])
        by gmr-mx.google.com with ESMTPS id b9si255894wic.2.2014.07.11.12.49.14
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 12:49:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::236 as permitted sender) client-ip=2a00:1450:400c:c05::236;
Received: by mail-wi0-f182.google.com with SMTP id d1so226750wiv.3
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 12:49:14 -0700 (PDT)
X-Received: by 10.194.63.228 with SMTP id j4mr1238452wjs.7.1405108154358;
        Fri, 11 Jul 2014 12:49:14 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ec8sm10776528wic.10.2014.07.11.12.49.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 12:49:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53BEF21E.9090007@kdbg.org>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::236
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253319>

Am 10.07.2014 22:05, schrieb Johannes Sixt:
> It looks like I totally missed the topic sk/mingw-unicode-spawn-args.
> Now it's in master, and it breaks lots of test cases for me:
> 
> t0050-filesystem
> t0110-urlmatch-normalization
> t4014-format-patch
> t4041-diff-submodule-option
> t4120-apply-popt
> t4201-shortlog
> t4205-log-pretty-formats
> t4209-log-pickaxe
> t4210-log-i18n
> (I killed the test run here)
> 
> Am I doing something wrong? Does the topic depend on a particular
> version of MSYS (or DLL)?
> 
> -- Hannes
> 

After commenting out fchmod in config.c, I get similar results.

At first glance, t0050 seems to fail because the unicode file
name patches are still missing.

t4041 tries to pass ISO-8859-1 encoded bytes on the command line,
which simply doesn't work on Windows (all OS APIs 'talk' UTF-16).
We have a fix for this in the msysgit fork [1] (but unfortunately
in another branch, so Stepan couldn't know the patch is related).

I suspect the other failures also fall in these two categories.

[1] https://github.com/msysgit/git/commit/ef4a733c

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
