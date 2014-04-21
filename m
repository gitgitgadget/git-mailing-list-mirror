From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Mon, 21 Apr 2014 20:56:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404212053420.14982@s15462909.onlinehome-server.info>
References: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com> <20140419184210.GB3617@book-mint> <alpine.DEB.1.00.1404210003540.14982@s15462909.onlinehome-server.info> <53556579.3050709@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Marat Radchenko <marat@slonopotamus.org>, 
    git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBTWT2WNAKGQE7SEKP2I@googlegroups.com Mon Apr 21 20:56:15 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBTWT2WNAKGQE7SEKP2I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f56.google.com ([209.85.214.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBTWT2WNAKGQE7SEKP2I@googlegroups.com>)
	id 1WcJO3-0005lo-4j
	for gcvm-msysgit@m.gmane.org; Mon, 21 Apr 2014 20:56:15 +0200
Received: by mail-bk0-f56.google.com with SMTP id mx12sf358834bkb.1
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Apr 2014 11:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=BPsJHB9xWLnULa0PHtOx2Wcr0sHaoCrHJ70qFdkibfk=;
        b=mjPtKceMdf637ml/GG3MMh5YHRE+Wz9niexVOMZjX1tClYtqq1LkHEL4e8DqhbSz4t
         YrRXOCtE34I+qMEka407QtNVoP49BHOVADTQ6c4sWnsc8KF5K47p6M1IooSJatHVVwNl
         tKvgAMpQw/jEHS7Bo7/iaqJz9lg1vXK0Gk9i3G0hSebJmOHxL4S4VSsSKqDNKQrswyVL
         CydG/WTmWd2i0w6cEdTzhRtS1lRNEcHW6Ne6yDXy/P9y+ALknkAuU30qZlTcZgXq+UEE
         OsjvT3MvMff8tZccCPjANyNotk0J0+Z2aQHfa4sdLOVEa7i9gVHeZ/l5q3T9M/4eOQ8Q
         rHPw==
X-Received: by 10.152.42.164 with SMTP id p4mr468537lal.1.1398106574852;
        Mon, 21 Apr 2014 11:56:14 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.36.163 with SMTP id r3ls453436laj.10.gmail; Mon, 21 Apr
 2014 11:56:14 -0700 (PDT)
X-Received: by 10.112.20.194 with SMTP id p2mr131994lbe.21.1398106574159;
        Mon, 21 Apr 2014 11:56:14 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id m49si136977eeu.0.2014.04.21.11.56.14
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA bits=256/256);
        Mon, 21 Apr 2014 11:56:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0Lugbo-1X2kAd1Rxo-00zphV;
 Mon, 21 Apr 2014 20:56:11 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <53556579.3050709@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:uh27mlvZ2KgoE7WCwe53zlR56mQL4nZaiyLZs7Ba+9IiW2BGNnL
 HlBHUKYS+GjnhM6CBVEBs+0hYL/YLerU1iAtMgXruUWI6N+LNoQYrKypL/Rj+SA4/C5WZ7Q
 diDh4cWDH5oD756mZZIs48LbuzxaKaSIuoboKEWGs5ohely2v2ciEr/2Kvt+nbt+eRTU4qk
 l+H0o1yPE/oQGl5pbPaKw==
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246619>

Hi Sebastian,

On Mon, 21 Apr 2014, Sebastian Schuberth wrote:

> On 21.04.2014 00:10, Johannes Schindelin wrote:
> 
> > tests do not pass yet. (I also would like to look into getting the
> > performance improvement Hannes Sixt achieved by his patch [*1*] into
> > mingwGitDevEnv's Git installation, too.)
> >
> > Whoops. Footnote *1*: https://github.com/msysgit/msysgit/commit/a0f5d4f
> 
> Dscho, this patch of Hannes is already in, see [1].

Ah, I missed that. That's very good news!

Marat, you see that the patches *are* sent upstream.

Now, clearly you have all the motivation that is needed to get 64-bit
builds of Git for Windows going, and all the motivation required to make
sure that the MSVC support of the msysGit project works.

How about joining forces?

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
