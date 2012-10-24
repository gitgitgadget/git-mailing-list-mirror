From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 5/6] tests: add remote-hg tests
Date: Wed, 24 Oct 2012 17:47:40 +0200
Message-ID: <CAMP44s0OLE8wqoGOJ+cw1uuYjdema6UuXJU5-wAuWdJuxi2Mtg@mail.gmail.com>
References: <1350841744-21564-1-git-send-email-felipe.contreras@gmail.com>
	<1350841744-21564-6-git-send-email-felipe.contreras@gmail.com>
	<CAGdFq_hhjvysViU+rceOcX7L48BkxUbDzKiyT7LakFqz1ikT8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 17:47:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR3BR-0008V6-LF
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 17:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011Ab2JXPrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 11:47:41 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:64875 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132Ab2JXPrk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 11:47:40 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so573652oag.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 08:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=snYj7J9vRSC5Vl6TOgxT/9m6q3Zlrr20wo+n3/qUa/M=;
        b=SXcUvosjfnoC3yA97tEZsGvqMNcIbZl1w8EijkEOpZHY67D0k6b3BM65vKYM/QHxAp
         Iv8/W25DBAth98iDlTyPO9PIidur7KniEapTNktlvIRlUZ7cqBiChHjFV9iurhdrwcPp
         YN0V83P1dIXx53ynBYkfxEtu+psC5nOdymCX8xNr5aFs8D4aS/0HkDodyCi+fMyd0Jcz
         HHl/W9dXDdxExqg2w2qlot4sgFlAJ6mO23l86YP7F8HNn7M7dhnwK4FAhjZDHMunFYse
         38hipNN+O2L8Zq5OqwwN/uqX+bv66wcQ9EkN+aRqCnMtAkYRz4T7lWTwqHNMRPR7UWln
         VeUQ==
Received: by 10.182.116.6 with SMTP id js6mr12985777obb.82.1351093660334; Wed,
 24 Oct 2012 08:47:40 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 24 Oct 2012 08:47:40 -0700 (PDT)
In-Reply-To: <CAGdFq_hhjvysViU+rceOcX7L48BkxUbDzKiyT7LakFqz1ikT8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208309>

On Sun, Oct 21, 2012 at 11:02 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Sun, Oct 21, 2012 at 10:49 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> From the original remote-hg.
>>
>> You need git-remote-hg already in your path to run them.
>>
>> I'm not proposing to include this patch like this, but should make it easier to
>> test.
>
> You should also have a look at the tests that were marked as "expected
> to fail", since they point out a bug with fast-export.

What tests? All the tests I see in msysgit are expected to succeed:
https://github.com/msysgit/git/blob/devel/t/t5801-remote-hg.sh

> I'd sent a
> series to fix that, but didn't follow-up to get it merged:
>
> http://thread.gmane.org/gmane.comp.version-control.git/184874

I have read that thread multiple times now, and I still don't see the
problem. Everything works fine in my remote-hg. I still don't
understand what changes are required in upstream that your remote-hg
needs, and the fact that there is no up-to-date remote-hg branch
doesn't help.

Cheers.

-- 
Felipe Contreras
