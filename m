From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] transport-helper: add trailing --
Date: Thu, 15 May 2014 05:00:13 -0400
Message-ID: <20140515090013.GB27033@sigill.intra.peff.net>
References: <20140515053214.GA12133@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBDO2DJFKTEFBBIEE2KNQKGQEHGEYUAI@googlegroups.com Thu May 15 11:00:19 2014
Return-path: <msysgit+bncBDO2DJFKTEFBBIEE2KNQKGQEHGEYUAI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f63.google.com ([209.85.160.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBIEE2KNQKGQEHGEYUAI@googlegroups.com>)
	id 1WkrWU-0003QC-09
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 11:00:18 +0200
Received: by mail-pb0-f63.google.com with SMTP id rr13sf217385pbb.8
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 May 2014 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=sB9EpMfkNCRhSuCzo6+Nt2s44ebJrdev5emhfcOO96w=;
        b=k+6Uy4tv3hHtuPJeTwRvCB2ryB9G62ZRoygPQ57MYLmZ7elQW86JcmThKOoAflnANM
         ACQ4v/Ud7lbJXxH7Nadi4EBaaUXaHDIserntC9VNKd9IE3kSbiH075VWgtfchK/SVwIm
         JEZx/B9YZfdJLU8iDiz1ps29wlvjZamt8XBOWl/oIr1GRzEEN8ErtQng+syaHyWQkf6L
         kSJvD3GVoXeWsKLPb/goydcivLDoyK9OgBQPDHHhXkmwY3j80xmlLPSNmYyI6LyRkm11
         Mv+r0VS4t/kPPt9NAD9eVCUb2/yOfC/duGOCT46J+rs4EOiVr29ZNufHjgK1aNpATMXX
         cBoA==
X-Received: by 10.50.61.144 with SMTP id p16mr982273igr.16.1400144416606;
        Thu, 15 May 2014 02:00:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.122.97 with SMTP id lr1ls286973igb.35.gmail; Thu, 15 May
 2014 02:00:15 -0700 (PDT)
X-Received: by 10.67.5.165 with SMTP id cn5mr1962298pad.9.1400144415850;
        Thu, 15 May 2014 02:00:15 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id b5si416654igl.0.2014.05.15.02.00.15
        for <msysgit@googlegroups.com>;
        Thu, 15 May 2014 02:00:15 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 21644 invoked by uid 102); 15 May 2014 09:00:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 May 2014 04:00:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2014 05:00:13 -0400
In-Reply-To: <20140515053214.GA12133@camelia.ucw.cz>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted
 sender) smtp.mail=peff@peff.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249076>

On Thu, May 15, 2014 at 07:32:14AM +0200, Stepan Kasal wrote:

> From: Sverre Rabbelier <srabbelier@gmail.com>
> Date: Sat, 28 Aug 2010 20:49:01 -0500
> 
> [PT: ensure we add an additional element to the argv array]
> 
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
> 
> Hi,
>   this patch was present in msysgit from Mar 2012.
> Do you like it?
> I'm sorry, there is no author signoff; is the patch small enough?

It needs an explanation in the commit message, too. As Felipe noted, I
do not think it would help with ambiguity, but it should not hurt, and
is a reasonable defensive thing to do (but I did not think about it too
long, so maybe Sverre has an example that needs it).

> diff --git a/transport-helper.c b/transport-helper.c
> index 0e7c330..a01ea47 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -429,7 +429,7 @@ static int get_exporter(struct transport *transport,
>  	/* we need to duplicate helper->in because we want to use it after
>  	 * fastexport is done with it. */
>  	fastexport->out = dup(helper->in);
> -	fastexport->argv = xcalloc(6 + revlist_args->nr, sizeof(*fastexport->argv));
> +	fastexport->argv = xcalloc(7 + revlist_args->nr, sizeof(*fastexport->argv));

It would be nice if this were an argv_array so we would not have to
worry about managing the array size. This is one of several spots that
leaks array memory that I have been meaning to fix.

I just posted a series that addresses those leaks and converts this
site. I do not want to hold your patch hostage to my series, but
depending on the review on my series, you may want to re-roll this on
top; you would drop the line above, and change:

> +	fastexport->argv[argc++] = "--";

to:

    argv_array_push(&fastexport->args, "--");

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
For more options, visit https://groups.google.com/d/optout.
