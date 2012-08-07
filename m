From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/2] prune.c: only print informational message in
 show_only or verbose mode
Date: Tue, 7 Aug 2012 15:55:02 -0700
Message-ID: <CA+sFfMe+NsPxz555iZ6X0f8Kca8Vu2+2gFWm628O0XYFaHOzXQ@mail.gmail.com>
References: <CA+sFfMdXc+usFRnCNVoke91_X2qWZARTvPHO=B7Ukxr-j7JB2g@mail.gmail.com>
	<1344315709-15897-1-git-send-email-drafnel@gmail.com>
	<1344315709-15897-2-git-send-email-drafnel@gmail.com>
	<7vtxwfw9rp.fsf@alter.siamese.dyndns.org>
	<7vpq73w9i8.fsf@alter.siamese.dyndns.org>
	<CA+sFfMdVhTwAFLUgrO-mLBh8apG-5X1OJKCN9xgq3-N+1RBrvg@mail.gmail.com>
	<20120807060311.GB13222@sigill.intra.peff.net>
	<7vlihqv0ks.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 00:55:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SysgF-0005gG-Tz
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 00:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031244Ab2HGWzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 18:55:06 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:61458 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031162Ab2HGWzE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 18:55:04 -0400
Received: by vbbff1 with SMTP id ff1so162423vbb.19
        for <git@vger.kernel.org>; Tue, 07 Aug 2012 15:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0Jv4+EICEUDKcmM4ANssPAF0DK7hnOWFm1cCilNe1Uw=;
        b=PPbkgPF3HYS1puRo6N17pDw+4MXejedGHRWF/pwqsSoGMmnEvfotOLIyuN6aQuucCU
         ejA5jhD9suwmRqJINdbsa0tFbQFLxoPwmpZIUDwx1+AHBZ+SJibpLByTopmjvZ596hlt
         xN+M9H0jh2NGBhTKR4VpXd9OgSiXcOikA+M3pwXubAmF8qF6D79eNBKmFUVpOEaB2ln+
         Jec9HFuBxxrwM0GwQvlhw8N0T6rzm2B1GXuPwILDQDQA+7+lV/Pqh7NaFYMgIQDO1lAy
         VyXrJTvtdGz+W+WfV23i7iyXL0y2Dy5cFwfFouLnKcIYK6YAW0I7qUZKN0Gs578Yxpsu
         LJTA==
Received: by 10.58.94.44 with SMTP id cz12mr14042805veb.34.1344380103032; Tue,
 07 Aug 2012 15:55:03 -0700 (PDT)
Received: by 10.59.5.196 with HTTP; Tue, 7 Aug 2012 15:55:02 -0700 (PDT)
In-Reply-To: <7vlihqv0ks.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203055>

On Tue, Aug 7, 2012 at 2:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I still think your 2/2 is worth doing independently, though. It is silly
>> that git-prune will not mention pruned objects without "-v", but will
>> mention temporary files. They should be in the same category.
>
> Ok, so I'll queue it as a separate topic with a different
> justification.

Looks fine to me.  Thanks.

-Brandon
