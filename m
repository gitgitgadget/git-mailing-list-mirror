From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Thu, 14 May 2015 17:56:51 -0400
Organization: Twitter
Message-ID: <1431640611.17436.18.camel@ubuntu>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
	 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
	 <20150513021556.GA4160@peff.net> <20150513045650.GA6070@peff.net>
	 <20150513224131.GC425227@vauxhall.crustytoothpaste.net>
	 <20150514042544.GA9351@peff.net>
	 <9350a00074264bb847210410a6f6c340@www.dscho.org>
	 <20150514173828.GA7966@peff.net>
	 <c2fd3e038c821ec340c085a825baabc7@www.dscho.org>
	 <xmqqwq0aj25e.fsf@gitster.dls.corp.google.com>
	 <20150514211727.GA15528@peff.net>
	 <xmqqoalmj0r8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 23:57:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt17l-0001hO-Bi
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934053AbbENV44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 17:56:56 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34691 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933771AbbENV4z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 17:56:55 -0400
Received: by qkgx75 with SMTP id x75so59131987qkg.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 14:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Z/Ws4KwtBo9zLThrU2NY/ogFV/vQowQKyW3Vks0fF6E=;
        b=b8dYL0TTI8h8fiTUUTGYVoeUJg/KCOsVXD41aRElOSuUttqR7kn7QHEdc7e4EIwRtW
         GDSEtU83kRZpdcs9FBjfZQCPe3/euYAvrvphEGMJiHzdjEE2/2NHFLdx3dopCX7cGsv8
         rr4OcNpjSAyktEoXuEpBS6QsrSKrlX/BtW7qo/SvD4C/ulrxCwVjiQ7U4t2xQXU1vRPW
         Lkad7sWo39a5f2QQwHfv5LFYBOLz3B1wf0dU1lb6wHyRiRf+7ag2fVSi8Uv5mJl3L7vy
         AMgI9FLpADp9Fm1yCOjUvEi/0B+VHfx0uBJAYLpoO6xZ+DX8faav3v5AFmAJkvvw2Sog
         QQjw==
X-Gm-Message-State: ALoCoQlk/yvOBCJ/wQ5c6r8WRyNgvkUaDyUOG/UCT3j+GQfnvVauO+5/MJyMlTz9rpefmg/YZ7Ie
X-Received: by 10.55.21.8 with SMTP id f8mr14031433qkh.2.1431640615287;
        Thu, 14 May 2015 14:56:55 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id f64sm231190qhc.37.2015.05.14.14.56.52
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 14:56:53 -0700 (PDT)
In-Reply-To: <xmqqoalmj0r8.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269108>

On Thu, 2015-05-14 at 14:40 -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Thu, May 14, 2015 at 02:10:53PM -0700, Junio C Hamano wrote:
> >> 
> >> What I'll be pushing out today will have some "interesting" mark-up
> >> in Documentation/git-cat-file.txt (on 'jch' or 'pu') from David's
> >> '--follow-symlinks' topic.  I think AsciiDoc formatting looks OK,
> >> but can you check it with both older (peff) and newer (dscho)
> >> asciidoctor to see how well it shows?  Look for --follow-symlinks
> >> in the output.
> >
> > What's in 366bc15e9 (your SQUASH) looks terrible with older asciidoctor.
> > The "[normal]" bumps us out of the list item, left-aligning all of the
> > other paragraphs, and then the "+" continuation is treated literally
> > (probably because we are not inside a block).
> >
> > I don't see any reason we cannot use normal "+" continuation here (but
> > the hanging paragraphs need to be left-aligned, then).
> 
> The use of [normal] with indented subsequent paragraphs is what
> David's patch changed from my earlier suggestion, which used the
> ugly bog-standard "+ with unindented paragraphs"; I was afraid that
> it may lead to a fallout like this X-<.
> 
> Thanks for checking.  David, I think we need a v12 after all.

The reason I used [normal] is because + caused even non-code to be
inside <pre><code> in the HTML (when I run make doc, anyway).  But I see
that fixing the hanging paragraph's left-alignment fixes that problem.
So I will send a v12.
