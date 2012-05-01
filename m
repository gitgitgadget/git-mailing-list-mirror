From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] t5541: test more combinations of --progress
Date: Tue, 1 May 2012 05:37:19 -0400
Message-ID: <20120501093719.GA7538@sigill.intra.peff.net>
References: <20120501084048.GA21904@sigill.intra.peff.net>
 <20120501084307.GC4998@sigill.intra.peff.net>
 <20120501093501.GB22633@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, dfowler <davidfowl@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com,
	Paul Betts <paul@github.com>, David Ebbo <david.ebbo@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: msysgit+bncCN2hpKqZChDU3f78BBoEEUDExw@googlegroups.com Tue May 01 11:37:26 2012
Return-path: <msysgit+bncCN2hpKqZChDU3f78BBoEEUDExw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-iy0-f186.google.com ([209.85.210.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCN2hpKqZChDU3f78BBoEEUDExw@googlegroups.com>)
	id 1SP9WP-0006oa-FD
	for gcvm-msysgit@m.gmane.org; Tue, 01 May 2012 11:37:25 +0200
Received: by iaae16 with SMTP id e16sf5288040iaa.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 May 2012 02:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=nOjYVQ21e0g3UJ4eq5ykU9fat662pg0Yk5MkotkN578=;
        b=EuGiclmcxhDzataFamqaYKOgdMXfySlxM3NYUdJwhVO2Xe3FOvHI7xJrMVf0Rp1HUl
         O3PhRWQLMUsJxMBpUyRk1kKCVlB3E/PMw7fkJxTEyUBICNc8mfve8PzFqCFtK98z25BP
         7guIBC+HOn340v3LiKU/L39epkICq2H6Gsdi8=
Received: by 10.50.209.98 with SMTP id ml2mr158510igc.6.1335865044481;
        Tue, 01 May 2012 02:37:24 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.217.197 with SMTP id pa5ls2911693igc.4.canary; Tue, 01 May
 2012 02:37:24 -0700 (PDT)
Received: by 10.43.53.73 with SMTP id vp9mr18504381icb.0.1335865043995;
        Tue, 01 May 2012 02:37:23 -0700 (PDT)
Received: by 10.43.53.73 with SMTP id vp9mr18504380icb.0.1335865043985;
        Tue, 01 May 2012 02:37:23 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id dd7si8078226igc.0.2012.05.01.02.37.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 May 2012 02:37:23 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 2479 invoked by uid 107); 1 May 2012 09:37:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 05:37:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 05:37:19 -0400
In-Reply-To: <20120501093501.GB22633@ecki.lan>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196676>

On Tue, May 01, 2012 at 11:35:01AM +0200, Clemens Buchacher wrote:

> Can we add this on top or squashed in? I regret using tee when I
> originally wrote the test.
> 
> --8<--
> Subject: [PATCH] t5541: check return codes
> 
> By piping output to tee, the return code of the command is hidden.
> Instead, redirect output to a file directly.

Ugh, absolutely. I blindly followed the existing style without thinking
about whether using tee was sane or not. And it's not. Thanks.

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
