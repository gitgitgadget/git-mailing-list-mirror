From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH 1/3] Add git-send-email-script - tool to send emails from git-format-patch-script
Date: Tue, 2 Aug 2005 21:30:42 -0400
Message-ID: <20050803013042.GF5762@mythryan2.michonline.com>
References: <11227978451100@foobar.com> <7vbr4jmhqe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 03:34:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0864-0002es-QE
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 03:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVHCBap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 21:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVHCBap
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 21:30:45 -0400
Received: from mail.autoweb.net ([198.172.237.26]:12765 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261440AbVHCBan (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2005 21:30:43 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E085i-0007tG-SV; Tue, 02 Aug 2005 21:30:42 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E08Fq-0003aE-00; Tue, 02 Aug 2005 21:41:10 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1E085i-00050x-AO; Tue, 02 Aug 2005 21:30:42 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbr4jmhqe.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 31, 2005 at 02:45:29AM -0700, Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> 
> > 	All emails are sent as a reply to the previous email, making it easy to
> > 	skip a collection of emails that are uninteresting.
> 
> I understand why _some_ people consider this preferable, but
> wonder if this should have a knob to be tweaked.
> 
> For example, I myself often find it very hard to read when
> a cascading thread goes very deep like this:
> 
>      [PATCH 0/9] cover
>        [PATCH 1/9] first one
>          [PATCH 2/9] second one
>           [PATCH 3/9] third one in the series
>             ...
> 
> and prefer to see this instead (this assumes your MUA is
> half-way decent and lets you sort by subject):
> 
>      [PATCH 0/9] cover
>        [PATCH 1/9] first one
>        [PATCH 2/9] second one
>        [PATCH 3/9] third one in the series
>        ...

In testing this, I think I figured out *why* the former is preferred -
it guarantees the sorting when in the standard mode of "order by date".

Since these emails are sent *very* fast, delivery order tends to be the
dominating factor in how they sort in your inbox, as they will all have
the same time.  So that's a trifle annoying.

Yes, sorting by subject will fix it, but "threaded + subject" is
actually something I'm not sure much of anything supports.  (It's not
instantly obvious how to do it in mutt, for example - though,
admittedly, Mutt may very well have a way to do it.)

I noticed this while testing my 2 new fixes - those will sent in a few
seconds.

-- 

Ryan Anderson
  sometimes Pug Majere
