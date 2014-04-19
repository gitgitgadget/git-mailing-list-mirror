From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Sat, 19 Apr 2014 08:31:34 +0200
Message-ID: <20140419063133.GA3617@book-mint>
References: <20140403131850.GA24449@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: marat@slonopotamus.org
X-From: msysgit+bncBDVPBNNXUMFBBS5QZCNAKGQEE6Q62SY@googlegroups.com Sat Apr 19 08:31:42 2014
Return-path: <msysgit+bncBDVPBNNXUMFBBS5QZCNAKGQEE6Q62SY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f61.google.com ([209.85.161.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDVPBNNXUMFBBS5QZCNAKGQEE6Q62SY@googlegroups.com>)
	id 1WbOoO-00027n-Ot
	for gcvm-msysgit@m.gmane.org; Sat, 19 Apr 2014 08:31:40 +0200
Received: by mail-fa0-f61.google.com with SMTP id v1sf196668fav.6
        for <gcvm-msysgit@m.gmane.org>; Fri, 18 Apr 2014 23:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=BFS/pSjAD581C+pR/zZpP7fBbzlUmEzDl3c1QL2FfVs=;
        b=LqBYP6hQhvGK3nL27UwcJxAotAKxeMR8kgORt9YWzY6XakEjXkdIldAIgeFNbuodHd
         VcUj+yPWracHienCDczj1EeysPCXDtaf4LKT5ZWaFkUIMRSfiySQ9l9NCkP/K8Dgkr2Y
         XkhQbDwBRS4SK7RvzGuPo1e5CtHdj8GNnM3POaCgE/IRa3gK8MQucA6AKjC2hxavpMys
         QhZICQ61vCtgs9W++3KwFKnv4UVjgnNzkLQIIe+zrsS2lfqF9P457lz3wHcnDEspOm95
         KakNZFlDpeGyR35Qu01Z6fE+08foPP4fD9WWRo5AzVEzSHnx4oPF6UbLTdsisifbEaQt
         I3Mg==
X-Received: by 10.152.23.198 with SMTP id o6mr1133laf.15.1397889100178;
        Fri, 18 Apr 2014 23:31:40 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.204.5 with SMTP id ku5ls285024lac.28.gmail; Fri, 18 Apr
 2014 23:31:39 -0700 (PDT)
X-Received: by 10.112.59.67 with SMTP id x3mr1851908lbq.5.1397889099416;
        Fri, 18 Apr 2014 23:31:39 -0700 (PDT)
Received: from smtprelay02.ispgateway.de (smtprelay02.ispgateway.de. [80.67.31.36])
        by gmr-mx.google.com with ESMTPS id m49si2222411eeu.0.2014.04.18.23.31.39
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 18 Apr 2014 23:31:39 -0700 (PDT)
Received-SPF: neutral (google.com: 80.67.31.36 is neither permitted nor denied by best guess record for domain of hvoigt@hvoigt.net) client-ip=80.67.31.36;
Received: from [91.97.110.135] (helo=book-mint)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WbOoM-0003L7-BG; Sat, 19 Apr 2014 08:31:38 +0200
In-Reply-To: <20140403131850.GA24449@seldon>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
X-Original-Sender: hvoigt@hvoigt.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 80.67.31.36 is neither permitted nor denied by best guess record
 for domain of hvoigt@hvoigt.net) smtp.mail=hvoigt@hvoigt.net
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246500>

Hi Marat,

On Thu, Apr 03, 2014 at 05:18:50PM +0400, marat@slonopotamus.org wrote:
> I'm proud to announce WinGit:
> an attempt to bring Git powers to 64-bit Windows.

So the reason for this new package is that you need 64bit binaries?

> Relationship with msysgit
> =========================
> 
> Unlike msysgit, WinGit is a pure-Windows binary build with MSVC.
> 
> Like msysgit, WinGit also uses msys environment (sh/perl/etc) both during
> build-time and runtime.

I can see the need for a pure Windows solution (no msys tools at least for
runtime). But this sounds to me that the only thing you changed is the
compiler and 64bit? The git binaries in msysgit are already pure Windows
binaries with no need of msys.dll. The only reason why so many other
tools are shipped with msysgit is to run scripted commands (e.g. like
gitk or rebase).

What is the reason of using a closed source compiler? Why not use the
64bit mingw that is already used to build the 64bit explorer extension
to package 64bit binaries along with the 32bit ones in the installer?

Sorry if I am a little bit skeptic, but I am wondering whether it does
make sense for you to join forces with msysgit instead of creating a
fork? I think the main reason why there are no 64 bit binaries shipped
with msysgit is that nobody needed them and the need to ship both (at
least for some time).

That would also make the maintenance burden easier for you.

Cheers Heiko

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
