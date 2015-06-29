From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: 4th release candidate of Git for Windows 2.x, was Re: 3rd
 release candidate of Git for Windows 2.x
Date: Mon, 29 Jun 2015 10:30:49 +0200
Organization: gmx
Message-ID: <8224736a18724f751312d57e67967d69@www.dscho.org>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
 <b085dab2e617742b690ccb99ba4a3076@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>, msysgit@googlegroups.com,
 git-for-windows@googlegroups.com
X-From: msysgit+bncBCZPH74Q5YNRBPEEYSWAKGQEAC7G6QA@googlegroups.com Mon Jun 29 10:30:54 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBPEEYSWAKGQEAC7G6QA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f57.google.com ([74.125.82.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBPEEYSWAKGQEAC7G6QA@googlegroups.com>)
	id 1Z9USr-0002fP-Jv
	for gcvm-msysgit@m.gmane.org; Mon, 29 Jun 2015 10:30:53 +0200
Received: by wggx12 with SMTP id x12sf43832553wgg.1
        for <gcvm-msysgit@m.gmane.org>; Mon, 29 Jun 2015 01:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=rpQvuFx86+FqtkxkpfueWkNjqi7u/bBPqDPfqNb2UgM=;
        b=yV7HV+tsKgbvb8byZhrspIJ9on4DGIM7MXL71515bWt0LJvqEsOUlS9Dyc4Pmrngqp
         V//lJDFd6BYYMyLHNpgCWAsGGYa2uz/dBcjN9btyhCvGd1mi5n8PFBHnO+y0NPHuKzAf
         lkY+38FNr+I4jX9+eyT1CysJ/sDeJ6gDQbWkGH3UesiuwU6R+W+VAeGt/v2BRGeAx6dP
         v9EO9x4P+U2V6TaD01Q+gWJ0Q5jch/vggF/YI9Bk500f12GZJ10CpBuq+GMrwVa+tZsD
         WGRe2Jmd6EmsYqOu41jXcMtYi14uh7IFgCYFrHkBUCtkSFO8yijjUidUyGnvpqOgtY64
         hWlQ==
X-Received: by 10.152.8.39 with SMTP id o7mr116174laa.3.1435566653294;
        Mon, 29 Jun 2015 01:30:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.21.230 with SMTP id y6ls414570lae.20.gmail; Mon, 29 Jun
 2015 01:30:51 -0700 (PDT)
X-Received: by 10.112.203.168 with SMTP id kr8mr10177648lbc.10.1435566651870;
        Mon, 29 Jun 2015 01:30:51 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id ec7si354350wib.3.2015.06.29.01.30.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2015 01:30:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0ML7NR-1Z9DTv1V2H-000Ngn; Mon, 29 Jun 2015 10:30:50
 +0200
In-Reply-To: <b085dab2e617742b690ccb99ba4a3076@www.dscho.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:PT+WHki+ds5nmEqaB6JFg5bKDuMPrUjsk+Ou093PbmaH7VcD7pa
 uD7633M3bTnuSOW41Vk3QAEKzbiPOamae3oNg7x0HVUudufoBFBUG89TlHUKCWtysKCZXgX
 msNL1Wzd9Z1BED5WoL/RCN5SRP1aNKWNN2a3Xd5rmdlDxlWWNSUoyXxjXlVBM87kpURBpAO
 0JjpmoYZZOiY0h3gvEpCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FJAdh5oNBGY=:Ear2/GXFdb5LNdy02anBN+
 lBSqlv2tah21g4ygivElBoKENqmuZ5+LgLvFKEDeVVzwibPbz+l5LKj5gSQ1JXqMPrQ0ZAWqQ
 NPKq7+sxd2UqOUikNSI7fi0BCzHEGi953fZfJQHdzI6LllZN6FshgdmYWSnkzEXsKMUSo6vm2
 hvS6QUA3KjUQ8Ywc29zlNtS3QJPlr77Yc/ZcX24bEq8ikqpVFfW3N2sfKtrUVSIl4lVae4sLC
 FHsQTOoa1ybvK7Rg+JiE5med+zTUQ87xfjta9Gn1QHBHphJ0QJo64F8OnqTGoi1Rke7FLzO2S
 9xAQujnTo2ybbUlOkWX+EOYsHwg1Uhz4uF6qGSnxGq5ODisDULIgLS/SnRJFhoBiKs7yXwQhp
 OZSbB0fvPz158BnMrInN7UNdDTFn/vFIN7uGf8H+FdT4PTX4mEC7IfYgP2Xa64i2uDsMelSe1
 6XI2ojFh7Lfdw7U2V4kOhmGc0FIdKjadLHNRWMwU7Y6lU33f/4G/WwNoE9jjIbCfm2FKvLsp9
 xwQCBRAPn+DM7hWPXrW/qXGlj4S/tlf0h288SaLDCpHcEhzpNcTi5A/sdEkMnzwk9pGtFakPj
 lBBJqIosR0r/y2DIbStSKu/twlLw9ZtZuNoBXa35JJsce6n+VyWM594xqllG0b3/b3p+cTYVp
 2zEwi0h8PxU1ViEi3PA1zzvqr7vKEzcWdMexoe7bNR9xon7JBABU1vMQqENn+bj5XTAs=
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.18 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272944>

Hi all,

I just uploaded the 4th release candidate for the upcoming Git for
Windows 2.x release. Please find the download link here:
 
https://git-for-windows.github.io/#download

The most important changes are the update to Git 2.4.5 and a fix for the crash when running Git Bash with a legacy `TERM` setting (this should help 3rd party software to upgrade to Git for Windows 2.x).

Please find the release notes here:

https://github.com/git-for-windows/build-extra/blob/master/installer/ReleaseNotes.md

Another step,
Johannes

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
