From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Our official home page and logo for the Git project
Date: Fri, 11 Apr 2014 08:24:48 -0500
Message-ID: <20140411132448.GA5845@nysa.casa.local>
References: <xmqq7g6z4q6b.fsf@gitster.dls.corp.google.com>
 <534578b2e22e2_af197d3081@nysa.notmuch>
 <CAH5451kNoXobbh3-WBkewvKvNeFkV0P14Z55=qDN+Ak2WGkHSA@mail.gmail.com>
 <20140411114017.GC28858@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 11 15:34:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYbbZ-0000Tm-AX
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 15:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757519AbaDKNeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 09:34:50 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41754 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbaDKNes (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 09:34:48 -0400
Received: by mail-ob0-f174.google.com with SMTP id wo20so6012239obc.19
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qBgDeLFmbswb1+UYmiRH9Zdmm8gdu0AmB9ujo6LFNso=;
        b=0jCxXxUOlOCWaNjIcwwLbbg7YG3F/Dg+L+l1q6UsstnCBBua/fdJ2cL+YWRcMqkDyG
         Qt0UwXwTAiy7hyXoBxmRKzAWk0oI9xzXzgdt0kWiqGDgIyHPfoc86RFTqp+1F3NNWAeF
         husb+kNToMZMzhS/qPTnzDidIYmgo0FAxraaQkpkphuoQ+HwSJml9OKgU4IHfVUFGWj+
         LNw19mOMkzYfa8kN4tQu1kZkoOY1tQK5cHIH9GCq/FG2tKIQ54E5u7mE+FX6GcZxzTOx
         Ik55K4pYHLke1X47meqyP9UCIM6EzjsHjsO1WPVC5em78evsrJjzfPCzATaOWY2kXFE/
         eJRA==
X-Received: by 10.182.166.40 with SMTP id zd8mr19192425obb.25.1397223287764;
        Fri, 11 Apr 2014 06:34:47 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f9sm12368691obm.2.2014.04.11.06.34.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 06:34:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140411114017.GC28858@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246089>

Jeff King wrote:
> On Thu, Apr 10, 2014 at 10:24:24AM +1000, Andrew Ardill wrote:
> 
> > It's normal for an organisation to have a collection of logos to
> > choose from, with one 'official' version. For example, a black and
> > white version is useful for print. Similarly, it's useful to have a
> > couple of different contrast level/colours that can be used in the
> > appropriate situations.
> 
> There are a few options at
> 
>   http://git-scm.com/downloads/logos
> 
> for matching the logo to the background.

That doesn't change the fact that bright red is a horrible color, and
that bright red is used *by default*, as you can see here[1].

Moreover, even the black ones have the issue I already mentioned; they
picture the equivalent of two root commits (with no parents) that are
immediately merged, and the history continues, but who is interested in
the initial commits? And who has multiple root commits? No one.

I am willing to bet whomever designed this logo had never used Git in
his life.

My version of the logo is the equivalent of to head commits that diverge
from a common one, which is extremely common; everybody works on the
latest commits, and has multiple branches.

This is so obvious and simple, that I bet nobody even bother to analize
the logo, they all though "OK, I'm not a designer, it's a logo,
anything's fine for me".

Secondly, the logos that are not black, are bright red, which is
horrible; not only do they look bad in almost every situation due to the
contrast, but in a Git's mindeset red implies old, a minus, the hunk
removed, an error, which is not good. Even in the old logos[2] (whick
even gitk is using), there was always a "-" represented in red.

In my version green is used instead, which represent progress, a plus,
the hunk added, success.

> > There is nothing wrong with having alternates that have been approved
> > for various situations.
> 
> I'm not sure if this is how you meant it, but I want to emphasize that
> there is no "approval" necessary for using alternate logos. Saying
> "let's recognize this one as an official logo" is not meant to shut down
> the use of others. It is only meant to say "when people ask for an
> official logo (e.g., GSoC does so), this one is a good answer".

Yes, but that doesn't mean we should shut down our brains and just
accept anything as the main official logo (of which most of the
alternates would be based on).

I would actually like you (everyone) to be honest and answer this
question;

Have you actually analized the logo? Or are you just arguing against
change, because the logo is already used by git-scm.com, and related
stuff?

[1] http://felipec.org/contrast.png
[2] http://git-osx-installer.googlecode.com/files/GitLogo.jpg

-- 
Felipe Contreras
