From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove the line length limit for graft files
Date: Fri, 27 Dec 2013 23:51:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1312272347460.1191@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1312272146590.1191@s15462909.onlinehome-server.info> <20131227210447.GE20443@google.com> <alpine.DEB.1.00.1312272208070.1191@s15462909.onlinehome-server.info> <20131227215919.GF20443@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRB5UI7CKQKGQEJFFLTQI@googlegroups.com Fri Dec 27 23:51:36 2013
Return-path: <msysgit+bncBCZPH74Q5YNRB5UI7CKQKGQEJFFLTQI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f64.google.com ([209.85.214.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB5UI7CKQKGQEJFFLTQI@googlegroups.com>)
	id 1VwgFj-0004Ey-HZ
	for gcvm-msysgit@m.gmane.org; Fri, 27 Dec 2013 23:51:35 +0100
Received: by mail-bk0-f64.google.com with SMTP id d7sf846748bkh.19
        for <gcvm-msysgit@m.gmane.org>; Fri, 27 Dec 2013 14:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=HsiaVxIGji/iEBKuwiRzjo6GEgPJz4f4T/7jG1PAS3M=;
        b=NVruMUlD9GOpLlrk3tR0xgXrOMInIShP1hfn2PlpvYL61SeyH/Y7+Trn+dw22vnUOS
         IPgYxJ2mPM6Z/A6YA4zFuIx+G/FOGNk2YfoDdDqIFOakWQgZjR0a2jGshNuOAJdX/H6l
         jCXeO/WxZo+PLCgT4eV0Eb1zrhszix01X5O+OMcem/cGFpR2Bi6KnsaG5FMnftfpY4Cy
         kw3ufuSLtuIYgKJKdPX0ufBXfTDezpwHCVmzJih1kNaIVl6t4fy4VIZ5gwaKDf7GpFBt
         5e53fcb8t98+8eGtVgcNJX22vzxLgeJ+j/hFcP2j5ggCdCep9Z4euNbnzskMx+W1b0FW
         EOaQ==
X-Received: by 10.180.9.38 with SMTP id w6mr201840wia.9.1388184695157;
        Fri, 27 Dec 2013 14:51:35 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.8.6 with SMTP id n6ls2175167wia.32.canary; Fri, 27 Dec
 2013 14:51:34 -0800 (PST)
X-Received: by 10.180.211.136 with SMTP id nc8mr19062906wic.2.1388184694255;
        Fri, 27 Dec 2013 14:51:34 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id b3si1541735eez.0.2013.12.27.14.51.34
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2013 14:51:34 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MAQXq-1VlAzP3M3m-00BcFW
 for <msysgit@googlegroups.com>; Fri, 27 Dec 2013 23:51:33 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20131227215919.GF20443@google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:Etrdk1yuAYIjSZcSxyDk8r6sBStrb9+DOR5P8TyTQ/8H6Rn2o5H
 3e/z6H73iGZOb5n2bDjUQQjwG+zYiNpXo+3C/eB+XdtuAOLrHOMnfVL+RNBUAop7D7VLNN8
 vRELzhAVPYFbZq++g0S/b8TNoMAaJ530i0Y59k/YeFmxZn9yXz3GuaU6s+IAr17ethYDUCT
 X1hJoNTam6wt8+uFt87rg==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.22 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239755>

Hi Jonathan,

On Fri, 27 Dec 2013, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> 
> > it returns EOF only if ch == EOF *and* sb->len == 0, i.e. if no characters
> > have been read before hitting EOF.
> 
> Yep.  api-strbuf.txt even says so.

I never bothered to look ;-)

> Sorry for the nonsense.

Nope, no nonsense at all. I actually had a look only after your review,
and it definitely makes sense to double-check.

> For what it's worth,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

It is worth a lot. Believe me, I know just how thankless a task reviewing
is, and instead of getting praise for it, you even get abused by
contributors who would rather self-review their code for fear of having a
twist in their knockers pointed out publicly.

Your review makes the code better, even if it does not result in code
changes all the time: it increases the confidence that the code is good.

Thank you, Jonathan!
Dscho

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
