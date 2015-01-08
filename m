From: Jeff King <peff@peff.net>
Subject: Re: Probably a bug with "~" symbol in filenames on Windows
 7 x64 in git 1.9.5
Date: Thu, 8 Jan 2015 05:28:16 -0500
Message-ID: <20150108102815.GA4806@peff.net>
References: <CADb7K9rELHWgy_NYJWrSr9gZn7pcMvETv93d0j+u2fXinj5iTg@mail.gmail.com>
 <CAPc5daVddkaMkx=43nCeQKbbkrV6nExOqvEBJNyugzDQB2n6kQ@mail.gmail.com>
 <alpine.DEB.1.00.1501081100570.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Dmitry Bykov <pvrt74@gmail.com>, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDO2DJFKTEFBBQ5XXGSQKGQE755ZVGA@googlegroups.com Thu Jan 08 11:31:16 2015
Return-path: <msysgit+bncBDO2DJFKTEFBBQ5XXGSQKGQE755ZVGA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f187.google.com ([209.85.223.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBQ5XXGSQKGQE755ZVGA@googlegroups.com>)
	id 1Y9AKI-0002tx-3L
	for gcvm-msysgit@m.gmane.org; Thu, 08 Jan 2015 11:28:26 +0100
Received: by mail-ie0-f187.google.com with SMTP id rd18sf1146540iec.4
        for <gcvm-msysgit@m.gmane.org>; Thu, 08 Jan 2015 02:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=SCSn3moCWENtKfOSrFAhtFrygfz319qGONy/0TQz+xk=;
        b=UkGckXplxwuqbzLAbbeqXZP3pksIwXQoauq0h7TzUlNtcHyh3ZckcefMxo+lJ9HJMS
         nraBg+8bgDmSiX1AWNaU3avQl7g8TWdyJsFrc6QAHIClWyeUJVB0KneUdiTk4UYVlzky
         nVirkz71V8t3LMxz8o488KZBdCOnmESnJK/zEGaksc3pfMkWBRZ+fzWSIOQH1o9ouM4k
         N0mZv5MktlbohmnaGdS9B/c05EqF0KIOyFTzXXPHEl5SKZcT6UEPyW93at5zEwWTWHg9
         ChMnbjZ0NxqDYO1l1c/zslRRkwpqznQuYTh0dhTFJ+1keDqe41gzLwJpMqClBrx1yPeL
         Vbzg==
X-Received: by 10.140.96.52 with SMTP id j49mr14775qge.10.1420712900147;
        Thu, 08 Jan 2015 02:28:20 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.41.169 with SMTP id z38ls972149qgz.72.gmail; Thu, 08 Jan
 2015 02:28:19 -0800 (PST)
X-Received: by 10.236.30.41 with SMTP id j29mr5903155yha.28.1420712899684;
        Thu, 08 Jan 2015 02:28:19 -0800 (PST)
Received: from cloud.peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id qj12si1509878igc.2.2015.01.08.02.28.19
        for <msysgit@googlegroups.com>;
        Thu, 08 Jan 2015 02:28:19 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 22260 invoked by uid 102); 8 Jan 2015 10:28:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Jan 2015 04:28:19 -0600
Received: (qmail 26956 invoked by uid 107); 8 Jan 2015 10:28:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Jan 2015 05:28:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Jan 2015 05:28:16 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1501081100570.21312@s15462909.onlinehome-server.info>
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
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262189>

On Thu, Jan 08, 2015 at 11:06:18AM +0100, Johannes Schindelin wrote:

> ICON~714.PNG is a valid short name for a long name (such as
> 'icon.background.png') because it fits the shortening scheme (8.3 format,
> the base name ends in ~<n>). As this can clash with a validly shortened
> long name, Git for Windows refuses to check out such paths by default.
> 
> If you want the old -- unsafe -- behavior back, just set your
> core.protectNTFS to false (this means that you agree that the incurred
> problems are your own responsibility and cannot be blamed on anybody else
> ;-))

I wonder if it is worth having a "git-only" mode for core.protectNTFS.
Turning it off entirely would make him susceptible to GIT~1 attacks.

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
