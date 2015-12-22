From: Shawn Pearce <spearce@spearce.org>
Subject: Re: RefTree: Alternate ref backend
Date: Tue, 22 Dec 2015 11:11:06 -0800
Message-ID: <CAJo=hJswuPdLT0KtGdf_=UGxD7-5NjGk2mwFjRU=uYb-Su-y+A@mail.gmail.com>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
 <56796F37.1000600@alum.mit.edu> <CAJo=hJtPSxY1YZgEt1AA_ukgY9cTA=1tdv_F+nCetv_Ux9E=3g@mail.gmail.com>
 <567985A8.2020301@alum.mit.edu> <CAJo=hJtgfpZn0OjbQ=BVoO_=03yG0Czjfn9vX4RobWLYpNVENg@mail.gmail.com>
 <xmqq1taee1w9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 20:11:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBSLL-0005cK-A8
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 20:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbbLVTL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 14:11:28 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35975 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbbLVTL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 14:11:27 -0500
Received: by mail-vk0-f49.google.com with SMTP id f2so84185502vkb.3
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 11:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=deV0rDJOIOUd8o2z27Kb69IWbnP/L8MroGB7FWQJSyc=;
        b=S4QGhazFGXeaqYBIVrICyTpVtkW0ShbW7Lm7BTI/PKKai/m89e7uPHx6QiWKfizDQh
         AjLEWkbkVah+tCFpNoAWEp7bpOJNw8dfwsIRFfiiNORj9f5P7+Ck5Rby2iBkK+TWr55z
         0R4VXO/WYjHzSR7iMGqPFWkyHTvSf0Yezh6Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=deV0rDJOIOUd8o2z27Kb69IWbnP/L8MroGB7FWQJSyc=;
        b=UFEbgeBlTlOWQBZXyIREJbDkf8o9Jw9J67ZkNJUlTH4lPJGJJWF+yMcQ4fHCjjMsYn
         4FGgruM86heCstOY9tcfV/JWcL3T71iUzIVBe7JvPv6adQaX19s97dHnNOVQlzJ9v183
         xl4pmAJW4hYCLLxA7DUjYE1GCEse+xTj0swEu1tnjjRRAnIbMm3GKm/cJfVbCcU6jQX0
         rdf90crlbqbVMzYQRi2a7p9CJ0opTwG4DWZABwtO3MGhJFM/B86sRzZVBr+0hiuNE6i8
         WpYaCUHxAPiJu5509QZnFa3toAOx6FcEjNU6tokB2Gk1dhEWyPgRZIsh4/IZzuykvuVr
         X46w==
X-Gm-Message-State: ALoCoQk8nMi5lmDPwH3yDWre4aBKN8/ZFADkpg+lGeuGFnz2IHhvRhnceMAsHfhUQvRZ1ugWDC8PbRyed1nmUO9U85QToWjSHg==
X-Received: by 10.31.161.131 with SMTP id k125mr18034696vke.74.1450811486376;
 Tue, 22 Dec 2015 11:11:26 -0800 (PST)
Received: by 10.103.97.197 with HTTP; Tue, 22 Dec 2015 11:11:06 -0800 (PST)
In-Reply-To: <xmqq1taee1w9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282901>

On Tue, Dec 22, 2015 at 11:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>>> But really, aside from slightly helping
>>> disambiguate references from paths in the command line, what is it good
>>> for?
>>
>> Nothing really; today refs/ prefix is used to encourage to the tools
>> that you really meant refs/heads/master and not
>> refs/heads/heads/master or some other crazy construct. You can thank
>> the DWIMery inside the ref rev parse logic for needing this.
>
> Aren't you two forgetting one minor thing, though?
>
> A layout without refs/, i.e. $GIT_DIR/{heads,tags,...}, will force
> us to keep track of where the tips of histories are anchored for
> reachability purposes, every time you would add a new hierarchy
> (e.g. $GIT_DIR/changes)--and those unfortunate souls who run a
> slightly older version of Git that is unaware of 'changes' hierarchy
> would weep after running "git gc", no?

You still store them under refs/

All of the code that is handed a ref name knows its a ref name and not
a sha-1 object name in the objects directory.

The catch is a few things accept HEAD, MERGE_HEAD, FETCH_HEAD, etc.
Those have to be handled even though they aren't in the refs/
directory.
