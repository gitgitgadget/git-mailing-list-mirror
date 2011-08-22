From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Malformed branch name in fast-export when specifying
 non-HEAD/branch revision
Date: Mon, 22 Aug 2011 11:05:08 -0700
Message-ID: <CAGdFq_hU3EnZnBh_eb7uax_Cb=0eA1K3GxMys+S60SEm94UE1w@mail.gmail.com>
References: <CAORuUR1viqG27+dYOFS_5SLxFOE2wHJqAQ3i3RByg_fbWACh-Q@mail.gmail.com>
 <CAORuUR154Dhg5vDojga-01bDxxf+=R2X-oJK-0417CgmqxCwvA@mail.gmail.com>
 <CABPp-BFRZMZjhWuUUeD7Oa1HbWQMnZot7dRm3zKOpCoj_QwZeg@mail.gmail.com>
 <7vliurd62x.fsf@alter.siamese.dyndns.org> <20110817231922.GA28966@sigill.intra.peff.net>
 <CAGdFq_iiTt8F+kPXwZZT3fAKwZLCpPr7BOYtistxvv6s52Q5nQ@mail.gmail.com>
 <20110822161932.GA1945@sigill.intra.peff.net> <CAGdFq_gx+NutDCU7egr_fYUvVG=g1t76LiV1SV-W=0KWBTjHyQ@mail.gmail.com>
 <20110822175705.GB1945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Owen Stephens <git@owenstephens.co.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 22 20:05:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvYsl-0005fK-2n
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 20:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab1HVSFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 14:05:51 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61208 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435Ab1HVSFu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 14:05:50 -0400
Received: by vws1 with SMTP id 1so4157458vws.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=N37UHvf3igLCnIFsYeRa+4aL8lQMH2+XWLSwhZ3Nzxs=;
        b=QzWdhwuzGprFfZLEISTRg+BvYgR1agIDS1DsS+pQkxhyCA6mKatMmZmCMzw+iGa2D8
         KRu/MW3ujE9VnDltM1q/IBM2d4nLeaKd99lEFfxHqtl2Qa5sM81TBgxkta6BHrdhyPhF
         buOKWnkJA0q6MElzNJRfhb7h3B623ILqrb/m8=
Received: by 10.52.187.4 with SMTP id fo4mr2661706vdc.209.1314036349194; Mon,
 22 Aug 2011 11:05:49 -0700 (PDT)
Received: by 10.52.161.201 with HTTP; Mon, 22 Aug 2011 11:05:08 -0700 (PDT)
In-Reply-To: <20110822175705.GB1945@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179875>

Heya,

On Mon, Aug 22, 2011 at 10:57, Jeff King <peff@peff.net> wrote:
> I just read through the remote-helper threads from early June, and the
> only mention of triggering that is when you actually have a rename
> (i.e., your "refs/heads/foo" becomes remote's "refs/heads/bar", but we
> mention "refs/heads/foo" in the export stream). I was thinking there was
> another case, but I couldn't find mention of it.

The patches Dscho and I sent are in response to the RFC patches (that
are currently "stalled" in whats-cooking) I added on top of the series
that rerolled yours.

> Yeah, the behavior of your patch looks fine to me. I thought the point
> in contention was that having export understand refspecs would fix a lot
> of _other_ cases, too.

Right. Sadly it doesn't look like I'll have time to try and fix 'git
bundle' anytime soon, so this'll remain broken.

-- 
Cheers,

Sverre Rabbelier
