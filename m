From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 10:23:10 -0700
Message-ID: <CA+55aFyadCxX_Ws5fUC0QXwYYyaAjC5TC=y+tVA+YUHX1o+-iQ@mail.gmail.com>
References: <20160421113004.GA3140@aepfle.de>
	<87lh473xic.fsf@linux-m68k.org>
	<CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
	<xmqqzismsxsu.fsf@gitster.mtv.corp.google.com>
	<20160421170815.GA10783@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 21 19:23:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atIJx-0004NH-4b
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 19:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbcDURXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 13:23:14 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:36321 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbcDURXN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 13:23:13 -0400
Received: by mail-ig0-f196.google.com with SMTP id kb1so11062191igb.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=tMS9NVpdhR87RRJyGFxcu5ufvy5zeOgyE9+jx/EW4Cs=;
        b=Fr39SPP+DH7TqEY4gCl0W4tySHmBhB/eGrX+k8WsA9Oka1dudQIJcNEkcsIQ3GbFUP
         VzNsZXEUhRXCx0PIq/HOuEIjoNkE83fKvVEzVzeDEmK/9fVPOPG3+Uqq9rNhYFGftGWt
         mQkDihpgoXJlfHUe7K9K+JefPnkcyk+G+hS6JDaDBqYxHsigNqLARdV9+jnPZZyjqCQQ
         1MvkNq83kxpWfgUu9DtBcIgyt31T94erdSsDTZHqnOjGLqOYQ28YxGG01E7wN9rOV2sQ
         Y/1s3phKOu+HWdn+LJPSOFBuwAROJ8Lvbbamv4i6K6rD3XO52Hq9OK5BQ5XJLq26/kCt
         2wXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=tMS9NVpdhR87RRJyGFxcu5ufvy5zeOgyE9+jx/EW4Cs=;
        b=BwsAQPAn/rINzPOZPGxaZiOJBGimssj4nrRQAPWQtH2uCctbigaA39UfQKy1w2z8Q6
         lcMO8w3/qD9mvlm16hpQmJEBsReoWTXqQawhgPNsfWHyWwVZEIgyDwG313XDJPMYlyv1
         /smLq7ELNgD9LqTQ6HKaSsrn6BVDRSXUkYd/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=tMS9NVpdhR87RRJyGFxcu5ufvy5zeOgyE9+jx/EW4Cs=;
        b=H+IOetpnRRoBv0Prt5Eo2vZ/HZ62VaW6VcQmKup2mJD5I0wRN78BysD9lhk+mNfOAz
         r4D+UZWHEmeiCr8BebyprUxA0fBw/ZzS7OCCdjT2LdZFDr79W4F6+bGku0TnUO72+jWL
         vE6VGa3IG+8U3vSMCaRkgbSJnSacekhAQQg/SsHiJxMl1pjXMtKRBrlWVaVosCwvJT75
         7E8lQ9J5Z1BJVagffznUS/e2K6JyO2Jok/uv9GxPvabtpH1RPKP7UA7DYExVljOaVKQb
         7/kE39ZO+oS3gasZlyJgYlY4/qqwhKxgzxAW1yZw79AFww/o/Lav+sTN6WMzHOy3CIAA
         mukg==
X-Gm-Message-State: AOPr4FXeB+7tSliB2CJEMt4JOnYfr2+tVM5oWu1evI5uYJ0x7QMFyyeKe9WtO36iEMyNxtzLerK2qct+WwS75w==
X-Received: by 10.50.120.198 with SMTP id le6mr5153151igb.25.1461259390824;
 Thu, 21 Apr 2016 10:23:10 -0700 (PDT)
Received: by 10.36.2.9 with HTTP; Thu, 21 Apr 2016 10:23:10 -0700 (PDT)
In-Reply-To: <20160421170815.GA10783@sigill.intra.peff.net>
X-Google-Sender-Auth: RyT0h3rJr9Yq6IFtk9pdnDrtOkU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292130>

On Thu, Apr 21, 2016 at 10:08 AM, Jeff King <peff@peff.net> wrote:
>
> Right, because it makes the names longer. We give the second-parent
> traversal a heuristic cost. If we drop that cost to "1", like:

So I dropped it to 500 (removed the two last digits), and it gave a
reasonable answer. With 1000, it gave the same "based on 4.6" answer
as the current 65536 value does.

> which is technically true, but kind of painful to read. It may be that a
> reasonable weight is somewhere between "1" and "65535", though.

Based on my tests, the "right" number is somewhere in the 500-1000
range for this particular case. But it's still a completely made up
number.

> However, I think the more fundamental confusion with git-describe is
> that people expect the shortest distance to be the "first" tag that
> contained the commit, and that is clearly not true in a branchy history.

Yeah.

And I don't think people care *too* much, because I'm sure this has
happened before, it's just that before when it happened it wasn't
quite _so_ far off the expected path..

> I actually think most people would be happy with an algorithm more like:
>
>   1. Find the "oldest" tag (either by timestamp, or by version-sorting
>      the tags) that contains the commit in question.

Yes, we might want to base the "distance" at least partly on the age
of the base commits.

>   2. Find the "simplest" path from that tag to the commit, where we
>      are striving mostly for shortness of explanation, not of path (so
>      "~500" is way better than "~20^2~30^2~14", even though the latter
>      is technically a shorter path).

Well, so the three different paths I've seen are:

 - standard git (65536), and 1000:
   aed06b9 tags/v4.6-rc1~9^2~792

 - non-first-parent cost: 500:
   aed06b9 tags/v3.13-rc7~9^2~14^2~42

 - non-first parent cost: 1:
   aed06b9 tags/v3.13~5^2~4^2~2^2~1^2~42

so there clearly are multiple valid answers.

I would actually claim that the middle one is the best one - but I
claim that based on your algorithm case #1. The last one may be the
shortest actual path, but it's a shorter path to a newer tag that is a
superset of the older tag, so the middle one is actually not just
better based on age, but is a better choice based on "minimal actual
history".

               Linus
