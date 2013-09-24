From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] fetch: add missing documentation
Date: Tue, 24 Sep 2013 00:36:38 -0500
Message-ID: <CAMP44s1ezYMSuQRMp_SY1HqLiuyuf0tjuf3Fn6fXF2drODZ_iw@mail.gmail.com>
References: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
	<1379772563-11000-2-git-send-email-felipe.contreras@gmail.com>
	<20130924050343.GF2766@sigill.intra.peff.net>
	<CAMP44s1FFTS=wOcWBfqg3zt3TO-aM83oXHcGwBcwvt_HnXrn8g@mail.gmail.com>
	<20130924053023.GA5875@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 24 07:36:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOLIi-0005ff-70
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 07:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716Ab3IXFgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 01:36:40 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:32971 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab3IXFgk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 01:36:40 -0400
Received: by mail-lb0-f172.google.com with SMTP id x18so3409867lbi.17
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 22:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=deMKsBDDZJ3L4YYOoGJkRkR77Tg5F+5akbG1mfyA3fw=;
        b=WbM+KvHOd7Gp2XpDTtVigqTF1L6Bbpivh8dcds3sAervkIkI/OgkfHpNXhRY/Opg6o
         Z/20ByVPFgM++seSFTeYs4lW5WrSOj2FD2mbacbaNp/sqyddFEYD3WYcEYYcu1w9pYh8
         aw1W72n8sig1PoCaiywPhHOu469a3Xkm9s0yIt7JVCXClybmqVNJcHnKIHmdhP3DRjU8
         Z0rQzTNX4zeQ0IVpPqsMf5RNZi6fH5x9x9qVBeiRwmsMPDtogCobXv/i0flhfn+JefTG
         UZKwzHsfR2uJYA75OwmywXjP9mDELDROoXX7zeXeMmHEnGg3LLtYgQN9uPk8wJXZlohK
         RfOw==
X-Received: by 10.112.198.39 with SMTP id iz7mr9439344lbc.24.1380000998316;
 Mon, 23 Sep 2013 22:36:38 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Mon, 23 Sep 2013 22:36:38 -0700 (PDT)
In-Reply-To: <20130924053023.GA5875@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235265>

On Tue, Sep 24, 2013 at 12:30 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 24, 2013 at 12:23:21AM -0500, Felipe Contreras wrote:
>
>> > Should this be "upstream remote" rather than "upstream branch"? I don't
>> > think we should be looking at branch.*.merge at all for git-fetch.
>>
>> As a general user, how do I configure the "upstream remote"?
>
> Yeah, it's not a term we use elsewhere, so it's not great. Probably
> "default remote" would be better, or even just say "branch.*.remote for
> the current branch" or something.

Yeah, general users don't know what you are talking about when you say that.

> I dunno. I don't particularly like any of those, but I really dislike
> the imprecision of "upstream branch" in this case.

For most users it's the remote configured by:

% git branch --set-upstream-to foo
% git checkout -b foo origin/foo
% git checkout -t -b foo bar

So when they read "upstream branch" they know from where it got configured.

-- 
Felipe Contreras
