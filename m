From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: branch.<name>.pushremote not working with push.default simple or upstream
Date: Fri, 7 Jun 2013 22:27:58 +0530
Message-ID: <CALkWK0=v2vF7oGG3yUAXfaGdodCrkbvmQA+z9hMcoeMUFGFgsg@mail.gmail.com>
References: <20130607124146.GF28668@sociomantic.com> <CALkWK0miONv_O67SHcfJoXq1x7xPvKu6uefg+TiPGbF-1WJ-bg@mail.gmail.com>
 <7v8v2lvs5s.fsf@alter.siamese.dyndns.org> <20130607161402.GH28668@sociomantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Leandro Lucarella <leandro.lucarella@sociomantic.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 18:58:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukzzw-0007Iv-0G
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 18:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383Ab3FGQ6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 12:58:40 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:52931 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755961Ab3FGQ6j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 12:58:39 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so4536696iea.18
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WF8xuO5MBYbKKBHIspG/rNEtaikN2KS4yTOsXO1vwmY=;
        b=YWGHHTqYOsBCFicDidPp3DKr2yKNQGIetZzVV6Ao1GPf1xH/XOMzqy0Q5WMLTlPExG
         FgdczGpaWcFCHwQYk53f8KYfLl7XoiLNhnJJjJ9EkBPh5npttxLT62GnOkDqmNfKgd+S
         FP8HEwXDw+oq9rQ4bBejPNWCKCxPmhm3YwMGQdXY8QWQuGJKjFMzZjDw/clVGHmeGTKG
         j6mZ3G5vqMMpcPtxjnRyIZiXyzVUkvX8xpUvTsoKuaKgb2IpRlZ7YnPSKt7yRaJ4wzml
         RHtqpSBBfT7GHYD2I4K2vBTWffo7IwUNNoMp7kkOkmFUQXv9LQH4Am7S2aqwMRgtpr26
         ySow==
X-Received: by 10.50.70.101 with SMTP id l5mr1603479igu.104.1370624318883;
 Fri, 07 Jun 2013 09:58:38 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 09:57:58 -0700 (PDT)
In-Reply-To: <20130607161402.GH28668@sociomantic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226648>

Leandro Lucarella wrote:
> Thanks for the detailed explanations, I think this would cover my use
> case. Just for clarification, here are some more details on this use
> case, which I think is becoming very popular among github users.
> We have a "blessed" repository (upstream in my case) and only a few
> people is able to push to it (let's call them maintainers). Every
> developer, including the ones with push access, have to go through peer
> reviewing and are not allowed to push their own commits to upstream. For
> peer reviewing, each have it's own public fork, that other people can
> review and merge/push if is good.

Yes, and I wrote it precisely to address this itch.  git/git is
origin, and artagnon/git is ram.  I just set remote.pushdefault to ram
and continue working as usual.

I apologize for not having thought hard enough about other
push.default modes: I personally use current, and like it very much.
As an added bonus, even new branches created with git checkout -b
hot-branch will get push to go to the right place; no need to set
upstream before pushing.
