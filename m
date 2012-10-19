From: Jeff King <peff@peff.net>
Subject: Re: Re: Git for Windows and line endings
Date: Fri, 19 Oct 2012 16:59:33 -0400
Message-ID: <20121019205933.GC24184@sigill.intra.peff.net>
References: <CADKp0pyy=Nnv29LyhzAOX4B5wJNYnZ0h5d7zxNRyZxV2OGUSjg@mail.gmail.com>
 <CABPQNSZE7TP0G-uW1b1nbsNgpxYCEiD5KefS62GB5gZbWyZXDQ@mail.gmail.com>
 <alpine.DEB.1.00.1210190801490.2695@bonsai2>
 <CADKp0pxuFsSEeZoeemyaqhSJEcsjj1arEOsF4Ub8=76y7tkwHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Chris B <chris.blaszczynski@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBBOP6Q2CAKGQEXVZ424A@googlegroups.com Fri Oct 19 22:59:48 2012
Return-path: <msysgit+bncBDO2DJFKTEFBBOP6Q2CAKGQEXVZ424A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f58.google.com ([209.85.220.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBOP6Q2CAKGQEXVZ424A@googlegroups.com>)
	id 1TPJfX-0005w8-UM
	for gcvm-msysgit@m.gmane.org; Fri, 19 Oct 2012 22:59:48 +0200
Received: by mail-pa0-f58.google.com with SMTP id fb11sf717825pad.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 19 Oct 2012 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=d85S+tUfkdJ+aV2U/xk+b/jru4M7S8Th8aByYcfN60g=;
        b=zCf7/7abvT4RX60PmNGySw2kLthGn5PssyNIEV4HmcJpn0xbmbcj5av+g4cZaiBGjQ
         7p1txdAewcwN5QX9vj39er+tWlJ5k8Vq6xExYDYcAswVuvH5EKyqrOLUuu9A3/r4cYWP
         UyqZTMCaAi4UnBVkmXFr9ilzQKCGfVz0CYM6eebAdhu7pUxNb7PpVQZcy4hDv1jjxwGV
         0uRXoo8ikHU266IfiOm4Y+UHMx/t5W04UgtR+zdZ/TGyh8ii2oOtKkaUjq8HTY6gs+1I
         FbT96aIH18mWP7fubsIvIFUdig8m1lIUFd/pX1hNhYzI5TvH1CawyONVw4oqshFdLT2y
       
Received: by 10.50.169.103 with SMTP id ad7mr1549393igc.2.1350680378122;
        Fri, 19 Oct 2012 13:59:38 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.12.233 with SMTP id b9ls4136465igc.4.gmail; Fri, 19 Oct
 2012 13:59:37 -0700 (PDT)
Received: by 10.43.53.144 with SMTP id vq16mr1371976icb.26.1350680377039;
        Fri, 19 Oct 2012 13:59:37 -0700 (PDT)
Received: by 10.43.53.144 with SMTP id vq16mr1371975icb.26.1350680377026;
        Fri, 19 Oct 2012 13:59:37 -0700 (PDT)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id dx8si278681igc.1.2012.10.19.13.59.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Oct 2012 13:59:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 19079 invoked by uid 107); 19 Oct 2012 21:00:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Oct 2012 17:00:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2012 16:59:33 -0400
In-Reply-To: <CADKp0pxuFsSEeZoeemyaqhSJEcsjj1arEOsF4Ub8=76y7tkwHg@mail.gmail.com>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 75.15.5.89 as permitted sender) smtp.mail=peff@peff.net
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208064>

On Fri, Oct 19, 2012 at 10:39:27AM -0400, Chris B wrote:

> I would like to point out:
> - Git on Linux does not mess around with line endings. I can create
> and edit a file in either line ending on Linux and commit and still
> have it untouched.
> - Git on Windows via Cygwin also does not mess around.
> - If those flavors of Git don't mess around, why should msysgit do it?

Most platforms (i.e., the userspace of most unix-y distributions) do not
mess around with line endings, either, so it is easy to have a sane
default there. I think the Cygwin build just followed that existing
defaults.

But msysgit's behavior was directly responding to user complaints. And
there were a lot of them. I do not use Windows myself, so I have only
the perspective of reading the list discussions. And that only what
bleeds onto the git@vger list, not the msysgit list.

Searching for "crlf" on the list yields over 2300 messages, many of
which discuss specific problems people are having without CRLF support.
I do not think any decision in the open source world is final, and
correcting a wrong decision from the past should always be an option.
But I do not think it is constructive to say "your decision is wrong"
without responding to the arguments that led to that decision. All I see
in your email is "your default is not my preference" without responding
to the discussion and perspectives of others through the years.

> - Windows has been able to cope with UNIX line endings a long time; no
> developer is using a default Notepad to open files with high
> expectations. Any Windows development tool and editor worth anything
> I've used is able to handle both just fine.

Again, I do not use Windows, so my anecdotes are purely culled from the
list. But people have mentioned that Visual Studio is bad for writing
our CRLFs for files which already have LFs. This makes diffs unreadable,
and gives merges, rebases and cherry-picks lots of spurious conflicts.

> - If there was SO MUCH thought into this, then it was too much; it was
> the wrong thought. There should not have been much at all, and just
> allow Git to do what it does: store things *exactly* as you put it in.
> Allow the clients to worry about things like line endings should they
> have the need to worry about it. I'm not seeing how the revision
> system has any business making alterations to things one commits into
> it.

One of the problems is that people do not realize the issue until they
have built a lot of history with CRLFs or mixed line endings (which they
might not even realize until the project starts being used by somebody
with a different editor or platform), and then they have a very painful
flag day turning on these options and normalizing the repository.

-Peff

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
