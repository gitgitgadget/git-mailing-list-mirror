From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Sat, 17 May 2014 00:25:30 -0500
Message-ID: <5376f2ca5c90d_65b915db2f877@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <20140516225228.GA3988@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 07:36:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlXIU-0004Oq-NN
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 07:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714AbaEQFge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 01:36:34 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:58573 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755929AbaEQFgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 01:36:33 -0400
Received: by mail-oa0-f41.google.com with SMTP id m1so4017015oag.14
        for <git@vger.kernel.org>; Fri, 16 May 2014 22:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=GXQMyD+6++g9f4i9lfwe+RJ5olA2VRa2MoafOyY6P3g=;
        b=Jz+GG5uXK+016tsdUVs/RNslKQRnHS9gD/roKX1EDAUcliVaTN1p6mwH2CgyEUJDCD
         JJ9supcPI1ndXz2C5d/TEDUvrEog0g6cGJljjZrpXDNlEqMjkcOE6sMS7DfFyy+6I0sx
         ExyicrIEqtsUx9YZjU2DomWmED5ovJhcCSym6N/3krSI2UxvZt/gFevNbrcsIEGns9WP
         9KArPy6A4XZjNEAPkRj454v3ij34CBEEMoqaO1eizhWncs7yrpgUjHUZDQDqPQGzGd7Y
         WrEVdoZ1+jaI2icDbi9UD1aOxiS7FSA8Nx8fHvDIOrR0nMVzzdC00Bd1mma4b7ApLSKL
         4ghw==
X-Received: by 10.60.37.99 with SMTP id x3mr21740143oej.65.1400304993427;
        Fri, 16 May 2014 22:36:33 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ci10sm12206584oec.0.2014.05.16.22.36.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 22:36:32 -0700 (PDT)
In-Reply-To: <20140516225228.GA3988@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249439>

Jeff King wrote:

> I agree with the line of reasoning you laid out in your email,
> especially:

What a shock.

> > I would say that the options I see are these three, and I would rank
> > the "warn every time" as less helpful to end-users:
> > 
> >  - rename contrib/remote-helpers to contrib/obsolete-remote-helpers
> >    and add README to point at the upstream.
> > 
> >  - remove contrib/remote-helpers scripts and add README.
> > 
> >  - warn every time the user runs the scripts.
> 
> I hadn't thought of the rename idea, and it would address the concerns I
> brought up. I do think "obsolete" is the wrong word, as it sends the
> wrong message. The helpers are not obsolete; it is our _copy_ of them
> that is.

Originally you said you would respect if I wanted the code out
for v2.0, I said I would like it out at some point, not necessarily in
v2.0. Junio said he was fine with that, but the proposals above don't do
that.

Now it seems you are changing your mind and you are OK with the code
remaining in.

Do what you will, but I already told you what I will do in response.

-- 
Felipe Contreras
