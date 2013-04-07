From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 00:14:54 +0530
Message-ID: <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
References: <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <20130407161209.GG2222@serenity.lan> <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 07 20:45:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOub1-0006r6-KH
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 20:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934274Ab3DGSpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 14:45:36 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:57352 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934271Ab3DGSpf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 14:45:35 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so5887882ieb.8
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 11:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=E3Ka8wdMcVUW4czxOAY6F3f0yWbVzGFoJEn8jsiWea4=;
        b=PVU+fDGP4OQzx2b3/zeuJviOPQNCoAvac1MKCsoh8To0v3CfBpZsMM/u/RZd98UefH
         WfXL3JPQaE2mH/D4aetRgfyxa3s2QN65wvuyT7CM4e0l/CKlP316PAblQWEggGGYS6W7
         kguI0RTttzfgABIDgRNn5l7457DuhykuVD2ZKJzozc5ATdePwb0Ys9h7br+k1M401et1
         43jyZoLNFrQk8kj/jeKquj6TsBpfMGGrqGBPnO3WIFB0IUv+AG13YDZaZ4qjvG/hEm/9
         b2UHz/LpPd8yruA8NwO0vOszkfS6KgX8OzUEzrOJHsttuTnmhbSiAVKhEYF7RiE6UKYJ
         rEUQ==
X-Received: by 10.42.50.202 with SMTP id b10mr10162964icg.7.1365360335512;
 Sun, 07 Apr 2013 11:45:35 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 11:44:54 -0700 (PDT)
In-Reply-To: <5161BC33.8060707@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220358>

Jens Lehmann wrote:
> Ram is plain wrong here (just like he is on "git rm" and "git mv",
> even though the latter is currently still in pu). This use case is
> handled by submodules for years now. Take a look at the "ignore"
> setting in .gitmodules which give you full control of the stat()s
> in submodules, in addition you have the repo-wide option
> diff.ignoreSubmodules.

Oh, I didn't know about ignore in .gitmodules.  Sorry about that.

> The whole feature list is full of red herrings like this which
> have nothing to do with the advantages of a new object, but talk
> about UI issues which are easy to solve in both worlds.

Really?  git-submodule.sh was written in 2007, and does not have git
mv or cd-to-toplevel restriction removed to date.  What does that say
about git-submodule?

I specifically said end-user's perspective.  Why exactly would I be
talking about the advantages of the link object?
