From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 22:32:29 -0500
Message-ID: <535f1d4d8cbbb_762310ef30c9c@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
 <535D4085.4040707@game-point.net>
 <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
 <535D6EB1.9080208@game-point.net>
 <535e18cdc7bce_338911e930c72@nysa.notmuch>
 <87bnvl6bdg.fsf@fencepost.gnu.org>
 <535e8e4253196_45651483310b3@nysa.notmuch>
 <152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
 <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch>
 <CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: James Denholm <nod.helm@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 05:43:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Weywq-0008No-1X
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 05:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbaD2DnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 23:43:06 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:39638 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaD2DnF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 23:43:05 -0400
Received: by mail-oa0-f42.google.com with SMTP id i7so612011oag.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 20:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ETYAKPt9/afH5II1h9Qxxxx0lF4ROkehHSWiUmn+xbY=;
        b=oKUBtR4jl9Y2BMueppwCzhXWkmpEql3wOnfnLyOr/vCOsui9XWGKd+9C3JR+hBWlFL
         M0ECac9x8cH583OzNQGCI8kPg2ZxRa4t/5kKeeIGsUe7akj4jQq11A4Tpb3+LAISyb67
         licmsqYFEb6dsZKka2y8FO4MGJEDVusll1+EKoUhGEkd9/C4A8xNL4lXwT2z/E9PmBr2
         KLqgWX0rM4kQ1AIsKXsW1IHssALFo89obINpvQ3UBG+QzkP0yqNFiEP7DiyHVtZRAoDd
         A5lYsjRho45/f/O0hfffd8+CC5Tt3ymElhsZTLgqnFDFML9uYAo8opRzNKZVvytCUMWN
         Azsw==
X-Received: by 10.60.54.228 with SMTP id m4mr25269069oep.29.1398742984387;
        Mon, 28 Apr 2014 20:43:04 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id h1sm41215680obr.15.2014.04.28.20.43.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 20:43:03 -0700 (PDT)
In-Reply-To: <CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247517>

James Denholm wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > James Denholm wrote:
> >> It's not anybody else's job to take your patches and drizzle them in the
> >> honey of respectable discourse.
> >
> > It's nobody's job to do anything. This a collaborative effort and in a
> > collaborative effort everbody chimes in to do different things.
> 
> No, true, but my point was more related to that it's ones own "task",

It's still the same thing. Nobody gets assigned any tasks; people choose their
own tasks, and they might choose tasks that other people were doing.

> > It's not Jeff's patches, they are our patches, they are part of the project.
> > And it's not unusual for multiple people working on a patch series; oneperson
> > doing most of the work, another adding tests, another cleaning updocumentation.
> > It's also no unheard of from a person picking up a patch series somebody else
> > stopped working on.
> 
> This, of course, would be the _other_ case where a proposal's
> merits are already known and accepted by the community.

No. John might have sent a patch series X, and maybe he didn't explain
correctly how it would benefit the project. Later on Mark finds out how those
patches would be useful for himself and takes upon himself to get them merged,
so he cleans them up and send an updated version with a clear explanation of
how they would be useful.

It's still the same proposal X, but a different person and a different strategy
to get them merged.

In other words, the fact that the community has not yet accepted the merits of
an approach doesn't mean that another person cannot champion it.

> The default may be wrong, you and I might agree that the default is
> wrong, Junio and Torvalds and RMS and The Queen of England
> might all agree that the default is wrong... But if we all live across
> from a bread shop, it's going to be a difficult task for you to convince
> us to go hunting.

It doesn't matter if you want to go hunting and I want to buy bread, either one
of those is better than starving to death.

In the Git project though, we choose to starve to death. Neither were my
patches picked, nor did anybody else step up with a different proposal, we just
did nothing, which is what we always do.

-- 
Felipe Contreras
