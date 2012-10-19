From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: Git for Windows and line endings
Date: Fri, 19 Oct 2012 08:09:40 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1210190801490.2695@bonsai2>
References: <CADKp0pyy=Nnv29LyhzAOX4B5wJNYnZ0h5d7zxNRyZxV2OGUSjg@mail.gmail.com> <CABPQNSZE7TP0G-uW1b1nbsNgpxYCEiD5KefS62GB5gZbWyZXDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Chris B <chris.blaszczynski@gmail.com>, git@vger.kernel.org, 
    msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBJW5QOCAKGQE5RKGJAY@googlegroups.com Fri Oct 19 08:09:55 2012
Return-path: <msysgit+bncBCZPH74Q5YNRBJW5QOCAKGQE5RKGJAY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f58.google.com ([209.85.214.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBJW5QOCAKGQE5RKGJAY@googlegroups.com>)
	id 1TP5mK-0005B7-Lp
	for gcvm-msysgit@m.gmane.org; Fri, 19 Oct 2012 08:09:52 +0200
Received: by mail-bk0-f58.google.com with SMTP id j10sf41051bkw.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 18 Oct 2012 23:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=0cl4SPBFe1L6l2fQgViuzzFBgrrSAbCqELG87UUfKYc=;
        b=fqjR3ovzmtu7tXUUnMvfOHLcV1JFKjci0F8AvGK93q7L2N0syV9HXXLqXyezeMZa8B
         2IBfIo0FgvwZ2ZOtOhmj+KiWHWOxKSPx3eGsl0cYXxc9LePOJPfDGpTjdsHX0Ak1cGe0
         0qxAAE4G2Sc3KTd03E83u0Y165j0j0CQ+sBYLP15bBc1BMKomMk5jsiQufkmgCup2t4o
         V8HRb5DYTl6xwFerm+MPeR/lL6FSusdMJVVzl4A6RDmEJvmwUr2DYNSCCPhVffHXBLw7
         5yOF24SJp2PsI7wyL5 
Received: by 10.216.207.210 with SMTP id n60mr3734weo.77.1350626982685;
        Thu, 18 Oct 2012 23:09:42 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.99.65 with SMTP id eo1ls2432438wib.1.gmail; Thu, 18 Oct
 2012 23:09:41 -0700 (PDT)
Received: by 10.180.106.102 with SMTP id gt6mr2322706wib.0.1350626981864;
        Thu, 18 Oct 2012 23:09:41 -0700 (PDT)
Received: by 10.180.106.102 with SMTP id gt6mr2322705wib.0.1350626981853;
        Thu, 18 Oct 2012 23:09:41 -0700 (PDT)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.22])
        by gmr-mx.google.com with SMTP id b5si1961712wie.2.2012.10.18.23.09.41;
        Thu, 18 Oct 2012 23:09:41 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted sender) client-ip=213.165.64.22;
Received: (qmail invoked by alias); 19 Oct 2012 06:09:41 -0000
Received: from p4FEF845A.dip0.t-ipconnect.de (EHLO bonsai2.local) [79.239.132.90]
  by mail.gmx.net (mp004) with SMTP; 19 Oct 2012 08:09:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//36oDiA7/R1CsZOIGeeYwpc6VisiP3go3Uj6O+j
	mPob3emWAcW9RU
X-X-Sender: gene099@bonsai2
In-Reply-To: <CABPQNSZE7TP0G-uW1b1nbsNgpxYCEiD5KefS62GB5gZbWyZXDQ@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208040>

Hi,

On Fri, 19 Oct 2012, Erik Faye-Lund wrote:

> On Fri, Oct 19, 2012 at 12:13 AM, Chris B <chris.blaszczynski@gmail.com> wrote:
> > Hi.. it is such a crime to have that default option of MSysGit mess
> > around with the line endings.
> 
> No it's not.

Let's keep things professional. Eliciting emotions, especially negative
ones, traditionally makes it more unlikely to get what one asks for.

Also to clarify: as so many Open Source projects (but unlike Git itself),
msysGit is a purely volunteer-driven software. So naturally, contributors
have a lot more to say about the defaults than non-contributors [*1*].

Besides, there is a fantastic and very detailed page when running the
installer where the interested user can inform herself and change the
defaults to her likings very easily.

Therefore I consider this bug report -- insofar it was one -- as closed.

Ciao,
Johannes

Footnote [*1*]: And yes, the line endings default was changed from this
developer's preference to what it is now -- based on a discussion with
convincing arguments. Since msysGit is developed as an Open Source project
with a truly Open Source process, all of these discussions can be found in
the mailing list archives.


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
