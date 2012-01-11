From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Re* Regulator updates for 3.3
Date: Wed, 11 Jan 2012 11:14:17 -0500
Message-ID: <CABURp0qwjNmHtgkCqdsOk7+_isbpGB6S43WudRgbvE4xnvGUOg@mail.gmail.com>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com>
 <CA+55aFyhoh0rT_ujuE1w3RpuR7kqivYFwPpm66VC-xtq1PiGUQ@mail.gmail.com>
 <20120110184530.GE7164@opensource.wolfsonmicro.com> <CA+55aFxXb7wqfrpozS6iH0k25y-+Uy8_Tavv59JXMhaWrjXLaw@mail.gmail.com>
 <20120110222711.GK7164@opensource.wolfsonmicro.com> <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
 <7vmx9v7z1r.fsf@alter.siamese.dyndns.org> <CA+55aFx5NATrpLnkMiV2vAxSAJPK7wkY2vyHbyeZGgT9+jP06w@mail.gmail.com>
 <7vehv77xeq.fsf@alter.siamese.dyndns.org> <CA+55aFzuGtJkQFDooSGWQ2_NiJVHN2E7S5dmOnWTYn8_s8Gg3g@mail.gmail.com>
 <7vzkdu7miv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 17:14:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl0p4-0003MJ-C5
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 17:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757648Ab2AKQOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 11:14:40 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:50601 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab2AKQOj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 11:14:39 -0500
Received: by werm1 with SMTP id m1so645643wer.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 08:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2Mf3noLWtk0K0U09V8T7wAZWGNeC22SGoLSY41KpT34=;
        b=X8eJIcdJC1UOltchIkjiawIaVuFe2BFrUjMrhfVGYvpuprKSxglwu0ChZktv/UbIhY
         5mTjrcrCmr3gukxqsQYIPadpx733Gz4sK9iI6ZqQH34DzrzX/AXXcIBNrZHUHKxhInOr
         HIFDt38maGtWHYrsaSfBXAu6c48VNXMaHZ60U=
Received: by 10.180.20.69 with SMTP id l5mr11834329wie.19.1326298478331; Wed,
 11 Jan 2012 08:14:38 -0800 (PST)
Received: by 10.216.19.82 with HTTP; Wed, 11 Jan 2012 08:14:17 -0800 (PST)
In-Reply-To: <7vzkdu7miv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188369>

On Wed, Jan 11, 2012 at 1:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
[...]
>
> With that caveat, the patch should look like this.
>
> -- >8 --
> Subject: [PATCH] merge: use editor by default in interactive sessions
>
> Traditionally, a cleanly resolved merge was committed by "git merge" using
> the auto-generated merge commit log message with invoking the editor.
>
> After 5 years of use in the field, it turns out that many people perform
> too many unjustified backmerges of the upstream history into their topic
> branches. These merges are not just useless, but they are more often than
> not explained and making the end result unreadable when it gets time for
> merging their history back to their upstream.

Typo, I think.  I believe you meant "they are more often than not not
explained", but as this is unclear, maybe you can use "they are
usually not explained" or "they more often than not go in without
explanation".

P
