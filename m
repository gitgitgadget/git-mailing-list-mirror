From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: GitMinutes about Git for Windows
Date: Mon, 14 Apr 2014 17:14:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404141713020.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBCZPH74Q5YNRB47WV6NAKGQEVAVRFKA@googlegroups.com Mon Apr 14 17:15:06 2014
Return-path: <msysgit+bncBCZPH74Q5YNRB47WV6NAKGQEVAVRFKA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f59.google.com ([74.125.83.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB47WV6NAKGQEVAVRFKA@googlegroups.com>)
	id 1WZib6-0003dx-Jk
	for gcvm-msysgit@m.gmane.org; Mon, 14 Apr 2014 17:15:00 +0200
Received: by mail-ee0-f59.google.com with SMTP id e49sf632331eek.4
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Apr 2014 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=a/H7JgU8g31gfypXST4olsTCXYfMW+W+2m5kRzKxk9A=;
        b=y8Dda6lplmdE5j0s4rLGxe3mrX1aQbIX4/o/oAp0xia6i85IAcEH9xysoTHbqoDkiV
         OwARJkyVa00x4VyQP7tW4LVhtMUqDI3jmwvj2RSsDeSQcyk67Mgjar5XTXddAT6D0HCZ
         vGDgARuWrsP0oTtyVUT7UxJQsG+4Dtnl2gDdRYUX3DkSqiKoCtl7F3pfyGGFyrqYMtSN
         2pBfVub5hiq/EgRKeCek1CXHaFFJHFZsoDgmPXw5oNdXeo18Ve0o1IhZjLmAvxaPKZi3
         eMlQAZ+pcR/I7VuibQX2lSrIk25WJX4+LKxuOME6Cgcdl71ICsKRGzxe75KGnPBjM4OH
         nFuw==
X-Received: by 10.180.107.36 with SMTP id gz4mr65399wib.0.1397488500038;
        Mon, 14 Apr 2014 08:15:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.88.38 with SMTP id bd6ls529772wib.6.gmail; Mon, 14 Apr
 2014 08:14:59 -0700 (PDT)
X-Received: by 10.15.82.2 with SMTP id z2mr283291eey.6.1397488498976;
        Mon, 14 Apr 2014 08:14:58 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id u49si4174001eeo.1.2014.04.14.08.14.58
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA bits=256/256);
        Mon, 14 Apr 2014 08:14:58 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MDyFr-1Wkvvi0Drr-00HKFL;
 Mon, 14 Apr 2014 17:14:57 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:RyJYzV2riQHCO4f4R0ePCKSe1GEh9t8WVBVxS+eMVk5iOxSWDx8
 MEGgaTVvxCAEIVMv9Lbt8J5rSt6TvwiC5HiIFm8eZNni/t47uN4lKWeF8cnnQ4IsLMYpwyz
 shFkHW3owx7d2dFE4AViOiP1DoWHv80zc6N3Uqi64nL4ScAKoIEp/TNczEW3QgXt7kE6nxE
 kqP2OlhCXCepM5i9yIQ2w==
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
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246249>

Dear friends of Git for Windows,

it was very delightful to be on the show, hosted by Thomas Ferris
Nicolaisen:

http://episodes.gitminutes.com/2014/04/gitminutes-28-johannes-schindelin-on.html

Enjoy,
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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
