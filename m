From: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>
Subject: Re: [git] Re: Bug in git-stash(.sh) ?
Date: Fri, 4 May 2012 14:57:33 -0400
Message-ID: <20388.9885.608325.489624@winooski.ccs.neu.edu>
References: <20379.9312.943088.350379@winooski.ccs.neu.edu>
	<87wr4za9mr.fsf@gmail.com>
	<m2pqasb8mr.fsf@linux-m68k.org>
	<xmqqvckk93ta.fsf@junio.mtv.corp.google.com>
	<CALO-gut4csy5wef4iGPGD5jVPc1f0iFBfS3MUWrOwc2yczdviw@mail.gmail.com>
	<20380.33897.666338.766096@winooski.ccs.neu.edu>
	<20120429220132.GB4491@sigill.intra.peff.net>
	<20381.49180.329586.983166@winooski.ccs.neu.edu>
	<20120501134254.GA11900@sigill.intra.peff.net>
	<20386.53745.200846.115335@winooski.ccs.neu.edu>
	<20120504052106.GA15970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Yann Hodique <yann.hodique-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Andreas Schwab <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
X-From: magit+bncCOHCzKWgHRCgzZD9BBoE7Wu-eg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri May 04 20:57:41 2012
Return-path: <magit+bncCOHCzKWgHRCgzZD9BBoE7Wu-eg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-pz0-f58.google.com ([209.85.210.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCOHCzKWgHRCgzZD9BBoE7Wu-eg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SQNhB-00063w-N6
	for gcvgm-magit-3@m.gmane.org; Fri, 04 May 2012 20:57:37 +0200
Received: by daev18 with SMTP id v18sf2477648dae.3
        for <gcvgm-magit-3@m.gmane.org>; Fri, 04 May 2012 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:mime-version:message-id:date:to:cc
         :subject:in-reply-to:references:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=xfUHkH8/mSVAyYnqIRjLPliBiIPkghjUzRofUgi74Xk=;
        b=U8fvl5Trtd/ypGUDQMpIjIPK2c0EVb3SAiLFFZ6dZKoCIpkivyq0aQZ2YDubxGnG2l
         NWjKYPuJJR1yiwCf2PdmOWq3ok0jf4LyoADNy6Juv9hEC/934IhBEGXkk9iTDFwDUKoj
         DLhJx6JQJ68y9SJGMV1pykVdl74HqB+kqqodg=
Received: by 10.50.216.133 with SMTP id oq5mr524536igc.4.1336157856367;
        Fri, 04 May 2012 11:57:36 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.50.151.199 with SMTP id us7ls1141929igb.1.canary; Fri, 04 May
 2012 11:57:35 -0700 (PDT)
Received: by 10.42.197.137 with SMTP id ek9mr5460959icb.5.1336157855679;
        Fri, 04 May 2012 11:57:35 -0700 (PDT)
Received: by 10.42.197.137 with SMTP id ek9mr5460956icb.5.1336157855667;
        Fri, 04 May 2012 11:57:35 -0700 (PDT)
Received: from winooski.ccs.neu.edu (winooski.ccs.neu.edu. [129.10.115.117])
        by gmr-mx.google.com with ESMTPS id e7si372346iga.3.2012.05.04.11.57.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 11:57:35 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org designates 129.10.115.117 as permitted sender) client-ip=129.10.115.117;
Received: from winooski.ccs.neu.edu (localhost.localdomain [127.0.0.1])
	by winooski.ccs.neu.edu (8.14.4/8.14.4) with ESMTP id q44IvYFl010034;
	Fri, 4 May 2012 14:57:34 -0400
Received: (from eli@localhost)
	by winooski.ccs.neu.edu (8.14.4/8.14.4/Submit) id q44IvXTe010031;
	Fri, 4 May 2012 14:57:33 -0400
In-Reply-To: <20120504052106.GA15970-bBVMEuqLR+SYVEpFpFwlB0AkDMvbqDRI@public.gmane.org>
X-Mailer: VM 8.2.0a under 23.2.1 (x86_64-redhat-linux-gnu)
X-Original-Sender: eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org designates
 129.10.115.117 as permitted sender) smtp.mail=eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org
Precedence: list
Mailing-list: list magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact magit+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <magit.googlegroups.com>
X-Google-Group-Id: 752745291123
List-Post: <http://groups.google.com/group/magit/post?hl=en_US>, <mailto:magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:magit+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/magit?hl=en_US>
Sender: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:googlegroups-manage+752745291123+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197048>

Earlier today, Jeff King wrote:
> On Thu, May 03, 2012 at 02:44:01PM -0400, Eli Barzilay wrote:
> 
> > > Once that is fixed, then we can consider whether something more
> > > should happen for stash (though I am inclined to say that is
> > > enough; it is a feature that you can do "git stash list
> > > --date=relative" to see the stash timestamps).
> > 
> > Since the general problem is bigger, how about just the quick
> > patch of adding --date=default in the list_stash function as a
> > stopgap?  That seems to be close enough to how it should work
> > anyway.
> 
> It is bigger in scope, but the fix is still pretty small. I was
> trying to trick^W gently prod you into making a patch, but that does
> not seem to have worked. :)

Apologies -- it wasn't clear to me what should be done to address the
general problem, and I don't think that I'd do a good job with that
anyway.

I can still make a proper patch with the fix for git-stash.sh that
avoids the problem with the spaces.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
