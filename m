From: Jeff King <peff@peff.net>
Subject: Re: 1.7.10 doesn't show file pushstatus
Date: Tue, 1 May 2012 03:33:26 -0400
Message-ID: <20120501073326.GA21087@sigill.intra.peff.net>
References: <20120501010609.GA14715@jupiter.local>
 <20120501065832.GA17777@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: dfowler <davidfowl@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, Paul Betts <paul@github.com>,
	David Ebbo <david.ebbo@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: msysgit+bncCN2hpKqZChDLo_78BBoEgnLp2g@googlegroups.com Tue May 01 09:33:33 2012
Return-path: <msysgit+bncCN2hpKqZChDLo_78BBoEgnLp2g@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCN2hpKqZChDLo_78BBoEgnLp2g@googlegroups.com>)
	id 1SP7aW-0006WD-UT
	for gcvm-msysgit@m.gmane.org; Tue, 01 May 2012 09:33:33 +0200
Received: by yenl4 with SMTP id l4sf3906835yen.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 May 2012 00:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=CevrJOQU7H6uYUvpFVg0ookpCurwfFPRg4+gvm3y1LE=;
        b=PNMqX8PLwYbd89pff2cZ5OfSRrmQKSfERlE96yYFQx9RxzWrdofYLpMAV0miP2WRKM
         pfesFXgGCebbPlXtmRjPNORix6BwZHUxvfdVuPmH2wK75S2UcMNbnozxnAZgnv/v5QoG
         E9AkTBBcsgZULcAfF3Md53aqR+H3CIO2bXvek=
Received: by 10.50.220.167 with SMTP id px7mr119964igc.3.1335857611762;
        Tue, 01 May 2012 00:33:31 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.56.204 with SMTP id c12ls2850554igq.2.canary; Tue, 01 May
 2012 00:33:30 -0700 (PDT)
Received: by 10.50.214.102 with SMTP id nz6mr886583igc.4.1335857610524;
        Tue, 01 May 2012 00:33:30 -0700 (PDT)
Received: by 10.50.214.102 with SMTP id nz6mr886582igc.4.1335857610511;
        Tue, 01 May 2012 00:33:30 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id xn7si7911364igb.1.2012.05.01.00.33.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 May 2012 00:33:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 1164 invoked by uid 107); 1 May 2012 07:33:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 03:33:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 03:33:26 -0400
In-Reply-To: <20120501065832.GA17777@sigill.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196666>

On Tue, May 01, 2012 at 02:58:32AM -0400, Jeff King wrote:

> > I just updated to msysGit 1.7.10 and I noticed I don't see any details
> > while pushing (like file upload speed and % completion). Was this
> > intentionally removed? If so why?
> 
> No, it's a regression. I can reproduce it easily, and it bisects to
> Clemens' 01fdc21 (push/fetch/clone --no-progress suppresses progress
> output) which went into v1.7.9.2 (and v1.7.10).

Hmm. OK, I think I see what is going on. For most protocols, send_pack
happens without a separate process these days. So the stack is like:

  - transport_push
    - git_transport_push
      - send_pack

where the "progress" flag to send_pack is a boolean; we have already
figured out at the transport layer whether we want progress, and are
telling it what to do. Thus this hunk from 01fdc21 makes sense:

> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 71f258e..9df341c 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -58,7 +58,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
>                 argv[i++] = "--thin";
>         if (args->use_ofs_delta)
>                 argv[i++] = "--delta-base-offset";
> -       if (args->quiet)
> +       if (args->quiet || !args->progress)
>                 argv[i++] = "-q";
>         if (args->progress)
>                 argv[i++] = "--progress";

If we have been asked not to have progress, then we tell pack-objects
"-q" (which is, for historical reasons, the way to spell "--no-progress"
for pack-objects).

But send-pack is also a command in its own right, and gets invoked
separately for the --stateless-rpc case (i.e., smart http). In that case
you end up with:

  - transport_push
    - transport-helper.c:push_refs
      - [pipes to git-remote-https]
        - remote-curl.c:push_git
          - [forks send-pack]
            - cmd_send_pack
              - send_pack

In this case, send pack gets its arguments from the command-line, not
from the options set at the transport layer. Remote-curl will pass along
"--quiet" if we get that from the transport layer, but it does not
otherwise pass along the "progress" flag. So there are two problems:

  1. send-pack defaults its progress boolean to 0. Before 01fdc21, that
     was OK, because it meant "don't explicitly ask for progress". But
     after 01fdc21 that now means "explicitly ask for no progress", and
     the direct-transport code paths were updated without updating
     cmd_send_pack.

  2. There's no way to tell send-pack explicitly "yes, I would like
     progress, no matter what isatty(2) says". I doubt anybody cares
     much, but it probably makes sense to handle that for the sake of
     completeness.

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
