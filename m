From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] MinGW(-W64) compilation
Date: Wed, 8 Oct 2014 11:40:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410081139330.990@s15462909.onlinehome-server.info>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCZPH74Q5YNRBGUN2SQQKGQEQMGC5JA@googlegroups.com Wed Oct 08 11:40:45 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBGUN2SQQKGQEQMGC5JA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f188.google.com ([209.85.217.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBGUN2SQQKGQEQMGC5JA@googlegroups.com>)
	id 1Xbnjf-0007U8-V9
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 11:40:44 +0200
Received: by mail-lb0-f188.google.com with SMTP id 10sf738212lbg.25
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=V8hXW0DdEiVit3lSXpWNgombtjeD9lQM0Cg4zWD1R4k=;
        b=YRv9h12uLU+Sr2vfblLTmo/vrmDixxHGL04dNy7sRDztK4QEZZtn7TURYyovVF7Hra
         PFlP7xWiQTL6CT5Dq7uQDJti5hPfOi0BT+qVpKLO/MDzVrkOwJIaL8d1cQhuVljCBzL0
         4stbKCvcC4QGOiG2nn3cwa90XJyD6vbT2tGRm5XQQgXY7/Royxad1IfExTxwMvnw/Uva
         f5M2VM1InKzgvT98LB2iI2tO7ckcNhiJm+V11FlM0aNRYAEzDLG1E6Av6L66LbrRnSPd
         Jx0MmJl8Au+VKIebpxr8XxbOzmb+jD7TBrQMeSonPd6cnnI8qJWYmJdFx0tFIfVooNNx
         MkRQ==
X-Received: by 10.152.234.44 with SMTP id ub12mr11458lac.9.1412761243731;
        Wed, 08 Oct 2014 02:40:43 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.7.169 with SMTP id k9ls37183laa.91.gmail; Wed, 08 Oct 2014
 02:40:42 -0700 (PDT)
X-Received: by 10.112.190.40 with SMTP id gn8mr278579lbc.10.1412761242373;
        Wed, 08 Oct 2014 02:40:42 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id us10si2328692lbc.1.2014.10.08.02.40.42
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 02:40:42 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LviG8-1YGlDR33vw-017TR8;
 Wed, 08 Oct 2014 11:40:17 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:H4LTv3KTssI+vOCBrZhg1+jYa3LGEXc/nvnoCxsXVdRKKuAXhJa
 eHYzvUmQP545Se1GTMR+jJ/TDKE5R8cm8nXaa2LMCQAw7ZCCIbUXlfj0HcULaegVK0dLZ1y
 fyeZqfPkVKCvwOGJHjESGtcSNQNn5IYgvar8/WHKrRdrLrgBoVdciESF6Y2XCMInfClSodd
 crdmnYVrLGMxgSTDLC4og==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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

Hi all,

On Tue, 30 Sep 2014, Marat Radchenko wrote:

> This patch series fixes building on modern MinGW and MinGW-W64
> (including x86_64!).

To make it easier to review and substantially easier to work on this patch
series with Git, I opened a pull request on GitHub:

	https://github.com/msysgit/git/pull/264

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
