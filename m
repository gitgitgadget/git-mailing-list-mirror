From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Thu, 4 Apr 2013 13:45:35 -0600
Message-ID: <CAMP44s2YbJEtpBXHyUGrPta8O8W3fT_TJJ0Cq4BhSJGk1ODPOQ@mail.gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
	<20130402200948.GF2222@serenity.lan>
	<2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
	<CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
	<871uaqrwrp.fsf@59A2.org>
	<7vip42i1r0.fsf@alter.siamese.dyndns.org>
	<87sj36qewa.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jed Brown <jed@59a2.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:46:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNq6p-0007Tx-5q
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764727Ab3DDTph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:45:37 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:47947 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764716Ab3DDTph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:45:37 -0400
Received: by mail-lb0-f182.google.com with SMTP id z13so3110012lbh.27
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=zp77kQzncSGZG4/d4w5kwXn74d8XPM6MCsUBamdj1Nw=;
        b=SgGIqhcQD40UtJs0Xb0i5dDOrkwmOczgFFCCs8shvmJezdQBa1E6JjcLA2r7A8sDsv
         oFAtz0dKEIkdjeYWIiuT7V9sYmy7fEveclF0nSSTC7qi278izUnz3vvS4evyB0RQEOnP
         9Jmr9gw3kpfP8wgEcVOnbpOk/RI302Sp/GPi4S7L+MhcnPeHKdS+PbTVjfKrwRGJl612
         T3eOls9jl+2+p8eJEbaFjN0YssqIIwEiWSeW6n2YO7rRzn79sJOrfu6gT0oCtxVP5rJK
         k0l5h/54NTIQcp1HDfW+rHMLMiJSZ7BKTQOc2l3humh4uDrsWVFKBTwmiHuyqilF0iwT
         zQfA==
X-Received: by 10.112.156.42 with SMTP id wb10mr4348170lbb.32.1365104735490;
 Thu, 04 Apr 2013 12:45:35 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Thu, 4 Apr 2013 12:45:35 -0700 (PDT)
In-Reply-To: <87sj36qewa.fsf@59A2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220080>

On Thu, Apr 4, 2013 at 1:23 PM, Jed Brown <jed@59a2.org> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> So,... is there a concrete proposal for _me_ to act on?  Do you want
>> to see contrib/remtote-hg out of my tree, and have it compete with
>> the other one (which also shouldn't be in my tree) in the open?
>
> Three months ago, I would have said yes.  Now I don't know.  It looks
> like remote-hg has improved and is perhaps stable enough to remain,

Really? There have been 22 changes since 3 months ago. You think a
project goes from droppable to decent in 22 commits? The fact that you
hit a bug doesn't make a project unworthy. I thought you said you were
not going to dwell in your value judgement.

> but
> I think it needs a much more complete test suite [1] and some visible
> documentation about its mapping semantics.

I don't see anything particularly valuable in gitifyhg's test suite.
Show me a single test-case that remote-hg fails that would make sense
to port, then we'll talk.

> There is no way a change
> like "force-push by default" should come without the user knowing about
> it.  (I don't think force-push should become the default in any case,
> but something is wrong with the process if there isn't a good way to
> communicate such behavioral turmoil.)  A separate project making its own
> releases has a more visible place to indicate such changes.

Tell me, what is the worst case scenario a forced push will create?
What would be this terrible turmoil?

> [1] Max and I have no love for the "obfuscated shell scripting" in
> gitifyhg's 'py.test'- and 'sh'-based test suite, and we expressed early
> on that we'd rather have git-style shell scripts.  So while porting
> these would provide a good start, they can't just be dropped into
> git.git.

Oh yes they can, it's very easy to port (although annoying), I ported
quite a few of them because it was impossible to debug through py.test
(because stderr was incompletely shown), so I was forced to do that,
but again, I didn't see much value in them and deleted them. Maybe if
we had some complex striping on errors, but not at the moment.

I would love to be proven wrong; show me a single test that is so
sorely needed in remote-hg.

Cheers.

-- 
Felipe Contreras
