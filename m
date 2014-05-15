From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] transport-helper: add trailing --
Date: Thu, 15 May 2014 20:28:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1405152028000.14982@s15462909.onlinehome-server.info>
References: <20140515053214.GA12133@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>, 
    Sverre Rabbelier <srabbelier@gmail.com>, 
    msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCZPH74Q5YNRBTMO2SNQKGQESG3D3SQ@googlegroups.com Thu May 15 20:28:30 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBTMO2SNQKGQESG3D3SQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f189.google.com ([74.125.82.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBTMO2SNQKGQESG3D3SQ@googlegroups.com>)
	id 1Wl0OM-00070p-H1
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 20:28:30 +0200
Received: by mail-we0-f189.google.com with SMTP id w62sf147360wes.6
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 May 2014 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=iXDdw8GkQS9wQ86xrjC7UI5tMp4FzM3Te4NdtA9pG+w=;
        b=QmQl/uKjFtKcIkhxcBvQfsNnfTPUatFItg21MTnXU8ejSjPd6w2xjKZho1DRUjI8BF
         O68OLM/JJ4kf+EcmqXG/01UI2A9msRJveA12G4/vKdJEjwhpKzRpZYHZY53VDPw3XY9c
         w/GtYF6rN7t5lxB3EwrjERYHs6FvHdrL/cMgean70V7RrwOLfA9HPGTCKT8PSXVCvaxB
         wpUO30oFdyeX8neFu3kGD/Gboz3yx+uLaAtPqI7FmpAbBFHS/y0+IunZPo6Tvlqv9kGZ
         Rw10WgPWfgJzjw0p0S1T45BrisP67SATWBuCZxN5EmZoYGivoxsaJXc4uxYY/b1p1maX
         lnbA==
X-Received: by 10.152.43.168 with SMTP id x8mr21896lal.34.1400178510164;
        Thu, 15 May 2014 11:28:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.29.37 with SMTP id g5ls72341lah.3.gmail; Thu, 15 May 2014
 11:28:29 -0700 (PDT)
X-Received: by 10.112.89.10 with SMTP id bk10mr1171699lbb.5.1400178508012;
        Thu, 15 May 2014 11:28:28 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id r49si1953424eep.0.2014.05.15.11.28.27
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 May 2014 11:28:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MZfZi-1WV7vr3Zio-00LUrg;
 Thu, 15 May 2014 20:28:25 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20140515053214.GA12133@camelia.ucw.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:4vLqLoNKyFvf4Sfxo54lTP3SHPGMtmxxVo9YtMqWZWRi53cEV+M
 zKpWjppOtye4ccxeE42mi2IijV9/nXDdC2x797tqe0kDwOiFfbSusuutHT1lUafdJEURrDd
 6EM4cX8enBYkGGhOC0autJa26bN2jWbSGG6BZlk7zEaOZqnpAjcBBrnAN8nAYLhRTElemjc
 /sQ7w+0uDR7FxNQC6z20Q==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249177>

Hi,

On Thu, 15 May 2014, Stepan Kasal wrote:

> From: Sverre Rabbelier <srabbelier@gmail.com>
> Date: Sat, 28 Aug 2010 20:49:01 -0500
> 
> [PT: ensure we add an additional element to the argv array]

IIRC we had problems with refs vs file names.

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
