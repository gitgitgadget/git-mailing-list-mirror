From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Sat, 19 Apr 2014 21:24:09 +0200
Message-ID: <20140419192409.GA8140@book-mint>
References: <20140403131850.GA24449@seldon>
 <20140419063133.GA3617@book-mint>
 <alpine.DEB.1.00.1404191719280.14982@s15462909.onlinehome-server.info>
 <20140419165832.GA23227@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBDVPBNNXUMFBBX42ZONAKGQEC7UICBY@googlegroups.com Sat Apr 19 21:24:16 2014
Return-path: <msysgit+bncBDVPBNNXUMFBBX42ZONAKGQEC7UICBY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f60.google.com ([209.85.161.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDVPBNNXUMFBBX42ZONAKGQEC7UICBY@googlegroups.com>)
	id 1Wbas4-00080j-2y
	for gcvm-msysgit@m.gmane.org; Sat, 19 Apr 2014 21:24:16 +0200
Received: by mail-fa0-f60.google.com with SMTP id a11sf223787fad.15
        for <gcvm-msysgit@m.gmane.org>; Sat, 19 Apr 2014 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=ekTPJgVX1IQNyuOF0Jw9+DJFkTP3cdxAAkE9yVQwzJc=;
        b=ckoCXXo+GH3m9Pxa3j0JlhiKceDWq1GkkW5VqfB+yruKUGI2e37icAJHxaPUkwot3S
         vN5dZpHwm6JMrvAh12gHIf9l2EMf621Ptfd99EJUVTfRTxUiZPPKSjIC4KrBR/RRRPGi
         UKrs6EERREkVcI+QghHhsscAAc81NTuxxq/eZ2v84sDy33RjciRSMvwjSJuNaIOy3s3M
         Vp6Kf1cCD7++NE6s544d03eNLMHVqRU8QpbVA2WKf+lvKp2tmE7cWp2y6x6JbQm1Vvgd
         UdJHu7tBTHBaaeZA3lrf12EovuJQXNO3LedDGYohxWiayTAZtjPM7KZPX57SSAN3yAcy
         m8Mg==
X-Received: by 10.180.100.38 with SMTP id ev6mr47479wib.20.1397935455594;
        Sat, 19 Apr 2014 12:24:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.94.198 with SMTP id de6ls210265wib.21.canary; Sat, 19 Apr
 2014 12:24:14 -0700 (PDT)
X-Received: by 10.180.37.203 with SMTP id a11mr674407wik.0.1397935454859;
        Sat, 19 Apr 2014 12:24:14 -0700 (PDT)
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de. [80.67.31.39])
        by gmr-mx.google.com with ESMTPS id m49si2989513eeu.0.2014.04.19.12.24.14
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 19 Apr 2014 12:24:14 -0700 (PDT)
Received-SPF: neutral (google.com: 80.67.31.39 is neither permitted nor denied by best guess record for domain of hvoigt@hvoigt.net) client-ip=80.67.31.39;
Received: from [80.228.206.6] (helo=book-mint)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Wbas2-0007N5-25; Sat, 19 Apr 2014 21:24:14 +0200
In-Reply-To: <20140419165832.GA23227@seldon>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
X-Original-Sender: hvoigt@hvoigt.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 80.67.31.39 is neither permitted nor denied by best guess record
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246538>

On Sat, Apr 19, 2014 at 08:58:32PM +0400, Marat Radchenko wrote:
> On Sat, Apr 19, 2014 at 05:24:33PM +0200, Johannes Schindelin wrote:
> > Marat, please do not add to the confusion. "msysGit" is the name of the
> > *development environment* for developing Git for Windows.
> 
> This confusion comes from the fact that major part of msysGit is packaged
> with Git for Windows to be used at runtime.

Only the tools that are needed to run git (and some that the
contributors like) are packaged in Git for Windows. For example there is
no compiler or similar packaged.

> If you insist on msysGit-is-a-development-environment, you have to admit
> that msysGit is technically a fork of msys.

Well it is a git repository that conveniently packages all the needed
tools you need to build "Git for Windows" together. It is a little bit
quick and dirty but it works. We have nothing against improving this
situation.

> My approach undoes this fork step and uses upstream runtime environment
> as-is, be it msys, msys2, Cygwin or even SUA [1]. I could even make it a
> noop and say "dear user, I don't care how, but please put sh/awk/find/etc
> on PATH to make Git work, like things normally happen in *nix world".
> 
> Actually, even if Git was pure C, things like `git filter-branch` would
> be almost useless without coreutils & friends.
> 
> > After all, there is no reason for yet another fork.
> 
> If there wasn't, mingwGitDevEnv would not be started.

I would not consider mingwGitDevEnv a fork. It is more msysgit next
generation. But it needs more work to fully replace msysgit.

> I'd say I am doing a 'rebase' instead of 'fork' by using codebase of
> Git for Windows (upstream Git sources with Windows-specific patches)
> but replacing msysGit-provided runtime environment with another one.

The downside of doing this approach is that you regularly have to update
your 'rebase' and fix problems. If you integrate your changes into
msysgit itself you do not have to do that anymore.
Well, if it is one of your changes that breaks something, it still would
be nice if you do so ;-)

> [1]: http://en.wikipedia.org/wiki/Windows_Services_for_UNIX

Cheers Heiko

P.S.: BTW, just in case: Being criticized in open-source is good. Even
though it might not feel like that. It means people care about the stuff
you do and think it is important enough it deserves a reply. They just
want to help you improve it.

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
