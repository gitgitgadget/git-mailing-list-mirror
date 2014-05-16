From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] transport-helper: add trailing --
Date: Fri, 16 May 2014 08:15:34 -0500
Message-ID: <53760f762f340_6899d4d2f869@nysa.notmuch>
References: <20140515053214.GA12133@camelia.ucw.cz>
 <alpine.DEB.1.00.1405152028000.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>, 
 Sverre Rabbelier <srabbelier@gmail.com>, 
 msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBDBJVMGGZYNBBDFE3CNQKGQENP5LKCI@googlegroups.com Fri May 16 15:26:38 2014
Return-path: <msysgit+bncBDBJVMGGZYNBBDFE3CNQKGQENP5LKCI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f192.google.com ([209.85.216.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDBJVMGGZYNBBDFE3CNQKGQENP5LKCI@googlegroups.com>)
	id 1WlI9l-0007rN-Gw
	for gcvm-msysgit@m.gmane.org; Fri, 16 May 2014 15:26:37 +0200
Received: by mail-qc0-f192.google.com with SMTP id l6sf684105qcy.9
        for <gcvm-msysgit@m.gmane.org>; Fri, 16 May 2014 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=sHTa7zqZkd0HzbcmFVMogxxU5vN1i9z77vifWoy0me4=;
        b=PHeuD/hHifB1gfZukt/4rnLs8A+XU3I0DAcvdmK4XPNdfgUlfSoOjde5xD+Tm2fhFX
         2/CAEJW1oDHXqdWEghYlf3pL0K30NNualxX/Pvqrl+3czn92IvinYO+4TUJxCMN+oMMU
         bJ4v9lM+lj/kUuOjzlqzJbhmPtsZsmp9AODfSgoFaECpukX22dL2pxmphZ7O09B5UV3d
         i51/Q8SgQcCEgvaidosVU3BBf0+DpJZzdqXF7ga7nRrol009ioer8bmMxXLg1U5GhiXU
         EaEFu0DxLazKPUvqbG3YoFPJm5PcIQWoF/migwWBm8GJfpWlrs5ATkjwMhqiY1BINwcm
         muLg==
X-Received: by 10.182.1.225 with SMTP id 1mr115368obp.6.1400246796768;
        Fri, 16 May 2014 06:26:36 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.142.102 with SMTP id rv6ls214205obb.48.gmail; Fri, 16 May
 2014 06:26:36 -0700 (PDT)
X-Received: by 10.182.19.231 with SMTP id i7mr8296422obe.25.1400246795997;
        Fri, 16 May 2014 06:26:35 -0700 (PDT)
Received: from mail-ob0-x22b.google.com (mail-ob0-x22b.google.com [2607:f8b0:4003:c01::22b])
        by gmr-mx.google.com with ESMTPS id b5si147499igl.0.2014.05.16.06.26.35
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 06:26:35 -0700 (PDT)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 2607:f8b0:4003:c01::22b as permitted sender) client-ip=2607:f8b0:4003:c01::22b;
Received: by mail-ob0-f171.google.com with SMTP id wn1so2944769obc.16
        for <msysgit@googlegroups.com>; Fri, 16 May 2014 06:26:35 -0700 (PDT)
X-Received: by 10.182.18.102 with SMTP id v6mr3283412obd.71.1400246795668;
        Fri, 16 May 2014 06:26:35 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id x5sm4751610oei.16.2014.05.16.06.26.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 06:26:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1405152028000.14982@s15462909.onlinehome-server.info>
X-Original-Sender: felipe.contreras@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of felipe.contreras@gmail.com designates
 2607:f8b0:4003:c01::22b as permitted sender) smtp.mail=felipe.contreras@gmail.com;
       dkim=pass header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249304>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 15 May 2014, Stepan Kasal wrote:
> 
> > From: Sverre Rabbelier <srabbelier@gmail.com>
> > Date: Sat, 28 Aug 2010 20:49:01 -0500
> > 
> > [PT: ensure we add an additional element to the argv array]
> 
> IIRC we had problems with refs vs file names.

Actually I tried to push a file named refs/heads/master and I saw the
issue. I'd say it's a very rare issue, and I don't see how it could be
triggered with normal files since all the ref names have the full name.
That being said I don't think it would hurt.

-- 
Felipe Contreras

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
