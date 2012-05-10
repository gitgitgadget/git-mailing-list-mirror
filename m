From: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
Subject: OT: gmane address mangling selectors
Date: Thu, 10 May 2012 13:19:12 -0400
Message-ID: <20120510171912.GA29972@sigill.intra.peff.net>
References: <20120504052106.GA15970@sigill.intra.peff.net>
 <20120504052725.GD16107@sigill.intra.peff.net>
 <7v7gwrc212.fsf@alter.siamese.dyndns.org>
 <20120507213752.GA19911@sigill.intra.peff.net>
 <20120510153754.GA23941@sigill.intra.peff.net>
 <7vd36cng6n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: magit+bncCN2hpKqZChCV8a_9BBoEnfcd5Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu May 10 19:19:24 2012
Return-path: <magit+bncCN2hpKqZChCV8a_9BBoEnfcd5Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-pz0-f58.google.com ([209.85.210.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCN2hpKqZChCV8a_9BBoEnfcd5Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SSX1K-0003Pn-Fx
	for gcvgm-magit-3@m.gmane.org; Thu, 10 May 2012 19:19:18 +0200
Received: by daev18 with SMTP id v18sf1025073dae.3
        for <gcvgm-magit-3@m.gmane.org>; Thu, 10 May 2012 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=h7v0eNdPIbnGwreMJgg+uFe5D6VumAFk3LO9NdKUcDc=;
        b=n3qM4XDXxhx1lwKagGdGcyIg+lDwkXwsYS1mf3SdYOWju65xNaoVuyAoOaxaVTdgeM
         xeab2+QjXf7KSq/kP1mzsS2puKrV/VhfYrsGfEU+97EMghlpMmGm8TrGwuO0YHJNaQfk
         H52nc1yU47uaXqpgahh9sRe5UZ5RJpaLdME5w=
Received: by 10.182.89.65 with SMTP id bm1mr60627obb.8.1336670357039;
        Thu, 10 May 2012 10:19:17 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.231.2.164 with SMTP id 36ls3574208ibj.5.gmail; Thu, 10 May
 2012 10:19:16 -0700 (PDT)
Received: by 10.42.150.2 with SMTP id y2mr2957343icv.7.1336670356250;
        Thu, 10 May 2012 10:19:16 -0700 (PDT)
Received: by 10.42.150.2 with SMTP id y2mr2957340icv.7.1336670356241;
        Thu, 10 May 2012 10:19:16 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id eo1si643350igc.0.2012.05.10.10.19.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 10:19:15 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff-AdEPDUrAXsQ@public.gmane.org designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 32331 invoked by uid 107); 10 May 2012 17:19:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 May 2012 13:19:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2012 13:19:12 -0400
In-Reply-To: <7vd36cng6n.fsf-s2KvWo2KEQL18tm6hw+yZpy9Z0UEorGK@public.gmane.org>
X-Original-Sender: peff-AdEPDUrAXsQ@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff-AdEPDUrAXsQ@public.gmane.org designates 99.108.226.0 as permitted sender) smtp.mail=peff-AdEPDUrAXsQ@public.gmane.org
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197604>

On Thu, May 10, 2012 at 09:39:44AM -0700, Junio C Hamano wrote:

> Jeff King <peff-AdEPDUrAXsQ@public.gmane.org> writes:
> 
> > PS It would have been nice to see the patch on the list for review. I
> >    only noticed it because it hit 'next', and had a minor conflict with
> >    my patches in the area.
> 
> Heh, it was sent before I gave you this message:

Ah, I never got that message. Probably because...

>         To: Jeff King <peff-AdEPDUrAXsQ-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>

...I have no clue where that address would end up.

> Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org> writes:
> 
>     Administrivia: these gmane-mangled e-mail addresses are extremely
>     annoying.  Please do not cross post with any insane list that choose
>     to turn that feature on when sending message to the git list; thanks.

Where do they come from? I notice that my address has been mangled
above, but I do not use gmane to either post or read the list. In fact,
looking at the start of the thread in my mailbox, I see:

  1. Eli posts[1], to: git@vger and magit@googlegroups; his from address
     looks normal, and there is no reply-to.

  2. You reply, to: a gmane-mangled address, cc: git@vger.

The presence of the magit list is obviously the unusual thing here, but
he did not involve gmane at all. If I recall correctly, you read the
list via gmane. So I believe it is your workflow that introduces the
mangled addresses on the reading end, not the sender.

It seems that this gmane "feature" is turned on by the presence of the
magit list, which I guess is configured at gmane to obfuscate emails.
But I don't see how the sender should be expected to know or care about
this gmane nonsense. It is your fault that the gateway through which you
read the messages is doing the mangling. So the right fix is not to
arbitrarily restrict cc-ing of other lists, but to fix the gmane bug[2].

-Peff

[1] mid:<20379.9312.943088.350379-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org>; the gmane link
    at http://thread.gmane.org/gmane.comp.version-control.git.magit/1308
    is mangled, but the original message as sent by vger looks fine (a
    copy of the headers that I received is included below).

[2] Without looking at the gmane code at all, I suspect the faulty logic
    is "mangle addresses for privacy if the message went to any list
    which requests this feature". But that is not right. The privacy was
    lost as soon as it went to any list that does _not_ mangle. And the
    unmangled version should be given to people accessing the sane list
    (it is slightly pointless to still mangle for the other list, since
    the privacy has been lost, but at least it is not actively bad). But
    given that my search for the mid at gmane turns up the magit
    version, I am guessing that they are storing only a single version
    of the message (mangled).

-- >8 --
Return-Path: <git-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Delivered-To: peff-AdEPDUrAXsQ@public.gmane.org
Received: (qmail 2012 invoked by uid 107); 28 Apr 2012 00:03:12 -0000
X-Spam-Level: *
X-Spam-Status: No, hits=-3.4 required=4.9
	tests=BAYES_00,KB_DATE_CONTAINS_TAB,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,TAB_IN_FROM
X-Spam-Check-By: peff.net
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Fri, 27 Apr 2012 20:03:07 -0400
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S1758065Ab2D1ACs (ORCPT <rfc822;peff-AdEPDUrAXsQ@public.gmane.org>);
	Fri, 27 Apr 2012 20:02:48 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:52945 "EHLO
	winooski.ccs.neu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757659Ab2D1ACg (ORCPT <rfc822;git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>);
	Fri, 27 Apr 2012 20:02:36 -0400
X-Greylist: delayed 3897 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Apr 2012 20:02:36 EDT
Received: from winooski.ccs.neu.edu (localhost.localdomain [127.0.0.1])
	by winooski.ccs.neu.edu (8.14.4/8.14.4) with ESMTP id q3RMvbEt019273;
	Fri, 27 Apr 2012 18:57:37 -0400
Received: (from eli@localhost)
	by winooski.ccs.neu.edu (8.14.4/8.14.4/Submit) id q3RMvbHJ019269;
	Fri, 27 Apr 2012 18:57:37 -0400
From:	Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <20379.9312.943088.350379-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org>
Date:	Fri, 27 Apr 2012 18:57:36 -0400
To:	git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Subject: Bug in git-stash(.sh) ?
X-Mailer: VM 8.2.0a under 23.2.1 (x86_64-redhat-linux-gnu)
Sender:	git-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Status: RO
Content-Length: 3206
Lines: 100
