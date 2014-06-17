From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 0/7] Second part of msysgit/unicode
Date: Tue, 17 Jun 2014 11:06:52 +0200
Message-ID: <53A0052C.6040604@gmail.com>
References: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCH3XYXLXQDBBL4KQCOQKGQEZ5O3FBQ@googlegroups.com Tue Jun 17 11:06:57 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBL4KQCOQKGQEZ5O3FBQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f192.google.com ([74.125.82.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBL4KQCOQKGQEZ5O3FBQ@googlegroups.com>)
	id 1WwpM0-0008RS-Jl
	for gcvm-msysgit@m.gmane.org; Tue, 17 Jun 2014 11:06:56 +0200
Received: by mail-we0-f192.google.com with SMTP id u57sf683774wes.19
        for <gcvm-msysgit@m.gmane.org>; Tue, 17 Jun 2014 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=XHpLyn8ZiVpCSSiZcTXOVJ01q9vgUp7IDbGtpyPfF5Q=;
        b=eHZI+RVCHUWjqYaTy7tTp4L72+95Bq9oIP9hTBQSnXgbOHZj+iBn9rxhyRFHVonZHO
         2Dy3giA8dwJ4Z0nOOihL+fWPIVWzYXECK4btCvFrbhnKxX9n5zYVuWqPcLeP1DLwu89X
         zx5en1O0ub80ZfGUyH/EQSQo8tqNIoW0yjiH+vrOmxqrkeRgc1F8yM/yGKgwaDR2JhdA
         2Tovq5nHKaVTHer6VT4ISgi1cGq71CG4YqAdaZ1uzXOLq/hJAotuJzCZ9UGJcYgg/LRU
         q/Kj015AQACJmputNzWjuWqZoMeXbE9lksNqQIZRBOBdwZT2r6dy6bt771IRrjVKD1JI
         IKmA==
X-Received: by 10.180.186.73 with SMTP id fi9mr76588wic.6.1402996016277;
        Tue, 17 Jun 2014 02:06:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.95.194 with SMTP id dm2ls202065wib.53.gmail; Tue, 17 Jun
 2014 02:06:55 -0700 (PDT)
X-Received: by 10.180.13.99 with SMTP id g3mr2048678wic.1.1402996015126;
        Tue, 17 Jun 2014 02:06:55 -0700 (PDT)
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com [2a00:1450:400c:c05::235])
        by gmr-mx.google.com with ESMTPS id x7si896713wiw.1.2014.06.17.02.06.55
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Jun 2014 02:06:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::235 as permitted sender) client-ip=2a00:1450:400c:c05::235;
Received: by mail-wi0-f181.google.com with SMTP id n3so5393368wiv.14
        for <msysgit@googlegroups.com>; Tue, 17 Jun 2014 02:06:55 -0700 (PDT)
X-Received: by 10.180.210.174 with SMTP id mv14mr34549644wic.47.1402996015044;
        Tue, 17 Jun 2014 02:06:55 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id u10sm19042154wix.11.2014.06.17.02.06.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Jun 2014 02:06:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::235
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251853>

Am 11.06.2014 11:37, schrieb Stepan Kasal:
> This is the second part of the time-proven unicode suport branch from msysgit.
> This batch is a collection of small independent changes, limited to mingw.c.
> The only exception is the last patch: it changes gitk and git-gui.
> 

I'm missing the other two "Unicode file name" patches (and "Win32: fix detection
of empty directories in is_dir_empty", probably squashed). If gitk and git-gui
expect file names to be UTF-8, git.exe should do so as well, don't you think?

Otherwise OK (and AFAICT, there's only environment stuff left).

>   Win32: Unicode arguments (incoming)

Note: This depends on "MSVC: link dynamically to the CRT", which was sent
separately (and is already in master - good).

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
