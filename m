From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: Re: [RFH] GSoC 2015 application
Date: Wed, 25 Feb 2015 11:25:45 +0100 (CET)
Message-ID: <614912493.13990870.1424859945767.JavaMail.zimbra@imag.fr>
References: <20150218191417.GA7767@peff.net> <20150218193234.GA8298@peff.net> <5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org> <20150224120607.GA1906@peff.net> <ed760450b06fd41c8bcaea7aaf526b94@www.dscho.org> <20150224122846.GA2631@peff.net> <1029c184eae22b9d27fae5de2c04238b@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
        msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: msysgit+bncBC3OZIEKVABBBMGGW2TQKGQEJ7I4TRQ@googlegroups.com Wed Feb 25 11:25:54 2015
Return-path: <msysgit+bncBC3OZIEKVABBBMGGW2TQKGQEJ7I4TRQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC3OZIEKVABBBMGGW2TQKGQEJ7I4TRQ@googlegroups.com>)
	id 1YQZA9-0003TH-Mx
	for gcvm-msysgit@m.gmane.org; Wed, 25 Feb 2015 11:25:53 +0100
Received: by mail-wi0-f186.google.com with SMTP id r20sf1083042wiv.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Feb 2015 02:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:thread-topic:thread-index
         :mailscanner-null-check:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=fqeY9ZhiqQ6LCklmbZ+P11emIUiWs6DB2Yk7iW0kG4s=;
        b=aybmprvoUBOD6hlkq2wCVKI274K8XQ4yqtN0ByTFwLYTvLdQrLIoZj1s2jTw5qOwEh
         20NxatoSV4eAkBJSqB4msy2FRVugp+H3KFHfi4DmRn71J1hqcy10k6/095W3X65dye8q
         JWrHG+huXS4QvuNuDwFecgRPirnCMfpjaRjUBgwwmxdZ/054lEJRAMGBjUm9LCuMbBHt
         3dC7KH7WpChnRBUV+39FYPqP/uqzeveHIKVemPBS+/7G0dT3C3+Dhr62nvmiR6gc7AWg
         mrlGZsOrNMMraS8SQMPJT/xoL9EZrlQ5FtzCHWPIVBfXZ4iLfKjQCRuzDqGoQZcmz3i0
         U 
X-Received: by 10.180.39.75 with SMTP id n11mr24378wik.9.1424859953357;
        Wed, 25 Feb 2015 02:25:53 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.12.167 with SMTP id z7ls679343wib.23.canary; Wed, 25 Feb
 2015 02:25:52 -0800 (PST)
X-Received: by 10.180.80.7 with SMTP id n7mr2763716wix.0.1424859952137;
        Wed, 25 Feb 2015 02:25:52 -0800 (PST)
Received: from shiva.imag.fr (mx1.imag.fr. [2001:660:5301:6::5])
        by gmr-mx.google.com with ESMTPS id l8si1262959wia.0.2015.02.25.02.25.52
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Feb 2015 02:25:52 -0800 (PST)
Received-SPF: neutral (google.com: 2001:660:5301:6::5 is neither permitted nor denied by domain of matthieu.moy@imag.fr) client-ip=2001:660:5301:6::5;
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t1PAPj9X025143
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Feb 2015 11:25:45 +0100
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1PAPkfm007609;
	Wed, 25 Feb 2015 11:25:46 +0100
In-Reply-To: <1029c184eae22b9d27fae5de2c04238b@www.dscho.org>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF35 (Linux)/8.0.6_GA_5922)
Thread-Topic: GSoC 2015 application
Thread-Index: uENwDuez5ltGze/9SkBgEsN+0rKBGA==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 25 Feb 2015 11:25:45 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1PAPj9X025143
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1425464748.04488@BChsvkQpzshN0dz+PyZ/Gg
X-Original-Sender: matthieu.moy@grenoble-inp.fr
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 2001:660:5301:6::5 is neither permitted nor denied by domain of
 matthieu.moy@imag.fr) smtp.mail=matthieu.moy@imag.fr
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264381>

----- Original Message -----
> Hi Peff,
> 
> On 2015-02-24 13:28, Jeff King wrote:
> > On Tue, Feb 24, 2015 at 01:25:32PM +0100, Johannes Schindelin wrote:
> > 
> >> > Thanks! No rush, as we are not even accepted yet, but you can create a
> >> > profile at:
> >> >
> >> >   http://google-melange.com
> >> >
> >> > and ask to join the "git" project as a mentor.
> >>
> >> I guess I can only ask that after the org is accepted, I will do so
> >> when (and if) that is the case.
> > 
> > I think you can do it now; I had to create the project profile in order
> > to do the application. But again, no rush.
> 
> I tried, but there are no orgs listed as of yet when I click "Make
> connection".

Not sure what it's supposed to look like, but I think if you give us your username we can invite you as mentor.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
