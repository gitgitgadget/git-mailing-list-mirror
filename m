From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: unneeded merge in the security tree
Date: Tue, 12 Mar 2013 14:54:04 -0700
Message-ID: <CA+55aFzWjfFjcRZXBO+edO7f66REA0pOsC3iZ2vYdHrkcovnHA@mail.gmail.com>
References: <20130312100950.e45ef0e721492ff0d5fd7c8d@canb.auug.org.au>
	<alpine.LRH.2.02.1303121510270.25612@tundra.namei.org>
	<20130312041641.GE18595@thunk.org>
	<CA+55aFzFLDcN-1GKae6Xqrns59K1xOD_HPzuv2Lv1__fZpqFMw@mail.gmail.com>
	<20130312212027.GE14792@thunk.org>
	<CA+55aFwHJtOU4Qzt3XZsER165kTc5P0ATQP2wPHvuUiVic8bnA@mail.gmail.com>
	<7vppz45lz9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Theodore Ts'o" <tytso@mit.edu>, James Morris <jmorris@namei.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Mar 12 22:54:40 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1UFX9b-0007tL-HK
	for glk-linux-kernel-3@plane.gmane.org; Tue, 12 Mar 2013 22:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933652Ab3CLVyI (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 12 Mar 2013 17:54:08 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:40564 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346Ab3CLVyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Mar 2013 17:54:06 -0400
Received: by mail-vc0-f176.google.com with SMTP id e10so183070vcx.21
        for <multiple recipients>; Tue, 12 Mar 2013 14:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=pHYSKCU/Cgcg/n4V3cSrSv/FmZI6f2MRW5Z5kS8M39s=;
        b=gh1w/oQSVQckTpJIKTLZE5LpKmfuZ4G5xuna1lJzwwfBgGzth1eNxBV/5LylQ6lKHD
         41JJZw4O54HcGCazTI1qkEPKOVpKyHv4iT6Yg3nekA3f/D3wwXW+AYjN0nBCHC2Eigs/
         y3o7sHoevlVYACmJnAAX4ZlW6r+wmRL2u3qEEC4VV0RTKdnXVIq6YwrO8DJ+5A6hg/Vs
         VfDr58gGrWk/6QL436BRArL0jx4dQ+7hw0fZLGxFb+iCTuB1WeV40MmeuZ0XawMqINlV
         ceTdwwWyLIbn0IHGL3F9EF6CPnw0g0nRC3Ep6ZB/aLmX/8xne97QtYBAv1Dd8sNbyQgf
         tVYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=pHYSKCU/Cgcg/n4V3cSrSv/FmZI6f2MRW5Z5kS8M39s=;
        b=U/DFDyOzHdanIfR/tSD4E1Q+q6LvClXWVaa49VAI2soSkGYQu2D5lNv8lq8/8aVyJn
         PsnPvLrYeaEZjEH8RjH7CVrllVcmLMdVtJRyNznBVHxX7ah5At/B7OkP9P42YcV21HlN
         AIbMUXvd7KmwqnzBNRI8vj/r26/nCYv13y1Nc=
X-Received: by 10.52.176.65 with SMTP id cg1mr6285974vdc.1.1363125244782; Tue,
 12 Mar 2013 14:54:04 -0700 (PDT)
Received: by 10.220.145.131 with HTTP; Tue, 12 Mar 2013 14:54:04 -0700 (PDT)
In-Reply-To: <7vppz45lz9.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: fxkciU2-jmDVxko7xC_QD6Q41bk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218001>

On Tue, Mar 12, 2013 at 2:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I agree that "--ff-only" thing is too strict and sometimes you would
> want to allow back-merges, but when you do allow such a back-merge,
> is there a reason you want it to be --no-signatures merge?  When a
> subtree maintainer decides to merge a stable release point from you
> with a good reason, I do not see anything wrong in recording that
> the resulting commit _did_ merge what you released with a signature.

No, there's nothing really bad with adding the signature to the merge
commit if you do make a merge. It's the fact that it currently makes a
non-ff merge when that is pointless that hurts.

That said, adding the signature from an upstream tag doesn't really
seem to be hugely useful. I'm not seeing much of an upside, in other
words. I'd *expect* that people would pick up upstream tags
regardless, no?

           Linus
