From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Fri, 02 May 2014 18:27:37 -0500
Message-ID: <536429e97cf5a_200c12912f094@nysa.notmuch>
References: <5363BB9F.40102@xiplink.com>
 <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
 <5363edc954f8e_70ef0f30c24@nysa.notmuch>
 <20140502214817.GA10801@sigill.intra.peff.net>
 <536414352fa24_1976139f2f0f9@nysa.notmuch>
 <20140502223612.GA11374@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 01:38:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgN24-0004JG-7d
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 01:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbaEBXiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 19:38:16 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:65066 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbaEBXiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 19:38:16 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so1170749obc.41
        for <git@vger.kernel.org>; Fri, 02 May 2014 16:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Vf/GKjlyDtNlWe2e8DU37/gkvQZmPqL4NE2dDwwo+6A=;
        b=FqrD9Yh5mB9vvyEckq5jiVqxM/pPdmaln03msxNld7Ky/r9C9DMbGZBP/tcztfcrqo
         0zZW07mDQ/jaPolyZxWuLQCP6ccawT5S/AFGpvI+j5u82p1+vCfzCrqDlNNtdO1IftL6
         wdTYzzR9pcY8t5blmJ8U8AECdzAYt9iFeSAng52z4lli51luE9x737eKqe5IdNdTb4dc
         WwcGwuezHv5DDxxL7BDnXt7NaMiXwsYu4hWrP2KfR+eGGz19zdr8/CK75YgZsw0e5YtY
         eBfhg74J5FVGIFLSiR4iDPikk9TYgLQjBiPJS7yp5RZxd4K6dR9SOflK7pWRjYKCw6aA
         gfsQ==
X-Received: by 10.182.75.225 with SMTP id f1mr4037434obw.66.1399073895722;
        Fri, 02 May 2014 16:38:15 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id dh8sm1992130oeb.10.2014.05.02.16.38.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 16:38:14 -0700 (PDT)
In-Reply-To: <20140502223612.GA11374@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248009>

Jeff King wrote:
> On Fri, May 02, 2014 at 04:55:01PM -0500, Felipe Contreras wrote:
> 
> > They can do:
> > 
> > % git pull origin master
> > 
> > That shouldn't revese the bases.
> 
> Then they have to remember to do that every time, no? That seems a
> little error-prone versus setting a config option.

Yes. However, since not many people do this, and they don't do it that
often that's not a big deal.

It's much more important to fix the issue the vast majority of users
face constantly.

> > > Such users are going to run "git pull origin master" or just "git pull"
> > > to get that merge.
> > 
> > I'd say the vast majority of users running "git pull" want the parents
> > reversed, the minority that doesn't can switch to "git pull origin
> > master" (or add a configuration).
> 
> I'm not sure I agree, but I don't think either of us has actual data.

Do you want me to go dig in the mailing list and point you to the
endless discussions?

I assure you, if this is not changed, we will have this discussion
again.

> > Most likely the consensus and the proposals will be ignored and nothing
> > will change as usual, but that's a different thing.
> 
> Is it truly necessary to make sniping comments like this at the end of
> each email? It _is_ being discussed right now, and these comments do
> nothing except irritate your readers. Please stop.

And it has been discussed before. If history is any indication, it will
be discussed again.

-- 
Felipe Contreras
