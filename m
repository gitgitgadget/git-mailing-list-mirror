From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [GIT GUI PATCH] git-gui: fix open explorer window 
	on Windows 7
Date: Thu, 25 Feb 2010 21:30:11 +0100
Message-ID: <20100225202949.GA12637@book.hvoigt.net>
References: <20100223225243.GC11271@book.hvoigt.net> <a5b261831002240415l5447ac94wd80c162fc9492fd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: 32N2GSwYKB4gt70us5t70us5.zq5y4A4su5s00sxqs30614.o0y@groups.bounces.google.com Thu Feb 25 21:30:40 2010
Return-path: <32N2GSwYKB4gt70us5t70us5.zq5y4A4su5s00sxqs30614.o0y@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f188.google.com ([209.85.217.188])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <32N2GSwYKB4gt70us5t70us5.zq5y4A4su5s00sxqs30614.o0y@groups.bounces.google.com>)
	id 1NkkM3-0002Hz-7L
	for gcvm-msysgit@m.gmane.org; Thu, 25 Feb 2010 21:30:39 +0100
Received: by gxk4 with SMTP id 4sf5953220gxk.6
        for <gcvm-msysgit@m.gmane.org>; Thu, 25 Feb 2010 12:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:in-reply-to:user-agent
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=3N8i0n1K7vlBH0fGN8UWkuE0NgcOn5IVsUjCqnctyzc=;
        b=wTfQ+L/aoRoXvLaLhjM3lRGZGBmoFFINVTdCIPf3K8maLU0C8Pco88TyNdQodydQzT
         QoOE1wgdFX7UAhD41JZxwx4UjIQS5mBlYaqSf8CLARczKfKxs2jhuYdlOZAZEf7gaqtn
         ljM8t9t+MYr9SiGwKLRy8rK4OxargP8aKIfNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:user-agent
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        b=aY1YG+vU9k4uu8LgumB5JSbt3CPPYuALWTPi2kyNKDdSoUTSZj+ThhhuROVmqWRgSS
         5wXU3koU3DcgX9gIfqXb9apUi66DbZ0Ve5oRtjZuZT8ZfswDk2eHbYRKVQmYfGloUjwa
         doTerLDZlGqGeeUm7/TXGzowUwLZl90jBpyAc=
Received: by 10.91.82.19 with SMTP id j19mr84023agl.27.1267129816842;
        Thu, 25 Feb 2010 12:30:16 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.27.2 with SMTP id g2ls167683bkc.0.p; Thu, 25 Feb 2010 
	12:30:14 -0800 (PST)
Received: by 10.204.0.84 with SMTP id 20mr13520bka.26.1267129814279;
        Thu, 25 Feb 2010 12:30:14 -0800 (PST)
Received: by 10.204.0.84 with SMTP id 20mr13519bka.26.1267129814236;
        Thu, 25 Feb 2010 12:30:14 -0800 (PST)
Received: from darksea.de (darksea.de [83.133.111.250])
        by gmr-mx.google.com with SMTP id 12si860759bwz.13.2010.02.25.12.30.14;
        Thu, 25 Feb 2010 12:30:14 -0800 (PST)
Received-SPF: neutral (google.com: 83.133.111.250 is neither permitted nor denied by best guess record for domain of hvoigt@hvoigt.net) client-ip=83.133.111.250;
Received: (qmail 26348 invoked from network); 25 Feb 2010 21:30:12 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 25 Feb 2010 21:30:12 +0100
In-Reply-To: <a5b261831002240415l5447ac94wd80c162fc9492fd5@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	83.133.111.250 is neither permitted nor denied by best guess record for 
	domain of hvoigt@hvoigt.net) smtp.mail=hvoigt@hvoigt.net
X-Original-Sender: hvoigt@hvoigt.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/582d6c373f657ad2
X-Message-Url: http://groups.google.com/group/msysgit/msg/f4f8ed0ed51b3627
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141068>

On Wed, Feb 24, 2010 at 12:15:03PM +0000, Pat Thoyts wrote:
> On 23 February 2010 22:52, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > It seems that Windows 7's explorer is not capable to cope with paths
> > that contain forward slashes as path seperator. We thus substitute slash
> > with the platforms native backslash.
> >
> 
> What bug are you actually addressing here? How can I reproduce it? My
> experience on Windows 7 is that there is no problem but I assume I'm
> doing a different operation. If I use the git-gui  "Explore working
> copy" it opens the Windows explorer for me just fine.

Very strange, again another inconsistency between Windowses? I can
reproduce this even on Windows XP. I am using the current devel branches
of msysgit (msysgit and git). It happens when using the
"Repository->Explore working copy" menu item. The Windows 7 I tested
this on is 32-bit Professional. Which Windows 7 are you using?

cheers Heiko
