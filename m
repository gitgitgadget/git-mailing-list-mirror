From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] compat/terminal: support echoing on windows
Date: Sun, 24 Jun 2012 09:38:24 -0500 (CDT)
Message-ID: <alpine.DEB.1.00.1206240938050.16012@bonsai2>
References: <1340544903-37016-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, peff@peff.net
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncCLLz_5DuGxDmzJz_BBoEQBd6Yw@googlegroups.com Sun Jun 24 16:38:30 2012
Return-path: <msysgit+bncCLLz_5DuGxDmzJz_BBoEQBd6Yw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCLLz_5DuGxDmzJz_BBoEQBd6Yw@googlegroups.com>)
	id 1SinxO-00070Y-Je
	for gcvm-msysgit@m.gmane.org; Sun, 24 Jun 2012 16:38:30 +0200
Received: by wibhr12 with SMTP id hr12sf213824wib.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 24 Jun 2012 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=6hhxnwsMNtzgodtV9dLzd3fD7i4mk8EiGRCn4iJTYd8=;
        b=10Ve9/n2SXk6lialb4lgKhskHzb9L1OhmtYfF64yCwXJ4jYUbXyQPQp5LWExy/pwpI
         KgsJfG/Ttaw3W8vAbzNXAcF304t7GdJCG3hOAV7VVWqc7YecyfS1I9C8aj/TU+FDouIy
         gnnBqZdDO2vOij+dKWMuR3QNSToyL+8WTLwag=
Received: by 10.180.104.199 with SMTP id gg7mr873807wib.1.1340548710739;
        Sun, 24 Jun 2012 07:38:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.216.143.99 with SMTP id k77ls3956129wej.5.gmail; Sun, 24 Jun
 2012 07:38:28 -0700 (PDT)
Received: by 10.216.194.221 with SMTP id m71mr401639wen.2.1340548708904;
        Sun, 24 Jun 2012 07:38:28 -0700 (PDT)
Received: by 10.216.194.221 with SMTP id m71mr401638wen.2.1340548708889;
        Sun, 24 Jun 2012 07:38:28 -0700 (PDT)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.22])
        by gmr-mx.google.com with SMTP id ei10si1503509wid.0.2012.06.24.07.38.28;
        Sun, 24 Jun 2012 07:38:28 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted sender) client-ip=213.165.64.22;
Received: (qmail invoked by alias); 24 Jun 2012 14:38:28 -0000
Received: from 24-240-34-26.dhcp.mdsn.wi.charter.com (EHLO bonsai2.local) [24.240.34.26]
  by mail.gmx.net (mp040) with SMTP; 24 Jun 2012 16:38:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193KGgHk7x3pJir1/kW2nUwUfe7v7mcIqAZ2MpBHV
	LzuI2axAaBxq2u
X-X-Sender: gene099@bonsai2
In-Reply-To: <1340544903-37016-1-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200530>

Hi,

On Sun, 24 Jun 2012, Erik Faye-Lund wrote:

> Without /dev/tty support, git_terminal_prompt simply ignores the
> 'echo'-parameter. On Windows we can do better by clevering up our
> getpass-implementation a bit so it can conditionally echo.
> 
> While we're at it, plug a small memory-leak by returning a pointer
> to a static strbuf instead of detaching it. This is the same thing
> the /dev/tty-version of git_terminal_prompt does, and the callee
> doesn't expect to have to free it's memory.

Looks good, please apply!

Ciao,
Dscho

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
