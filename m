From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Re: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Tue, 22 Apr 2014 11:00:07 -0500
Message-ID: <53569207a2683_3e5aed73082b@nysa.notmuch>
References: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com>
 <20140419184210.GB3617@book-mint>
 <alpine.DEB.1.00.1404210003540.14982@s15462909.onlinehome-server.info>
 <53556579.3050709@gmail.com>
 <alpine.DEB.1.00.1404212053420.14982@s15462909.onlinehome-server.info>
 <535569e92cbcc_32c48493101f@nysa.notmuch>
 <alpine.DEB.1.00.1404221512130.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>, 
 Heiko Voigt <hvoigt@hvoigt.net>, 
 Marat Radchenko <marat@slonopotamus.org>, 
 git@vger.kernel.org, 
 msysGit Mailinglist <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Felipe Contreras <felipe.contreras@gmail.com>
X-From: msysgit+bncBDBJVMGGZYNBB5VI3KNAKGQECCTFQMA@googlegroups.com Tue Apr 22 18:10:33 2014
Return-path: <msysgit+bncBDBJVMGGZYNBB5VI3KNAKGQECCTFQMA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f183.google.com ([209.85.220.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDBJVMGGZYNBB5VI3KNAKGQECCTFQMA@googlegroups.com>)
	id 1WcdHE-0004Rh-3n
	for gcvm-msysgit@m.gmane.org; Tue, 22 Apr 2014 18:10:32 +0200
Received: by mail-vc0-f183.google.com with SMTP id ik5sf547284vcb.10
        for <gcvm-msysgit@m.gmane.org>; Tue, 22 Apr 2014 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=IQh1yQzqTbPotIoc0coQkdsPXcF1PPBLsdYDaXJfJzw=;
        b=CKGG3Ab0KDDjh7M6EL1kTS2Kug1bn2Ok1bNK3FIqhOB/kvPViexSQWAA0kOWlywvE2
         aBP8O/ab1RDUpOB4s/8tTioHmjdlU7uEqLh+oRypvwk2kPbJYr/exQYkJehEC78yOVeM
         4uZ4YI+evBTgpqI3ObyTTiElv0oZWPNJhzO1JtOhTt5mIyalaQ3AQbprXTY9MmL+/62H
         6j/PDh/sB6jlo/6MV/OuXWLdgsO8vlcq6l/alD20oBexFTcwBug7o102xizUFYFoRqPi
         OdTI+/ZjmcHw2dxMrH6xC6E9D7V0BwnP4Vb5kZ1Fv7W19jnaEw+egNnWBlRvo4cw2raz
         H5kA==
X-Received: by 10.140.51.166 with SMTP id u35mr25523qga.34.1398183031204;
        Tue, 22 Apr 2014 09:10:31 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.101.213 with SMTP id u79ls205330qge.79.gmail; Tue, 22 Apr
 2014 09:10:30 -0700 (PDT)
X-Received: by 10.58.94.232 with SMTP id df8mr21696722veb.23.1398183030792;
        Tue, 22 Apr 2014 09:10:30 -0700 (PDT)
Received: from mail-ob0-x236.google.com (mail-ob0-x236.google.com [2607:f8b0:4003:c01::236])
        by gmr-mx.google.com with ESMTPS id h6si3192063iga.0.2014.04.22.09.10.30
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Apr 2014 09:10:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 2607:f8b0:4003:c01::236 as permitted sender) client-ip=2607:f8b0:4003:c01::236;
Received: by mail-ob0-f182.google.com with SMTP id uy5so4650422obc.41
        for <msysgit@googlegroups.com>; Tue, 22 Apr 2014 09:10:30 -0700 (PDT)
X-Received: by 10.60.95.230 with SMTP id dn6mr37923563oeb.25.1398183030499;
        Tue, 22 Apr 2014 09:10:30 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id y10sm77454855obk.4.2014.04.22.09.10.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 09:10:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1404221512130.14982@s15462909.onlinehome-server.info>
X-Original-Sender: felipe.contreras@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of felipe.contreras@gmail.com designates
 2607:f8b0:4003:c01::236 as permitted sender) smtp.mail=felipe.contreras@gmail.com;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246744>

Johannes Schindelin wrote:
> On Mon, 21 Apr 2014, Felipe Contreras wrote:
> > Johannes Schindelin wrote:
> > > Now, clearly you have all the motivation that is needed to get 64-bit
> > > builds of Git for Windows going, and all the motivation required to make
> > > sure that the MSVC support of the msysGit project works.
> > 
> > s/msysGit/Git/
> 
> No. I meant the msysGit project; the project that maintains the current
> development environment for Git for Windows. Please do not try to
> reinterpret what I am saying.

I don't care what you are saying, what I'm saying is that he has the motivation
to do it for the Git project. Why on Earth would he do it for the msysGit
project, when he can do it for the Git project (which would then percolate to
the msysGit project as well)?

> > Personally I don't see why ideally I shouldn't be able to build upstream
> > Git for Windows with mingw without leaving my Linux system.
> 
> Maybe because you could not even test it properly, let alone run the test
> suite?

Ideally you could.

> And maybe because according to the famous "scratch your own itch"
> credo, it is actually the duty of Windows users -- i.e. users who do not
> even have your Linux system -- to fix the bugs that would never be
> encountered anywhere but Windows?

That is your conclusion. If somebody reasonable sends reasonable patches that
make WinGit work in a way that doesn't impact negatively non-Windows users, I
don't see why they wouldn't be picked.

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
