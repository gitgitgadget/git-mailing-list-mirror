From: Jeff King <peff@peff.net>
Subject: Re: t0008-ignores failure
Date: Wed, 29 May 2013 22:55:54 -0400
Message-ID: <20130530025554.GC19860@sigill.intra.peff.net>
References: <CABNJ2G+u96P+_=Q7it0KbK9E01qunz7XZ7e3zCZvaTaOUuTQqQ@mail.gmail.com>
 <51A6A7B7.4010802@gmail.com>
 <7vzjvdp5q8.fsf@alter.siamese.dyndns.org>
 <20130530025258.GB19860@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git List <git@vger.kernel.org>, Adam Spiers <git@adamspiers.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDO2DJFKTEFBBPP7TKGQKGQEKQ3KV5Y@googlegroups.com Thu May 30 04:55:59 2013
Return-path: <msysgit+bncBDO2DJFKTEFBBPP7TKGQKGQEKQ3KV5Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ve0-f192.google.com ([209.85.128.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBPP7TKGQKGQEKQ3KV5Y@googlegroups.com>)
	id 1Uht1y-0008Nn-SJ
	for gcvm-msysgit@m.gmane.org; Thu, 30 May 2013 04:55:59 +0200
Received: by mail-ve0-f192.google.com with SMTP id pb11sf2215757veb.19
        for <gcvm-msysgit@m.gmane.org>; Wed, 29 May 2013 19:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:date:from:to:cc:subject:message-id:references
         :mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=xgRZASEu9MF8GaQn7tlo+WNbUF/WbJSrhDoBCQwbFRI=;
        b=Rcl3wKifXb3F21hVhIQf0aKIpTtnWE/4gGwns4JudU36IbckalVJjjNVeIfPqn0XQq
         wFMXOCsb6VVbsJqb2GudAozHsoomxWgqZF16gzSsr0G/v51t+nY8CFbuzX+prOe75kV0
         GoA56mdz0IYjGaYiQejNq/8EqeyNu+O1uK0zcWmP+IZr/169ylFht+Hj4mw2YYlL4EP7
         PwbXR9rX//vwWmvG8IrZBP3fIt3Fe2spgt1AaQaUSVWSM2g4XACznzW/FI5t+Zl99XL5
         tPiFVRKosAne+kLImRQBQ1L04TyhERhIEIgc0DPJ4SGVXqBoG9SHpJZEtz0DgHbaAfQ5
         OYzQ==
X-Received: by 10.49.1.197 with SMTP id 5mr495184qeo.24.1369882557941;
        Wed, 29 May 2013 19:55:57 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.0.236 with SMTP id 12ls206059qeh.97.gmail; Wed, 29 May 2013
 19:55:57 -0700 (PDT)
X-Received: by 10.236.14.233 with SMTP id d69mr2865577yhd.51.1369882557037;
        Wed, 29 May 2013 19:55:57 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with ESMTPS id u22si906368yhh.7.2013.05.29.19.55.56
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 29 May 2013 19:55:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 9104 invoked by uid 102); 30 May 2013 02:56:37 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 May 2013 21:56:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 May 2013 22:55:54 -0400
In-Reply-To: <20130530025258.GB19860@sigill.intra.peff.net>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted
 sender) smtp.mail=peff@peff.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225915>

On Wed, May 29, 2013 at 10:52:58PM -0400, Jeff King wrote:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index ca6bdef..5d84705 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -600,7 +600,7 @@ fi
>  fi
>  
>  # Test repository
> -TRASH_DIRECTORY="trash directory.$(basename "$0" .sh)"
> +TRASH_DIRECTORY="trash directory:$(basename "$0" .sh)"
>  test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
>  case "$TRASH_DIRECTORY" in
>  /*) ;; # absolute path is good
> 
> reveals the breakage on Linux. And it seems that a lot of other tests
> break, too. I haven't looked into them yet, though.

Hrm. Just picking an example at random, t7006 fails because it uses
--exec-path="`pwd`". And of course colons are meaningful in any
PATH-like context. It would be nice to be able to handle that case
cleanly, but I think we would be breaking compatibility.

So while it would be nice to work on paths with colons everywhere, I
doubt it is worth the effort to start checking it through the whole test
suite.

-Peff

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
For more options, visit https://groups.google.com/groups/opt_out.
