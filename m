From: Jeff King <peff@peff.net>
Subject: Re: 1.7.10 doesn't show file pushstatus
Date: Tue, 1 May 2012 04:40:49 -0400
Message-ID: <20120501084048.GA21904@sigill.intra.peff.net>
References: <20120501010609.GA14715@jupiter.local>
 <20120501065832.GA17777@sigill.intra.peff.net>
 <20120501073326.GA21087@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, dfowler <davidfowl@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com,
	Paul Betts <paul@github.com>, David Ebbo <david.ebbo@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: msysgit+bncCN2hpKqZChCgw_78BBoEEp8rTQ@googlegroups.com Tue May 01 10:41:06 2012
Return-path: <msysgit+bncCN2hpKqZChCgw_78BBoEEp8rTQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f186.google.com ([209.85.214.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCN2hpKqZChCgw_78BBoEEp8rTQ@googlegroups.com>)
	id 1SP8du-0006yz-1B
	for gcvm-msysgit@m.gmane.org; Tue, 01 May 2012 10:41:06 +0200
Received: by obbuo13 with SMTP id uo13sf5078080obb.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 May 2012 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=sxwL7yXakf2bwROGnaPz9GQxk1+QAvXrB6gzwlysZc4=;
        b=lhMGYSVHOtZHd1HC+S/r7YipYnWD6anhKonw8Xm+su7PxKHOWbcBuQzboQoVcnEegH
         RpsxanBJsLcwYPlmlc/CFviLFv99MJG+XqN8G6oDsEyIa01zgOx7Y5U3Wc20jGieUkhk
         GQaxOcZlXbkscgolchtb8gpTmQW0UNXAtQZDA=
Received: by 10.50.88.169 with SMTP id bh9mr148636igb.1.1335861664872;
        Tue, 01 May 2012 01:41:04 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.202.5 with SMTP id ke5ls213639igc.2.gmail; Tue, 01 May 2012
 01:41:03 -0700 (PDT)
Received: by 10.42.169.67 with SMTP id a3mr18387780icz.8.1335861663326;
        Tue, 01 May 2012 01:41:03 -0700 (PDT)
Received: by 10.42.169.67 with SMTP id a3mr18387779icz.8.1335861663317;
        Tue, 01 May 2012 01:41:03 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id no9si8002694igc.0.2012.05.01.01.41.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 May 2012 01:41:03 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 1725 invoked by uid 107); 1 May 2012 08:41:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 04:41:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 04:40:49 -0400
In-Reply-To: <20120501073326.GA21087@sigill.intra.peff.net>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 99.108.226.0 as permitted sender) smtp.mail=peff@peff.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196669>

On Tue, May 01, 2012 at 03:33:26AM -0400, Jeff King wrote:

> In this case, send pack gets its arguments from the command-line, not
> from the options set at the transport layer. Remote-curl will pass along
> "--quiet" if we get that from the transport layer, but it does not
> otherwise pass along the "progress" flag. So there are two problems:
> 
>   1. send-pack defaults its progress boolean to 0. Before 01fdc21, that
>      was OK, because it meant "don't explicitly ask for progress". But
>      after 01fdc21 that now means "explicitly ask for no progress", and
>      the direct-transport code paths were updated without updating
>      cmd_send_pack.
> 
>   2. There's no way to tell send-pack explicitly "yes, I would like
>      progress, no matter what isatty(2) says". I doubt anybody cares
>      much, but it probably makes sense to handle that for the sake of
>      completeness.

The following patch series fixes this:

  [1/3]: send-pack: show progress when isatty(2)
  [2/3]: teach send-pack about --[no-]progress
  [3/3]: t5541: test more combinations of --progress

The first patch fixes (1) above, restoring send-pack's original behavior
(for remote-curl as well as anybody else who happens to call it). Note
that in doing so, it breaks "push --no-progress" for http remotes that
01fdc21 tried to fix. But it didn't actually fix it; it only appeared to
work because progress was _never_ on for http.  Fortunately, the
existing test in t5541 still passes because it's poorly written (it uses
both "--quiet" and "--no-progress", unmindful of the fact that the
latter does absolutely nothing).

The second patch fixes it correctly by propagating the options through
remote-curl (and as a bonus, it makes (2) above work). Other transport
helpers that use send-pack would want to do the same thing (but I don't
know of any that exist).

The third patch just expands the test coverage.

These are prepared directly on top of 01fdc21, so they can go on the
maint track.

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
