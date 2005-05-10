From: Jon Seymour <jon.seymour@gmail.com>
Subject: Core and Not-So Core
Date: Wed, 11 May 2005 03:15:49 +1000
Message-ID: <2cfc4032050510101553d391b2@mail.gmail.com>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
	 <1115739511.16187.432.camel@hades.cambridge.redhat.com>
	 <2cfc4032050510092238259b63@mail.gmail.com>
	 <1115744609.16187.455.camel@hades.cambridge.redhat.com>
	 <2cfc403205051010151304d88a@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue May 10 19:09:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVYDq-00005O-T3
	for gcvg-git@gmane.org; Tue, 10 May 2005 19:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVEJRP7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 13:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVEJRP7
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 13:15:59 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:5239 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261708AbVEJRPt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 13:15:49 -0400
Received: by rproxy.gmail.com with SMTP id j1so893092rnf
        for <git@vger.kernel.org>; Tue, 10 May 2005 10:15:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ChDovYazsz0lyQTLKFgNSvd3GLI0LHSmq9QkcY6mTKLCjqZJOiHAXOF5BoFPhX7I+siwv7XiTVhfFjB7byJXjA1K8F7LlD5boj2ox0KaIug7IBpDvLhVZERqUgwLNmxW+J8ZTPQd5XDKp5KKtaLvIcaJ2fCrmX6grC+2l70YPw4=
Received: by 10.38.96.39 with SMTP id t39mr2142251rnb;
        Tue, 10 May 2005 10:15:49 -0700 (PDT)
Received: by 10.38.104.59 with HTTP; Tue, 10 May 2005 10:15:49 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <2cfc403205051010151304d88a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/11/05, David Woodhouse <dwmw2@infradead.org> wrote:
> On Wed, 2005-05-11 at 02:22 +1000, Jon Seymour wrote:
> > So, no, it's not a religious issue. If anything, it is being dogmatic
> > to insist that the sacred GIT repository structure only be manipulated
> > by 'C' tools blessed by the hands of Linus.
>
> Given the volatility of the structure -- at least the details if not the
> fundamentals -- it seems bizarre to want to reimplement it rather than
> just using the existing tools.

I did consider wrapping it - I really did. But after thinking about it
for a couple of weeks
I eventually came to the conclusion it would be a sub-optimal solution.

And I don't agree that the structure is volatile. The actual structure
of GIT repository has been rock-solid since Linus reversed the
compression-signature order. Yes, there has been the excellent delta
work that Nicholas has been working on, but a Java version doesn't
need to use that anymore than Linus himself does [ and last time I
checked (the mailing list), Linus was being rather conservative about
that ].

What _has_ been changing at a great rate recently is the behaviour of
the tooling layer.

So, if I want a stable foundation to build my stuff on, basing it on
the output of the C tools would be a huge mistake. No, I think it
would be far safer for me to build my tooling using assumptions that
have proven to be rock-solid over the last few weeks - the structure
of the GIT repository format itself.

>
> This is the same mentality which gives Eclipse a half-arsed SSH
> reimplementation which doesn't behave like normal SSH is configured to
> behave either, right?
>

David, I have nothing whatsoever to do with the Eclipse implementation
of SSH, so what exactly is your point? All Java programmers are
fundamentally brain-damaged? Grow up, please.

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
