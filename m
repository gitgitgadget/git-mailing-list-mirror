From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW(-W64) compilation
Date: Sun, 28 Sep 2014 22:55:40 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1409282255150.990@s15462909.onlinehome-server.info>
References: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>, 
    Erik Faye-Lund <kusmabite@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCZPH74Q5YNRBZPLUGQQKGQEOLTOPHY@googlegroups.com Sun Sep 28 22:56:08 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBZPLUGQQKGQEOLTOPHY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f57.google.com ([209.85.215.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBZPLUGQQKGQEOLTOPHY@googlegroups.com>)
	id 1XYLVm-0005X1-Hb
	for gcvm-msysgit@m.gmane.org; Sun, 28 Sep 2014 22:56:06 +0200
Received: by mail-la0-f57.google.com with SMTP id s18sf135836lam.22
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Sep 2014 13:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=lkHQGh/FPEv9dMxaTBx8ex9AGucHR3KrIjPhomfnZsA=;
        b=QpMv3ou43s1Bk0GFl2d8afOA29ohvW2MfIFyeynSPvRKx4dLHj2otimpL9WBdqxyJG
         vVjM2fppfOSDqs8Wm0z8Pzj0gAxb3GmC9uUe2IsHH725/VB0Vfq7zGk4G3QLfZnQQCT6
         G4GxhdNxwx90iLSgQ8sFNwZ7D5JjcfCeEc1URo3xkU4icoOctsVFpaKxXqpCwI0DjTIQ
         f9/szjgmeMpzv1BW77RURgRbAa0uSSnwhTbNLZpkCKMe+c2lAfODipe3z8JaklQsMSRy
         72oigOiHks+KghadFhOflZOFrsXwwRdUMkgiqDMXZ6BqUtrHaRHaxuswFa4At0l+Rgqe
         bc7Q==
X-Received: by 10.180.207.100 with SMTP id lv4mr200361wic.11.1411937766325;
        Sun, 28 Sep 2014 13:56:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.85.41 with SMTP id e9ls388357wiz.16.gmail; Sun, 28 Sep
 2014 13:56:05 -0700 (PDT)
X-Received: by 10.180.106.197 with SMTP id gw5mr1189090wib.1.1411937765472;
        Sun, 28 Sep 2014 13:56:05 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id fa3si581487lbc.0.2014.09.28.13.56.05
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 13:56:05 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MDzGN-1XTcot3cRr-00HNKD;
 Sun, 28 Sep 2014 22:55:40 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:Oso3viXgSGjU5NphH0ndEJW35vKTTz23IEUFj3g8qvNpDnNiL8e
 9DUGQx3Pi+E8KKnUFghHK/kEyovZWE5B8kdF1/skvWDZFqQMzIHREP+4Gau1XD6wQcfi88K
 F7DEXWxIS4Xr1PIhrhRadyVAMDoYj1yVgxxEAckMGZuUBr8DkYlo7eV2xQ5b0kXpF7gomO/
 usCkL/MGpdhV3PAgzc7RA==
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257613>

Hi Marat,

On Sun, 28 Sep 2014, Marat Radchenko wrote:

> This patch series fixes building on modern MinGW and MinGW-W64
> (including x86_64!).

Awesome work! I'll have a look at it as soon as I can!

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
