From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v13 4/8] bisect: introduce support for --no-checkout option.
Date: Wed, 3 Aug 2011 08:19:09 +1000
Message-ID: <CAH3Anrq5Di8gg0GoTVY6pGWuENH55vA5i383GSawjxsu3+mszw@mail.gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
	<1312284545-2426-5-git-send-email-jon.seymour@gmail.com>
	<7vr553elsd.fsf@alter.siamese.dyndns.org>
	<CAH3Anrrf5aZMEH8KmKtvdaRf=D9fb6OVRJN+VjGM8Cd2wV6rnA@mail.gmail.com>
	<7vsjpjcvv2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 00:19:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoNIy-0005Cn-D4
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 00:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594Ab1HBWTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 18:19:12 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49440 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755562Ab1HBWTK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 18:19:10 -0400
Received: by vws1 with SMTP id 1so72696vws.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 15:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tlSLLfmJ4Hch/305oFrcDd9em1Xz0fXqQlXPubvFQHE=;
        b=pKInAvjRqf/aIc4fp9u9JHEf2wY9+geIk5JRqmqq5Jg0QTEriSx6kOgi17ilc8P557
         K84Ym909WnCHFW13PoxI/cLLubD/J+69r+507pms11tG3tMHNFwi2465EvbCN5jAVBLS
         EYE4J+VOEm8RLVB3Vx0dubbj0bLnqjKUZUCy8=
Received: by 10.52.22.19 with SMTP id z19mr369803vde.499.1312323549317; Tue,
 02 Aug 2011 15:19:09 -0700 (PDT)
Received: by 10.52.183.39 with HTTP; Tue, 2 Aug 2011 15:19:09 -0700 (PDT)
In-Reply-To: <7vsjpjcvv2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178527>

On Wed, Aug 3, 2011 at 8:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>>> I think this is a regression from naming perspective from the previous
>>> round. You would be either the normal (checkout) mode or no-checkout mode,
>>> and honestly, --no-checkout would be understood by anybody while update-ref
>>> would be understood only by Gitz.
>>>
>>
>> Is it relevant here that --bisect-mode here is on bisect--helper which
>> is really part of the plumbing and unlikely to be used by anything
>> other than git's own porcelain?
>
> Ah, Ok, that is what I missed. I also was scratching my head after seeing
> that there was not much change in the proposed log messages from the
> earlier round.
>
>

I've issued a v14 that removes it - I was treating it as a boolean in
the C code anyway.

If anything v14 git-bisect.sh is slightly simpler than v13

jon,
