From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Re: Windows Bluescreen
Date: Thu, 12 Feb 2015 13:42:39 +0100
Message-ID: <1423744959.10453.3.camel@thomas-debian-x64>
References: <20150209201218.Horde.w9pQrdbL-Mf8IdgtaJtVuQ9@server.aercontechnologies.net>
	 <CAFOYHZADerTE88KudrH7LTi3yX4Sg1vJe3Xj0vJH+DNeO6NOEw@mail.gmail.com>
	 <CAEuupitA4PHBByLLcqc5pVbn1C+ZyQ6Vzbk-LsOjseOEHhkENw@mail.gmail.com>
	 <CAFOYHZAMv5BEmDXGSoo53iSwCYLdhOcM7dHwCMidZBaJh0xmUQ@mail.gmail.com>
	 <CAEuupiuv=gRnnZm1C75dx35nC=sXR1Hb_PzLXzAKHwaD7kYsXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>, 
	msysgit@googlegroups.com
To: Erik Friesen <erik@aercon.net>
X-From: msysgit+bncBCL7JHHTPAIMBP7SUYCRUBBYWSVPG@googlegroups.com Thu Feb 12 13:42:47 2015
Return-path: <msysgit+bncBCL7JHHTPAIMBP7SUYCRUBBYWSVPG@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f58.google.com ([74.125.83.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIMBP7SUYCRUBBYWSVPG@googlegroups.com>)
	id 1YLt6Q-0005fz-0T
	for gcvm-msysgit@m.gmane.org; Thu, 12 Feb 2015 13:42:42 +0100
Received: by mail-ee0-f58.google.com with SMTP id t10sf2438906eei.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 12 Feb 2015 04:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=OjFEG16wkhQ6KGATLouXCckAA3rMzaXOgXr/8WoY16Q=;
        b=qEOhhF8U4GT5jraCNjZvaVdG/jOFB7W0W9LGiKrRt8BVdjN9wxFZRwKufYx82DFiTR
         bra2FY98tx8P5dKiunARUZBufgYSSrMOvTmcYqWPzn7NeKaHTE7EscIQSYOmCcyJc3c+
         pJoyK/p2UMuNJOWXxqz+p+3dexpz4xxLyKmD9R1egW49Ud4l0aUMDiBbSmrqZeMEpCQs
         ZWMXMXeWlgy+ImwvJKVi8vlEFK9La2RDjAoihJ64ANJnQdLZ5xgirsUNAaVNydk61Dyn
         0PhBWTn3l1erJ3ePkfwWmUp6gFjvE6LnLzorPGcdHj5IWT7mMXR8jl4t0LFcVozZEMrl
         oKXg==
X-Received: by 10.152.43.34 with SMTP id t2mr45044lal.42.1423744961666;
        Thu, 12 Feb 2015 04:42:41 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.179.67 with SMTP id de3ls189095lac.60.gmail; Thu, 12 Feb
 2015 04:42:40 -0800 (PST)
X-Received: by 10.112.130.70 with SMTP id oc6mr548939lbb.13.1423744960370;
        Thu, 12 Feb 2015 04:42:40 -0800 (PST)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [80.237.132.163])
        by gmr-mx.google.com with ESMTPS id l8si1671378wia.0.2015.02.12.04.42.40
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 12 Feb 2015 04:42:40 -0800 (PST)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=80.237.132.163;
Received: from p5ddc2fe2.dip0.t-ipconnect.de ([93.220.47.226] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1YLt6N-0005xd-OL; Thu, 12 Feb 2015 13:42:39 +0100
In-Reply-To: <CAEuupiuv=gRnnZm1C75dx35nC=sXR1Hb_PzLXzAKHwaD7kYsXA@mail.gmail.com>
X-Mailer: Evolution 3.4.4-3
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1423744960;ed124f47;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
 (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted
 sender hosts) smtp.mail=thomas.braun@virtuell-zuhause.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263736>

Am Donnerstag, den 12.02.2015, 07:21 -0500 schrieb Erik Friesen:
> I'd say this is related.  http://sourceforge.net/p/mingw/bugs/2240/
> 
> There isn't much hope, that was filed months ago with no action.  I
> suggest moving to another ssh library perhaps?  Anyways, this is a
> windows git bug report, so it really needs to stay with mysgit in my
> opinion.
> 
> I'd say it should reproduce without much effort.  Do a git push using
> win7 64 pro or similar, I'd say it will have issues.
> 
> At minimum, this should be on the list for others to view.  I have run
> across problems from others, but I don't think they realized it could
> be an ssh problem.

(Please don't TOP post)

The cited bug report does not correlate to msysgit as we compile and
ship our own openssh.

Git for Windows Version 1.8.x might still have the old and slow openssh.
With the newest version I get speeds of up to 30MB/s over Gigabit LAN.

Can you create a minimal test case to reprocude the problem?

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
