From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] contrib: add win32 credential-helper
Date: Tue, 24 Apr 2012 16:21:08 -0400
Message-ID: <20120424202108.GB21904@sigill.intra.peff.net>
References: <1334861122-3144-1-git-send-email-kusmabite@gmail.com>
 <20120422180716.GA27339@sigill.intra.peff.net>
 <CABPQNSawsoheM6Qoxs-iQ-KYxYFs-s60oFLzdyRDFT0o=KXt1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncCN2hpKqZChC4ltz8BBoE0AIHUw@googlegroups.com Tue Apr 24 22:21:14 2012
Return-path: <msysgit+bncCN2hpKqZChC4ltz8BBoE0AIHUw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f58.google.com ([209.85.216.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCN2hpKqZChC4ltz8BBoE0AIHUw@googlegroups.com>)
	id 1SMmEb-0004yt-FC
	for gcvm-msysgit@m.gmane.org; Tue, 24 Apr 2012 22:21:13 +0200
Received: by qadb17 with SMTP id b17sf385715qad.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 24 Apr 2012 13:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition
         :content-transfer-encoding;
        bh=6ptDw6XAjxHRO96U7Nk/0PAhYz/8BS8nii4d3s2WAiQ=;
        b=PmO7ZBF1ucMuwDs7EZIDKdZ85YShAGYVaNECCUFkusnu5DOWFD7yReWoKCFvEe5Z2G
         Kdbwip3U0e94/5X72WU5KV8/81YyAfuGVdD4YSXT73yDt45S06lRMGZom6Q7Bxk1mPGU
         aJ9iM31OrBJcjw5VP+70HpxpzUFt3AY8fC62s=
Received: by 10.50.36.230 with SMTP id t6mr4836617igj.5.1335298872224;
        Tue, 24 Apr 2012 13:21:12 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.188.136 with SMTP id ga8ls8397517igc.0.canary; Tue, 24 Apr
 2012 13:21:11 -0700 (PDT)
Received: by 10.50.47.201 with SMTP id f9mr9464400ign.5.1335298871222;
        Tue, 24 Apr 2012 13:21:11 -0700 (PDT)
Received: by 10.50.47.201 with SMTP id f9mr9464398ign.5.1335298871212;
        Tue, 24 Apr 2012 13:21:11 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id hq2si7441897igc.3.2012.04.24.13.21.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 13:21:11 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 18945 invoked by uid 107); 24 Apr 2012 20:21:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Apr 2012 16:21:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Apr 2012 16:21:08 -0400
In-Reply-To: <CABPQNSawsoheM6Qoxs-iQ-KYxYFs-s60oFLzdyRDFT0o=KXt1w@mail.gmail.com>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 99.108.226.0 as permitted sender) smtp.mail=peff@peff.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196247>

On Mon, Apr 23, 2012 at 06:05:57PM +0200, Erik Faye-Lund wrote:

> > Sorry, I've been traveling and haven't had a chance to look at this
> > in-depth yet. I'll do so next week. In the meantime, I wanted to point
> > out this similar project:
> >
> > =A0https://github.com/anurse/git-credential-winstore
> [...]
> But probably the biggest problem for Git for Windows is that it's
> written in C#, and we don't have a C# compiler in our tool-chain.

Yeah, that seems like a big one. I think it would be awesome if msysgit
could eventually ship with a credential helper, without people needing
to grab something externally.

-Peff

--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***

*** Please avoid top-posting. ***

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den
