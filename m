From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Re: [PATCH 0/7] Second part of msysgit/unicode
Date: Wed, 18 Jun 2014 23:35:12 +0200
Message-ID: <53A20610.80500@kdbg.org>
References: <1402479466-8500-1-git-send-email-kasal@ucw.cz>	<53A0052C.6040604@gmail.com> <20140618030507.GA3809@camelia.ucw.cz> <xmqq7g4ejf6y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>, Karsten Blees <karsten.blees@gmail.com>, 
 GIT Mailing-list <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCJYV6HBKQIJHDEITUCRUBGSCXIRU@googlegroups.com Wed Jun 18 23:35:17 2014
Return-path: <msysgit+bncBCJYV6HBKQIJHDEITUCRUBGSCXIRU@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f60.google.com ([74.125.82.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIJHDEITUCRUBGSCXIRU@googlegroups.com>)
	id 1WxNVk-00053F-Qe
	for gcvm-msysgit@m.gmane.org; Wed, 18 Jun 2014 23:35:16 +0200
Received: by mail-wg0-f60.google.com with SMTP id n12sf171500wgh.5
        for <gcvm-msysgit@m.gmane.org>; Wed, 18 Jun 2014 14:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=JR5IF8X3US4+gec1HUdszbYrTYNUtZVOmr8l8G5qX7o=;
        b=ZyTU5q2j+naH2JhxD1TVMBSA5XT5xgt3C+8WKZYEvPFw6zH31yNEW3nF6S+PPwrHM9
         ncQvt+Mh//4tsADu3fFGmsm5T73TMoXuWXkpV+7NWwItsTcm8WQceBqVvgbYF4CgaZkG
         SkiSABcTjiVFTlWyyyC0Qsv4wbai+NkFstMaRQX9f11y8MeWjV3fn7rwrUv4tskq7hTC
         XJ7dWoiKcP1gCF8vHTwgvYU+0mPo161j06StFcRZuAXPOmUgYkaJY++gj33FugTgtXmD
         /PTt9F6FzxeAMAyuKt/cM4xtJnBoCz/VnY+eeIU/nbx/XKbs+affPYwv4QqxScn3c+Jg
         m/Jg==
X-Received: by 10.152.28.101 with SMTP id a5mr7668lah.4.1403127316483;
        Wed, 18 Jun 2014 14:35:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.21.166 with SMTP id w6ls60778lae.29.gmail; Wed, 18 Jun
 2014 14:35:15 -0700 (PDT)
X-Received: by 10.152.203.199 with SMTP id ks7mr71765lac.0.1403127315631;
        Wed, 18 Jun 2014 14:35:15 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp2.bon.at. [213.33.87.16])
        by gmr-mx.google.com with ESMTPS id ck3si1259869wib.0.2014.06.18.14.35.15
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 14:35:15 -0700 (PDT)
Received-SPF: none (google.com: j6t@kdbg.org does not designate permitted sender hosts) client-ip=213.33.87.16;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9FBD2A7EB4;
	Wed, 18 Jun 2014 23:35:14 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id DF09319F450;
	Wed, 18 Jun 2014 23:35:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqq7g4ejf6y.fsf@gitster.dls.corp.google.com>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: j6t@kdbg.org does not designate permitted sender hosts) smtp.mail=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252072>

Am 18.06.2014 19:33, schrieb Junio C Hamano:
> In the meantime, are Windows folks happy with the four topics queued
> on 'pu' so far?  I would like to start moving them down to 'next'
> and to 'master' soonish.
> 
> They consist of these individual patches:
> 
>     $ git shortlog ^master \
>       sk/mingw-dirent \
>       sk/mingw-main \
>       sk/mingw-uni-console \
>       sk/mingw-unicode-spawn-args

Topic sk/test-cmp-bin revealed a new breakage in t5000-tar-tree,
specifically, the penultimate test "remote tar.gz is allowed by
default". I have yet to find out what it is (I suspect a LF-CRLF
conversion issue) and whether it is in connection with one of these topics.

I haven't had a chance to test the topics in the field. In particular, I
have a few files with Shift-JIS content (but ASCII file names), and I
would like to see how well I fare with the unicode topics in this situation.

-- Hannes

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
