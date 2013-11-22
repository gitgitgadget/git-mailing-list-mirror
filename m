From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2013, #05; Thu, 21)
Date: Fri, 22 Nov 2013 20:47:25 +0100
Message-ID: <CAFFjANQy72zLuxtpA+-nMhYEt=qfOu_FSszR8X7QNPTKBEi6tA@mail.gmail.com>
References: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com> <20131122102345.GC12042@sigill.intra.peff.net>
 <xmqq61rk1b52.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 20:47:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjwhj-0007SX-7E
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 20:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029Ab3KVTrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 14:47:47 -0500
Received: from mail-vc0-f175.google.com ([209.85.220.175]:48920 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605Ab3KVTrq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 14:47:46 -0500
Received: by mail-vc0-f175.google.com with SMTP id ld13so1179210vcb.34
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 11:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=39VrUWg/BNC1DhmfIEMesCOB4eK8/7e/biSUDIPJjY4=;
        b=sAeoWTX5ymUsdeHcWJcbxdBZwL54prqK5aL1PAOF8V/1sTIIh+Ib02T+zOramsHJyy
         7VKflULD/KEbg4qVsN3ncD5LiBm1gV7o9YLRImyKKoxzfeYmj5pwkBOABwo0h+YvKxhV
         /8WIpVrXvX/OZ1ac5QC93i/YIiZxWwtvRmF+DFU22yS1RmUHxuw9TWehC4DZMVxYMVya
         O2HWv9cs1sRzrFmr+iuDDti/EBsW0QKllWjLKXk6A0d9mHkz7ys+zfysA+FBS1S41W00
         M1HwKa3oKoghrWW/CdJ3tNNpz+XbMF5cKkVzGOd+Cgq7a7PJ04e6vbzO2zZc8hdiZ5aR
         PwWQ==
X-Received: by 10.52.230.35 with SMTP id sv3mr10956363vdc.27.1385149665945;
 Fri, 22 Nov 2013 11:47:45 -0800 (PST)
Received: by 10.220.87.142 with HTTP; Fri, 22 Nov 2013 11:47:25 -0800 (PST)
In-Reply-To: <xmqq61rk1b52.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238210>

On Fri, Nov 22, 2013 at 8:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Do we want to try this in 'next' post-1.8.5, or should I try to prod an
>> area expert like Shawn into doing another round of review?
>
> Yes ;-).
>
> I recall starting to read the series over and then got sidetracked
> in the middle and never finishing.  I'll try to make time sometime
> this weekend (we are still buried in boxes after the move, though,
> so no promises) myself.
>
> How close is this what you guys are running in production these
> days, by the way?

We are running a slightly older version of the patchset, because we're
still on 1.8.4 and the current reroll doesn't apply cleanly there.

If this could make it to `next` some time next week, that would work
out great for us, because we may start considering using `next` as a
partial or full deployment on our production machines

This also means that we could exercise the patchset and everything
else that is queued up in next release... You must remember all the
corner cases and bugs peff brings to the list every time we deploy a
new Git to production. Wouldn't it be nice to have a thorough checking
of the current iteration *before* the release, and not after? :)

*hint hint*
