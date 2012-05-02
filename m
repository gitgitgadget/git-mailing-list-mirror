From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: 1.7.10 doesn't show file pushstatus
Date: Wed, 2 May 2012 03:04:20 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1205020301560.27828@bonsai2>
References: <20120501010609.GA14715@jupiter.local> <20120501065832.GA17777@sigill.intra.peff.net> <20120501073326.GA21087@sigill.intra.peff.net> <20120501084048.GA21904@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Clemens Buchacher <drizzd@aon.at>, Junio C Hamano <gitster@pobox.com>, 
    dfowler <davidfowl@gmail.com>, git@vger.kernel.org, 
    msysgit@googlegroups.com, Paul Betts <paul@github.com>, 
    David Ebbo <david.ebbo@gmail.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncCLLz_5DuGxCakIL9BBoEtFFR7Q@googlegroups.com Wed May 02 03:04:26 2012
Return-path: <msysgit+bncCLLz_5DuGxCakIL9BBoEtFFR7Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f58.google.com ([209.85.161.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCLLz_5DuGxCakIL9BBoEtFFR7Q@googlegroups.com>)
	id 1SPNzW-0002bV-I6
	for gcvm-msysgit@m.gmane.org; Wed, 02 May 2012 03:04:26 +0200
Received: by faaa20 with SMTP id a20sf50815faa.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 May 2012 18:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=n+DUcoPKJ1S3iilBv+6oSBW0fLERWdFqnXDvzl4NLFc=;
        b=mgaVYest+zu/TsOecXvqut8HJTs8f9rHy0dmo2PoqjOG3HAMPLo1pvgOIqtncU6KnW
         OC7d5XimvUQz0svWF39P0qrqCS4gjYYh0/HtK7o5e/bfUDdV6Yq290vl5kEE+C9cscKF
         /tlk1GHHhLNDbWatPUwAovQYAfRXCT4sEgB6w=
Received: by 10.180.80.97 with SMTP id q1mr289388wix.3.1335920666076;
        Tue, 01 May 2012 18:04:26 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.78.134 with SMTP id b6ls3693454wix.4.canary; Tue, 01 May
 2012 18:04:24 -0700 (PDT)
Received: by 10.180.87.165 with SMTP id az5mr559256wib.4.1335920664544;
        Tue, 01 May 2012 18:04:24 -0700 (PDT)
Received: by 10.180.87.165 with SMTP id az5mr559255wib.4.1335920664534;
        Tue, 01 May 2012 18:04:24 -0700 (PDT)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.22])
        by gmr-mx.google.com with SMTP id n1si6511443wiy.0.2012.05.01.18.04.24;
        Tue, 01 May 2012 18:04:24 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted sender) client-ip=213.165.64.22;
Received: (qmail invoked by alias); 02 May 2012 01:04:23 -0000
Received: from 23.Red-81-44-254.staticIP.rima-tde.net (EHLO bonsai2.local) [81.44.254.23]
  by mail.gmx.net (mp016) with SMTP; 02 May 2012 03:04:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wfrwZIkSwyvALSdhlqqbW3xbjZuJNVH8xNzp9dF
	y8B6IXWF7GVnQx
X-X-Sender: gene099@bonsai2
In-Reply-To: <20120501084048.GA21904@sigill.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196775>

Hi Peff,

On Tue, 1 May 2012, Jeff King wrote:

> On Tue, May 01, 2012 at 03:33:26AM -0400, Jeff King wrote:
> 
> > In this case, send pack gets its arguments from the command-line, not
> > from the options set at the transport layer. Remote-curl will pass along
> > "--quiet" if we get that from the transport layer, but it does not
> > otherwise pass along the "progress" flag. So there are two problems:
> > 
> >   1. send-pack defaults its progress boolean to 0. Before 01fdc21, that
> >      was OK, because it meant "don't explicitly ask for progress". But
> >      after 01fdc21 that now means "explicitly ask for no progress", and
> >      the direct-transport code paths were updated without updating
> >      cmd_send_pack.
> > 
> >   2. There's no way to tell send-pack explicitly "yes, I would like
> >      progress, no matter what isatty(2) says". I doubt anybody cares
> >      much, but it probably makes sense to handle that for the sake of
> >      completeness.
> 
> The following patch series fixes this:
> 
>   [1/3]: send-pack: show progress when isatty(2)
>   [2/3]: teach send-pack about --[no-]progress
>   [3/3]: t5541: test more combinations of --progress

Thanks. I applied and pushed it after testing on Linux.

David, if you want to relieve me of maintenance burden in the future, you

# apply the patches

# push them to a fork on GitHub

# run the tests

# report back to the mailing list (including the outcome of the test --
  detailed, if it fails)

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
