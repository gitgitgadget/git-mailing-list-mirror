From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [RFC 0/5] Date Mode: Add --time-zone; deprecate --date=local
Date: Thu, 21 Apr 2011 02:14:20 +0000
Message-ID: <BANLkTikbgfjq2J3K4_21zVQSTgnteZfMqg@mail.gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
 <20110420064318.GF28597@sigill.intra.peff.net> <4a235331-951f-481e-8603-896af4e67df9-mfwitten@gmail.com>
 <7v62q8z824.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 04:15:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCjQF-0001rF-DF
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 04:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761Ab1DUCOv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2011 22:14:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61531 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab1DUCOu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2011 22:14:50 -0400
Received: by iwn34 with SMTP id 34so1063490iwn.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 19:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=1n1KnrVb0EPJk7ktFQ0FNRpn+wRTZvL8vryIeCIvrCg=;
        b=auhgItVShRNow68Cc54xjTgOzqsWfvX7UKc8zj+/WZouI0dxrOVsyYMp/KA1+5BPR1
         7Gvg3vsNmayB0hIh3zESJOYoBqSGATpyPbdmLfWT8LLmNc/o+Pv1ZZMZDWPCtlwEjzz8
         8fdWTiOODoNrkcjSB/7bLpj6f41d/4MDGqtkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bOVnb68ZLiX+zQ7OBCjBl1k8pYKyWtLFgCy1Z0k/5vL4yQQ6y+B3ZZuMuCOiJvJi7N
         MBzH97pckwD0rmZ3XRICQeE9NgWkubGAWSf651dySoa+5FnTotei4I5VzPRgBhet0CWe
         z9Uo9who0c62SHDjOxUBuyZ1yQH+UWd0C6fvA=
Received: by 10.42.1.70 with SMTP id 6mr1406432icf.483.1303352090131; Wed, 20
 Apr 2011 19:14:50 -0700 (PDT)
Received: by 10.42.178.196 with HTTP; Wed, 20 Apr 2011 19:14:20 -0700 (PDT)
In-Reply-To: <7v62q8z824.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171888>

On Thu, Apr 21, 2011 at 01:50, Junio C Hamano <gitster@pobox.com> wrote=
:
> Michael Witten <mfwitten@gmail.com> writes:
>
>>> I think the intent of this series is good. See also this thread fro=
m
>>> quite a while back:
>>>
>>> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/11202=
6
>>
>> I took a cursory look, but I've spent so much time on this series al=
ready
>> that I don't really care what it says...
>
> This is not a very good way to motivate somebody who is already tired=
 at
> the end of the day to reivew the RFC series, I would have to say.

Then you can save us both time and just apply my series immediately :-P

You're taking it wholly out of context; the full sentence is indeed:
"I took a cursory look, but I've spent so much time on this series
already that I don't really care what it says; if there are particular
concerns that you think I might not have met, then let me know in this
discussion :-)"

Two points, though:

  * Mentioning another thread is not in any
    way a review of this current patch series.

  * I'm passed the phase of worrying about which
    cases I might have missed; that's why I
    have submitted my work to the list in order
    to give less-weary eyes a chance to think
    about it.
