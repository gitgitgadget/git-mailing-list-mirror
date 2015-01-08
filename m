From: Jeff King <peff@peff.net>
Subject: Re: Probably a bug with "~" symbol in filenames on Windows
 7 x64 in git 1.9.5
Date: Thu, 8 Jan 2015 14:42:52 -0500
Message-ID: <20150108194252.GA19867@peff.net>
References: <CADb7K9rELHWgy_NYJWrSr9gZn7pcMvETv93d0j+u2fXinj5iTg@mail.gmail.com>
 <CAPc5daVddkaMkx=43nCeQKbbkrV6nExOqvEBJNyugzDQB2n6kQ@mail.gmail.com>
 <alpine.DEB.1.00.1501081100570.21312@s15462909.onlinehome-server.info>
 <20150108102815.GA4806@peff.net>
 <xmqqegr5f5ts.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Dmitry Bykov <pvrt74@gmail.com>, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDO2DJFKTEFBBP53XOSQKGQEPGXGACY@googlegroups.com Thu Jan 08 20:43:08 2015
Return-path: <msysgit+bncBDO2DJFKTEFBBP53XOSQKGQEPGXGACY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f188.google.com ([209.85.214.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBP53XOSQKGQEPGXGACY@googlegroups.com>)
	id 1Y9Iyu-0001oQ-Lv
	for gcvm-msysgit@m.gmane.org; Thu, 08 Jan 2015 20:42:56 +0100
Received: by mail-ob0-f188.google.com with SMTP id uy5sf1489654obc.5
        for <gcvm-msysgit@m.gmane.org>; Thu, 08 Jan 2015 11:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=q0yH3FJpIe2bElgQUPNH8TFfIMPpDNh+y4nb9LnX7r8=;
        b=m0lOkrhZO9QZFugMIej6z8VvTbT84nVimI6dwPU/YPz1vNB5xD4p9pdYNjRs6gDoLD
         4PNA4e8tM+l1FxayheNLSp0AldVkzKiy54BFkQxlFyvV6ACZiPmdwjLPtYC1/nQrp5E4
         6XywB6/vPOTUU8HztEG0S07C8UzRMOqHV8I+xzeNQ+BNdhHd+na3AwqjePge2cqsTeb9
         AZsa3xiPMYhK5+Ig9H3GZwdMO4+BhAf78xV/puhWI3nRgWlIGiCGeCKJpyBhj+DcBnbv
         MI4AzbnkQVnYe+7GRilCvcGfRKYJBWCGjs9h7gy1rK9Po2RX7tfYOheSQjAqhJVCSydb
         4OwQ==
X-Received: by 10.182.241.135 with SMTP id wi7mr28880obc.29.1420746175985;
        Thu, 08 Jan 2015 11:42:55 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.80.229 with SMTP id u5ls463560obx.23.gmail; Thu, 08 Jan
 2015 11:42:55 -0800 (PST)
X-Received: by 10.182.214.72 with SMTP id ny8mr8567123obc.18.1420746175518;
        Thu, 08 Jan 2015 11:42:55 -0800 (PST)
Received: from cloud.peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id ux1si1768271igb.1.2015.01.08.11.42.55
        for <msysgit@googlegroups.com>;
        Thu, 08 Jan 2015 11:42:55 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 13177 invoked by uid 102); 8 Jan 2015 19:42:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Jan 2015 13:42:54 -0600
Received: (qmail 30110 invoked by uid 107); 8 Jan 2015 19:43:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Jan 2015 14:43:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Jan 2015 14:42:52 -0500
Content-Disposition: inline
In-Reply-To: <xmqqegr5f5ts.fsf@gitster.dls.corp.google.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262212>

On Thu, Jan 08, 2015 at 11:08:47AM -0800, Junio C Hamano wrote:

> > I wonder if it is worth having a "git-only" mode for core.protectNTFS.
> > Turning it off entirely would make him susceptible to GIT~1 attacks.
> 
> Yes, I think having distinctions would make sense, but I am not sure
> if "git-only" vs "every questionable included" should be the
> classification.

Yeah, I agree with everything you said below (I should have said
"security-relevant" instead of "git-only" originally). I also agree that
there may be more than two classifications, but I do not know enough
about the severity of the bad effects of each type to judge. I'd leave
that to the folks on each platform.

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
