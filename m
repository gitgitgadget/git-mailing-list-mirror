From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Fwd: [PATCH 4/5] Replace {pre,suf}fixcmp() with {starts,ends}_with()
Date: Thu, 5 Dec 2013 08:19:11 +0100
Message-ID: <CAP8UFD1+2-JuU0EPcfWUHpcfqrp9MODZBd4XEwVv-d6C8Nk=nA@mail.gmail.com>
References: <20131201074818.3042.57357.chriscool@tuxfamily.org>
	<20131201074919.3042.92026.chriscool@tuxfamily.org>
	<CAP8UFD0jg_Vr7Zf+DiMX9RG6vmmQvmk2NvmL7j=MC-x3fLOOBA@mail.gmail.com>
	<20131203124645.GB26667@sigill.intra.peff.net>
	<CAP8UFD0By77QVH1amsh85dX6h1S3iFZcmPzs3JjPZmiD_AmOPQ@mail.gmail.com>
	<xmqqk3fkjq5c.fsf@gitster.dls.corp.google.com>
	<xmqqfvq8jmv5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 08:19:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoTDQ-0001Gu-RO
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 08:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958Ab3LEHTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 02:19:13 -0500
Received: from mail-vc0-f170.google.com ([209.85.220.170]:38813 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab3LEHTM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 02:19:12 -0500
Received: by mail-vc0-f170.google.com with SMTP id ht10so12889736vcb.1
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 23:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=d02fvuqz5azWmsofGeOUkccOwkp2NjvgJANjRMwyyqQ=;
        b=ulyNA4KPa0JM23WOlcW9ywuNLaa346FeNyNp5UukuDuwXfRrLS0qDoExVSbcovpJ7Z
         kpzYLJPQ+p6/UTcNGLRpmUvtbRb8Uekv+G11bgwzYSk1Vh+h2FmDFeXx7cZNB3MSZqqC
         lkYUvYCbVXqLq+30tzHQu/z6wKeWfvEjrmhPgWPzNio1S1gwv9n48LD0H94IoJeq+Rdf
         //58ZdJ9zBRzNoU/3z2/HdC6nZdpCUYIUIqMjdL9x60Vzpe337/sED8LY8uJ5Lo3MTkF
         FzN4ePXLzNnbsMQeWXpoj6s96ram6HCz6az1hQRt8HEommAYB+YjLrASduwDkrC4+/Zl
         5fMw==
X-Received: by 10.58.118.36 with SMTP id kj4mr10085614veb.2.1386227951688;
 Wed, 04 Dec 2013 23:19:11 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Wed, 4 Dec 2013 23:19:11 -0800 (PST)
In-Reply-To: <xmqqfvq8jmv5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238846>

On Wed, Dec 4, 2013 at 11:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> Ok, the commit is in the use_starts_ends_with branch on this github repo:
>>>
>>> https://github.com/chriscool/git.git
>>
>> I looked at the patches, and they looked alright.  The endgame needs
>> to be on a separate topic to be held until a distant future, though.
>>
>> Will queue.  Thanks.

Great!

> It turns out that, naturally, there are many new uses of prefixcmp
> in the topics in flight.  I can manage, but adjusting all of them
> would not look too pretty X-<.

Tell me if I can do something.
I can prepare patches for the topics in flight in 'next' for example.

Thanks,
Christian.
