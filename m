From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Sat, 17 May 2014 00:24:11 -0500
Message-ID: <5376f27b74d9f_66768eb3048f@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <537693aee4fdd_3e4812032fcc@nysa.notmuch>
 <20140517021117.GA29866@debian>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: James Denholm <nod.helm@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 07:35:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlXHg-0001tL-BQ
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 07:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756320AbaEQFfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 01:35:17 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:65023 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145AbaEQFfP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 01:35:15 -0400
Received: by mail-oa0-f42.google.com with SMTP id j17so4022489oag.15
        for <git@vger.kernel.org>; Fri, 16 May 2014 22:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Hq4na4nUWwSCVc+xfFKaHFxNY+8q5/8AZJk6UbuuGNg=;
        b=Ac8iCtAa3ueQpAqTBm6bLdQ5mPHjvaKbtDkb5YayYceixjxnay0KJPnk6f35wzojvl
         TZH1t9068Kn2dzXAWDC9p/9PQ6SvewTrHmAC5rwq25A8VrHmEa673grPYa3NM4SdDeVL
         3ns04FrUZZGbQqVOkh9Y9R1EGJDA6NHCChth8qhtPykt2yrfQ4MyK72pmVlHiBqX+2EX
         lGNnZEMPMpaG0sAnDitb8Ec80m62ytRY5YD5W/4DmWIMHmKL4v5JS26BVQqMTJA4Nnbl
         G+H2SINoDP8lIB9PBhKLKRX9Gm90Y7kYEa40kIu+w6MnYTwUK+9FYJDeW9+Cs8/rb1ma
         RDCw==
X-Received: by 10.60.16.103 with SMTP id f7mr21809906oed.8.1400304915200;
        Fri, 16 May 2014 22:35:15 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cu7sm12131621oec.12.2014.05.16.22.35.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 22:35:14 -0700 (PDT)
In-Reply-To: <20140517021117.GA29866@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249438>

James Denholm wrote:
> On Fri, May 16, 2014 at 05:39:42PM -0500, Felipe Contreras wrote:
> > (...) I would venture to say you have never made a package in your
> > life.
> 
> And you have, Felipe? Let us see the years of experience you surely have
> in the field.

As a matter of fact, yes I've written many packages, for Debian, Fedora,
ArchLinux, and others. Even Windows installers.

But that's a red herring. Even if was the worst packager in history,
that doesn't make Junio's decision any more correct.

> > The fact that you think packagers of git would simply package
> > git-remote-hg/bzr as well is pretty appalling.
> 
> It's not an outlandish thought, in fact, I'd suggest it as probable -
> provided that they find the projects to be stable and of high quality.

Do you want to bet?

> You, or someone else, might have to tap them on the shoulder and play
> nice to _ensure_ they know about them (after all, we all know that
> packagers _never_ read READMEs, do they), but you're capable of that,
> I'm sure.

In my experience packagers scratch their own itches, and if
git-remote-hg/bzr are not their itch, I don't see why any amount of
nice poking would make them package them. Some other packager would have
to do it, not the Git packagers.

-- 
Felipe Contreras
