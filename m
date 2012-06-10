From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t0020: make sure the test file is lf to start with
Date: Sun, 10 Jun 2012 13:50:35 +0100 (IST)
Message-ID: <alpine.DEB.1.00.1206101349180.16012@bonsai2>
References: <1339324352-7376-1-git-send-email-vfr@lyx.org> <alpine.DEB.1.00.1206101145550.16012@bonsai2> <4FD47E99.2000004@lyx.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: msysgit+bncCLLz_5DuGxCmsNL-BBoENDcunQ@googlegroups.com Sun Jun 10 14:50:51 2012
Return-path: <msysgit+bncCLLz_5DuGxCmsNL-BBoENDcunQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ey0-f186.google.com ([209.85.215.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCLLz_5DuGxCmsNL-BBoENDcunQ@googlegroups.com>)
	id 1SdhbT-00051s-Qo
	for gcvm-msysgit@m.gmane.org; Sun, 10 Jun 2012 14:50:47 +0200
Received: by eaac10 with SMTP id c10sf1602801eaa.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 10 Jun 2012 05:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=WJbtFss3yXD7iUOvS0e17tBVXTa1TvmaFGD1ELOJN9s=;
        b=peYVzpdoqHR3tZKldE0sg56GOaPoSAFjcrFvugKIlLzCT9X+vxud0UqPPzo5qjmfhf
         3FCQm0k/tLe+pY4METZh68k3qDrXtEMNd+dXUn5A+1rEhiuyM/Q/BICc0Jhk/sWyobtS
         Vl0hO3cLVyaDHJQ4Vpuinwz/ID9LDEq/QSu/k=
Received: by 10.216.133.229 with SMTP id q79mr308801wei.88.1339332646781;
        Sun, 10 Jun 2012 05:50:46 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.216.214.138 with SMTP id c10ls2288412wep.3.gmail; Sun, 10 Jun
 2012 05:50:42 -0700 (PDT)
Received: by 10.216.140.219 with SMTP id e69mr2134107wej.1.1339332642789;
        Sun, 10 Jun 2012 05:50:42 -0700 (PDT)
Received: by 10.216.140.219 with SMTP id e69mr2134106wej.1.1339332642763;
        Sun, 10 Jun 2012 05:50:42 -0700 (PDT)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.22])
        by gmr-mx.google.com with SMTP id er1si2834373wib.0.2012.06.10.05.50.42;
        Sun, 10 Jun 2012 05:50:42 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted sender) client-ip=213.165.64.22;
Received: (qmail invoked by alias); 10 Jun 2012 12:50:42 -0000
Received: from 89-168-112-76.dynamic.dsl.as9105.com (EHLO bonsai2.local) [89.168.112.76]
  by mail.gmx.net (mp004) with SMTP; 10 Jun 2012 14:50:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+mWLwC6a+mgGz8fCoLXCSz9PndlHeIsk51JfhXRw
	Tpx0okDV8tYKTh
X-X-Sender: gene099@bonsai2
In-Reply-To: <4FD47E99.2000004@lyx.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted
 sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199598>

Hi Vincent,

On Sun, 10 Jun 2012, Vincent van Ravesteijn wrote:

> Op 10-6-2012 12:47, Johannes Schindelin schreef:
> >
> > > Because the eol-style is now wrong from the beginning, the later
> > > tests '.gitattributes says two is binary' and 'checkout with
> > > existing .gitattributes' fail.
>
> > I wonder why it does not fail here:
> >
> >  https://qa.nest-initiative.org/job/msysgit-test/24/console
> >
> > IOW I think there is a difference between the msysGit setup and your
> > setup...
> 
> I compiled git using MSVC and try to run it in the Windows cmd prompt.
> Consequently it doesn't use the perl that is distributed with msysgit,
> but it uses the perl that I've installed on my Windows system
> (Strawberry Perl; http://strawberryperl.com/).

Ah, now it makes sense. Maybe a valuable information to convey in the
commit message?

> When I modify the paths such that git uses the perl.exe distributed with
> msysgit the tests run ok.

Again, a valuable information for the commit message.

Also, I suspect that many, many more places should be affected by that
Perl's behavior...

Ciao,
Johannes

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
