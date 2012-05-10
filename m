From: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>
Subject: Re: OT: gmane address mangling selectors
Date: Thu, 10 May 2012 13:35:52 -0400
Message-ID: <20395.64632.583415.101007@winooski.ccs.neu.edu>
References: <20120504052106.GA15970@sigill.intra.peff.net>
	<20120504052725.GD16107@sigill.intra.peff.net>
	<7v7gwrc212.fsf@alter.siamese.dyndns.org>
	<20120507213752.GA19911@sigill.intra.peff.net>
	<20120510153754.GA23941@sigill.intra.peff.net>
	<7vd36cng6n.fsf@alter.siamese.dyndns.org>
	<20120510171912.GA29972@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
X-From: magit+bncCOHCzKWgHRD6-K_9BBoEjRy_gg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu May 10 19:35:55 2012
Return-path: <magit+bncCOHCzKWgHRD6-K_9BBoEjRy_gg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-yx0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCOHCzKWgHRD6-K_9BBoEjRy_gg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SSXHP-0003xg-5m
	for gcvgm-magit-3@m.gmane.org; Thu, 10 May 2012 19:35:55 +0200
Received: by yenq6 with SMTP id q6sf1952075yen.3
        for <gcvgm-magit-3@m.gmane.org>; Thu, 10 May 2012 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:mime-version:message-id:date:to:cc
         :subject:in-reply-to:references:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=wHCHaSBAzEJPoY7tB4Xph4SEpMtR2WIqvw3EyhcHfF8=;
        b=jOzB05LhEF1Jwc2IIbx475iCIBWM8BqxOvyrTpCfBigq0dISApBpYfEjrRqCOQxpZm
         HxYPgzTetmY7Zonwy44LfFxBulD+js4TNdFd0aDM2wjZRm9DjiDQTCfzidVcJzPxBhzy
         O8/gTwm6kjzdmLGYwGQOtXEQbM5IOPfkFW4eU=
Received: by 10.50.15.130 with SMTP id x2mr555135igc.5.1336671354237;
        Thu, 10 May 2012 10:35:54 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.231.48.9 with SMTP id p9ls1196464ibf.8.gmail; Thu, 10 May 2012
 10:35:53 -0700 (PDT)
Received: by 10.42.110.75 with SMTP id o11mr2986256icp.6.1336671353817;
        Thu, 10 May 2012 10:35:53 -0700 (PDT)
Received: by 10.42.110.75 with SMTP id o11mr2986255icp.6.1336671353808;
        Thu, 10 May 2012 10:35:53 -0700 (PDT)
Received: from winooski.ccs.neu.edu (winooski.ccs.neu.edu. [129.10.115.117])
        by gmr-mx.google.com with ESMTPS id e7si601278iga.3.2012.05.10.10.35.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 10:35:53 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org designates 129.10.115.117 as permitted sender) client-ip=129.10.115.117;
Received: from winooski.ccs.neu.edu (localhost.localdomain [127.0.0.1])
	by winooski.ccs.neu.edu (8.14.4/8.14.4) with ESMTP id q4AHZrxe029644;
	Thu, 10 May 2012 13:35:53 -0400
Received: (from eli@localhost)
	by winooski.ccs.neu.edu (8.14.4/8.14.4/Submit) id q4AHZqsq029641;
	Thu, 10 May 2012 13:35:52 -0400
In-Reply-To: <20120510171912.GA29972-bBVMEuqLR+SYVEpFpFwlB0AkDMvbqDRI@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197606>

A few minutes ago, Jeff King wrote:
> 
> The presence of the magit list is obviously the unusual thing here,
> but he did not involve gmane at all. If I recall correctly, you read
> the list via gmane. So I believe it is your workflow that introduces
> the mangled addresses on the reading end, not the sender.

IIRC, gmane intercepts a first-time post to a newsgroup->mailing list
using a mangled email that it gets and later forwards on your behalf
when you prove that you're human.  Or something like that.  The weird
thing is that it did that for a personal email -- maybe someone posted
a reply with CCs, where the usual thing is to have only newsgroups?

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
