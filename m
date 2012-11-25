From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 10:15:08 +0700
Message-ID: <CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: msysgit+bncBC2ZN5PHQUMBBWU2Y2CQKGQESZ6C5IQ@googlegroups.com Sun Nov 25 04:15:53 2012
Return-path: <msysgit+bncBC2ZN5PHQUMBBWU2Y2CQKGQESZ6C5IQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f186.google.com ([209.85.214.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBWU2Y2CQKGQESZ6C5IQ@googlegroups.com>)
	id 1TcShE-0004pG-7S
	for gcvm-msysgit@m.gmane.org; Sun, 25 Nov 2012 04:15:52 +0100
Received: by mail-ob0-f186.google.com with SMTP id wp18sf7008637obc.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 24 Nov 2012 19:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:from
         :date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=2CcRRB8yXRqTHiffkBC/4IbWGv+kxCUeiB5TBlYMXFE=;
        b=bDMFXg4PLuvKkcIWpXPWc2dTjaK0MEzif7VWz5eqlGocVEgHiKN7bv0ay7E4eOLzOv
         /SF/ZYED2Dx0tyU2THlhPFZCPNgSmCKVON9JCD9Wlsf/w7eBdg1cHHpByxRT2+rtSxh0
         yfYxbCIt/4JFnM9Gz07XwRMogdgnUsvzN4iY4VH5+DA0jzKRA0Ymy5pEGDKUmdew3BnT
         BZKqQu87ziyXYr+z5C+utvz+ueV7vzFq/NGQVoC6AJYB4VWdSObUJH0kwRcPH4GcE6xH
         TJK78cr8QOFxWO+pUZ5prUb2ekBFmgNQLi3HYL8QHFmAeCFEF2eJPoJySfAatnpasGkX
         ybKQ==
Received: by 10.50.185.167 with SMTP id fd7mr3636372igc.11.1353813340249;
        Sat, 24 Nov 2012 19:15:40 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.184.228 with SMTP id ex4ls2121958igc.41.canary; Sat, 24 Nov
 2012 19:15:38 -0800 (PST)
Received: by 10.43.84.4 with SMTP id ai4mr5427650icc.22.1353813338586;
        Sat, 24 Nov 2012 19:15:38 -0800 (PST)
Received: by 10.43.84.4 with SMTP id ai4mr5427649icc.22.1353813338533;
        Sat, 24 Nov 2012 19:15:38 -0800 (PST)
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com [209.85.214.181])
        by gmr-mx.google.com with ESMTPS id o7si1030143igl.0.2012.11.24.19.15.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Nov 2012 19:15:38 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 209.85.214.181 as permitted sender) client-ip=209.85.214.181;
Received: by mail-ob0-f181.google.com with SMTP id za17so8505197obc.26
        for <msysgit@googlegroups.com>; Sat, 24 Nov 2012 19:15:38 -0800 (PST)
Received: by 10.60.171.11 with SMTP id aq11mr6185014oec.104.1353813338327;
 Sat, 24 Nov 2012 19:15:38 -0800 (PST)
Received: by 10.182.87.197 with HTTP; Sat, 24 Nov 2012 19:15:08 -0800 (PST)
In-Reply-To: <20121125024451.1ADD14065F@snark.thyrsus.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of pclouds@gmail.com designates 209.85.214.181 as permitted sender)
 smtp.mail=pclouds@gmail.com; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210330>

CCing msysgit. I vaguely remember they had problems with building
Python on Windows. I don't know if it's still an issue.

On Sun, Nov 25, 2012 at 9:44 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> git presently contains one Python extension command, Pete Wycoff's p4
> importer.  If my git-weave code is merged it will acquire another.
> I think we can expect more submissions of Python extensions in the
> future, for two good reasons:
>
> 1. Python has a much richer type ontology than shell; there are many
> things this makes relatively easy that are quite painful in shell.
>
> 2. While Perl shares advantage #1, compared to Python it's a
> maintainability mess - much more difficult to read 6 months later.
>
> On the other hand,
>
> 3. Attitudes in the git dev group seem to be influenced by a
> perception that up-to-date Python versions are not as reliably present
> on our target platforms as Perl is.
>
> 4. Python has the disadvantage that comes with robust growth; you have
> to specify "version x.y or later" as a dependency, mainly because new
> modules keep getting getting folded into the stock Python environment.

These may apply to other languages as well. Where do we draw a line?


> Previous conversation on the list suggests that there has been a tacit
> policy of managing these problems by (a) discouraging (though not entirely
> forbidding) Python extensions, and (b) requiring extension submitters to
> document some dependency on language version.
>
> I think this is suboptimal.  By not forbidding the Python language
> entirely, we guarantee having to deal with problems 3 and 4 anyway -
> but by discouraging it, we're buying significant long-term
> maintainability costs. It especially disturbed me to hear of Python
> commands being recoded in C - that is definitely not the right
> direction for reducing expected defect counts, if only because of
> memory-management issues.
>
> We're behind the best-practices curve here.  The major Linux
> distributions, which have to deal with almost the same set of
> tradeoffs we do, went to Python for pretty much all glue and
> administration scripts outside /etc a decade ago, and the decision has
> served them well.
>
> That, among other things, means up-to-date versions of Python are
> ubiquitous unless we're looking at Windows - in which case Perl and
> shell actually become much bigger portability problems.  Mac OS X
> has kept up to date, too; Lion shipped 2.7.1 and that was a major
> release back at this point.
>
> To be fair, there was a time when being a bit twitchy about Python
> version skew and deployment breadth was justified, but I believe that
> time is now well past us. My basis for believing this is very simple -
> I maintain a lot of Python code for systems programmers with stiff
> portability requirements (things like reposurgeon, coverity-submit,
> freecode-submit, shipper, and the Python tools in gpsd). I know what
> kinds of bug reports I get and what kinds I don't, and in the last
> few years "this breaks on my Python version" has gone from unusual
> to doesn't-happen.
>
> I think my experience with gpsd is particularly instructive.  Like
> git, that project has a C core with Python wrappers and extension
> components. Like git, it gets deployed in a lot of odd places by people
> who cannot afford the time to be tolerant about cross-platform
> problems and are quite willing to hit the maintainer with a clue-bat
> when they encounter them.  The good news is - they don't have to.
>
> I should also point out that none of Mercurial's problems seem to
> have anything to do with the fact that it's written in Python...
>
> I think we can choose a better policy based on some simple premises.
>
> 1) In 2012, we can specify a "floor" Python version of 2.6 (shipped in
> 2008) and be pretty much guaranteed it will be anywhere we want to
> deploy except Windows.  Windows will remain a problem because Python
> isn't part of the stock install, but that's an equal or worse problem
> for shell and Perl - and at least the Python project ships a binary
> installer for Windows.
>
> 2) Python extension commands should test the Python version on startup
> and die loudly but gracefully in the rare case that they don't find
> what they need.
>
> 3) We should be unconditionally be encouraging extensions to move
> from shell and Perl to Python.  This would be a clear net gain is
> portability and maintainability.
>
> 4) We should be encouraging C code to move to Python, too.  There's
> little gain in portability on this path because modern C has cleaned
> up its act a lot, but the drop in expected bug loads would be well
> worth the porting effort.  Segfaults are not your friend, and the x2 to
> x5 drop in line count would do very good things for long-term
> maintainability.
> --
>                 <a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
>
> Live free or die; death is not the worst of evils.
>         -- General George Stark.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy

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
