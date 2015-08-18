From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Git for Windows 2.5.0
Date: Tue, 18 Aug 2015 18:30:04 +0200
Organization: gmx
Message-ID: <654220c3a9a816244094a1672fa087bf@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>, msysgit@googlegroups.com,
 git-for-windows@googlegroups.com
X-From: msysgit+bncBCZPH74Q5YNRBEN3ZWXAKGQEHWGM2SY@googlegroups.com Tue Aug 18 18:30:13 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBEN3ZWXAKGQEHWGM2SY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBEN3ZWXAKGQEHWGM2SY@googlegroups.com>)
	id 1ZRjm6-00047b-SH
	for gcvm-msysgit@m.gmane.org; Tue, 18 Aug 2015 18:30:10 +0200
Received: by wicxr16 with SMTP id xr16sf21811223wic.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 18 Aug 2015 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:subject:organization
         :message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=B1AvJ67J849RdbFUk8vC8lp9zqfzwuMl+louDZtglSw=;
        b=CE0aodp4KepZgEFY4+Ikk0zO8nXH8JY8rwsuaZtSJVGQPdftdSnu03RXuXa3vhQsMR
         o0UBPLWRrVDJ4CcLssD8lcEoRbACyfqEwQgGeYs03QUNavFCQJBNM+JiVQQxH+SLw4LV
         NprOk7n8+JTl4ncE4c3irZtIyO9aESqNncfOYhxsLHQbd310HX+EtEqc1lTIPoSabzZk
         49W+i8tCMrc53r+rLnVK25xp8gZqQFccHYN/lxz34an8sJF4heuI+ttdZeLvBGGbUXMe
         GNbOCTi49w7dmdOKgum96eOhg2wlvwhEsQPBi4wK5EXe8vUuBOkNCIkCmmmYRLVAz215
         NZVQ==
X-Received: by 10.152.180.235 with SMTP id dr11mr48569lac.23.1439915410568;
        Tue, 18 Aug 2015 09:30:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.26.65 with SMTP id j1ls812630lag.39.gmail; Tue, 18 Aug
 2015 09:30:09 -0700 (PDT)
X-Received: by 10.112.149.39 with SMTP id tx7mr2055769lbb.11.1439915409264;
        Tue, 18 Aug 2015 09:30:09 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id jv9si509674wid.0.2015.08.18.09.30.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2015 09:30:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MeMOx-1Z87G629ol-00Q8GK; Tue, 18 Aug 2015 18:30:05
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:vnc7NkRWB9uYkl+MINfpYlFMVI40nYgJdGWBXdMxU72YzpfhtGw
 Gpd9YMPovQZJpLEp6mbl3oQStQsi2y+kbNglHs6hxtf5vz8u0Ij3Ie04jJcfB8C9ZYi7yIc
 7KBJq1BWaon/Go4WpDrtIdaZlojWt5lJXMPv50Z9S8Iz41RsNduY5OMbDb5dEqxy+1hiM6J
 yb5id4UKWlNj91d1t3Egg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wa4MdopFU3g=:JK+S0zAQfMHkpXuZAmW2Xg
 zHKg4bmidbC4yCHdsvUcUzPIgQbOvFwJPCLxTdOb9JwGX6i4Q9sQQXRgCEu41x/gw3dQuC7no
 uM1Q23liUY6owO6e1Q+G19VwSKRXu3I9xKedeU/sDFqGGxTGwacx0ILgaHPx+K8cqVy1sGWuX
 FzNg1g9BvM4WagVR0/AgSreGv+QJME9mCSEVY1EJhWq8EDlzgtEtsnc+lL6eLh8YKJewaoZVU
 kk8v8EKnKQhbJ1kiNPT0oDen1DvCClOJ327xW/gskTpUd6RpD/rIOwWlmDSXnanfKXk5lriYP
 oVMEcx51XGDS4icOEyqnCNLEH72gx1ftigX4WvOBBmo/3jqmjFMdIMoxnqhsRzEcNWfcMSejt
 1bYOwDIhUXtfktOPpPhGsUHHGvM0DJN1da/LVEu/Vh1jjYXs94Mky8u1Uk48S6HT0zHVas4Vp
 CGXPk1X2nC3VAoCFquDAdCDdewkFKapa2WehfSFZ9PNpyGkRrclXgEEyPBKQX3UV+mjzdzT9c
 SZ3u6LKYCoixjVeiTjUYL2gH4RKEEpLX879Tp7JXywbdIlszoWVe0iKldoeHi+a8DjqKYr4Wh
 C9yjuwBJizWvJc8PTNHRe7/Du7WY4LaoQhq/SEGuedAbPn4JEzd+GQDyV4ki1rGcaJWW30Nul
 i+AKvQrelTIhkom0QL1clS1dXpS0SMuVOsoTpeTr0Hz1+tHexWbwSvO2TAxV77jbTtciV2UHS
 zMBXal0ryQqnEzhf2Hdwrs3aDeUwH1N7xAtfDQ==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as
 permitted sender) smtp.mailfrom=johannes.schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276128>

Dear Git (for Windows) users,

it is my great pleasure to announce the first official version of Git for
Windows. We finally have caught up with Git 2.x and are ready to leave the
-preview suffix behind (more on that below).

It is available at https://git-for-windows.github.io/ and also at https://git-scm.com/.

So how does that affect you?

- The biggest benefit is that we finally have a 64-bit Git for Windows. This
  not only makes a huge difference with large repositories; It also avoids
  some bugs (if you are interested in technical details, please have a look
  at https://github.com/git-for-windows/git/wiki/32-bit-issues).

- Another huge benefit is that we benefit from (and contribute to) the very
  active MSys2 community; MSys2 is a minimal POSIX system (forked from
  Cygwin) that sports a package manager and many packages that are kept
  up-to-date.

- As a consequence of basing Git for Windows on MSys2's packages, Git for
  Windows now comes with up-to-date versions of Bash and OpenSSL. Oh, and
  we finally have support in `git svn` for recent Subversion features!

- Since there were not many users of Git Cheetah, the Explorer extension
  similar to TortoiseSVN, and since there is the actively maintained
  TortoiseGit, Git for Windows dropped support for Git Cheetah.

- Git for Windows will be maintained more actively from now on, following
  Git development more closely. And of course, contributions are welcome!

- GitHub for Windows is slated to integrate this new version soon and will
  continue to follow Git for Windows' development closely.

I probably forgot to mention some really important improvements, so feel
free to point them out as replies to this mail.

Work on upgrading Git for Windows to use MSys2 and follow Git 2.x has been a
lot of work that has been going on since the end of January. It would not have
been possible without substantial support of GitHub, in particular Michael
Haggerty, Jeff King and Brendan Forster, the help of Karsten Blees, Nalla,
Sebastian Schuberth, and other contributors. The maintenance of Git for
Windows is supported by Microsoft from now on.

I would like to take the opportunity to thank above-mentioned developers and
companies: this is your release just as much as it is mine.

Ciao,
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
