From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Tue, 22 Apr 2014 18:14:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404221813320.14982@s15462909.onlinehome-server.info>
References: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com> <20140419184210.GB3617@book-mint> <alpine.DEB.1.00.1404210003540.14982@s15462909.onlinehome-server.info> <53556579.3050709@gmail.com> <alpine.DEB.1.00.1404212053420.14982@s15462909.onlinehome-server.info>
 <535569e92cbcc_32c48493101f@nysa.notmuch> <alpine.DEB.1.00.1404221512130.14982@s15462909.onlinehome-server.info> <53569207a2683_3e5aed73082b@nysa.notmuch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Sebastian Schuberth <sschuberth@gmail.com>, 
    Heiko Voigt <hvoigt@hvoigt.net>, Marat Radchenko <marat@slonopotamus.org>, 
    git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBDVL3KNAKGQEU5P4YCI@googlegroups.com Tue Apr 22 18:15:12 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBDVL3KNAKGQEU5P4YCI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f184.google.com ([209.85.212.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBDVL3KNAKGQEU5P4YCI@googlegroups.com>)
	id 1WcdLj-0008GV-Ro
	for gcvm-msysgit@m.gmane.org; Tue, 22 Apr 2014 18:15:11 +0200
Received: by mail-wi0-f184.google.com with SMTP id cc10sf282204wib.11
        for <gcvm-msysgit@m.gmane.org>; Tue, 22 Apr 2014 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=TeARYmEpCZ9lCzSsQIump/xTQuCnbH559gWggQD+VmA=;
        b=is/nAJmkwgsbSO5mFWJVzJCq0WLuDOy5uoqGesiHquWob/d4WndMnmrl+gQPC0khyd
         EbTkV60PjD5wPjp7N/KpqM6tS45/GytUoqm+6ll4PCZGWwIUtOksNETXismSzYROuX2Q
         uWjyqKO2pmyAFWCyxZK3JDh6vluovG7LRpBNXS+uCDDM1umWobn2a+yt0pwFO09oc82i
         N2efFcjumuAjCWTjMTc00RGdI7xquvO020JEKq8rUkHcbCJeXuIi11/EIi6Q+tn7ev0K
         pPTEaHYXFUNoi+YVGkuiXXI82J1EGZzz9h5cdx1MK8mqusxminlEv/9dHzB/LvdoxuAb
         wC3g==
X-Received: by 10.180.107.36 with SMTP id gz4mr117172wib.0.1398183311293;
        Tue, 22 Apr 2014 09:15:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.106.195 with SMTP id gw3ls535975wib.27.canary; Tue, 22 Apr
 2014 09:15:10 -0700 (PDT)
X-Received: by 10.180.149.210 with SMTP id uc18mr1852145wib.5.1398183310082;
        Tue, 22 Apr 2014 09:15:10 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.20])
        by gmr-mx.google.com with ESMTPS id u49si515660eeo.1.2014.04.22.09.15.10
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 09:15:10 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.20 as permitted sender) client-ip=212.227.17.20;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MWk7n-1WRSEp2t2p-00XtlH;
 Tue, 22 Apr 2014 18:14:44 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <53569207a2683_3e5aed73082b@nysa.notmuch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:P7ttKAIvKEShVQvmYOsNY/j9QXz/JptmFpVsiXCejdH09DkVAx/
 lPdNoa9Nh7kuo5WYC+E8SIQIzGNRiTwT8LO6KKzbO5exQBEk83LkBi86VKjpkFAX+ij2KjD
 JbQT6UGPi82puuWqZzq47F98LgSV1jCsCo1DZO6cdwQscGp4rOIH9hpZrckdv4z1/IltKSF
 OVaBD4gYIgfGLNYdMEplw==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.20 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246745>

Hi Felipe,

On Tue, 22 Apr 2014, Felipe Contreras wrote:

> Johannes Schindelin wrote:
> > On Mon, 21 Apr 2014, Felipe Contreras wrote:
> > > Johannes Schindelin wrote:
> > > > Now, clearly you have all the motivation that is needed to get 64-bit
> > > > builds of Git for Windows going, and all the motivation required to make
> > > > sure that the MSVC support of the msysGit project works.
> > > 
> > > s/msysGit/Git/
> > 
> > No. I meant the msysGit project; the project that maintains the current
> > development environment for Git for Windows. Please do not try to
> > reinterpret what I am saying.
> 
> I don't care what you are saying,

That is quite obvious and did not need clarifying.

Nevertheless, by stating that "substitute" command, you corrected me.
Except that you did not, I intended to say something different, and your
correction was quite misplaced.

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
