From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git log fails to show all changes for a file
Date: Wed, 15 Jul 2015 12:17:28 -0700
Message-ID: <CA+55aFyMq1VjFcpa4kAy9XBuntHWr-aCeKr9JdxuK5kt=Z1pRw@mail.gmail.com>
References: <20150714073035.GA22707@aepfle.de>
	<20150714074508.GE1451@serenity.lan>
	<20150714075955.GA24577@aepfle.de>
	<CA+55aFzPvwAghGtA-WH8i1PcNe55XORokaXF9hNu7OUXBx++6Q@mail.gmail.com>
	<xmqq8uahxu3e.fsf@gitster.dls.corp.google.com>
	<CA+55aFy8urE+0w7mfgywcAnyoUu+6LMz-GGaOrUQYJ59gT9FfA@mail.gmail.com>
	<xmqqy4ihwbdr.fsf@gitster.dls.corp.google.com>
	<CA+55aFw=PJtc7jXLUx+tJhAeVO3vpQjsd+oYW+OwCU20_Qft-w@mail.gmail.com>
	<xmqqtwt5wai9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Olaf Hering <olaf@aepfle.de>, John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 21:17:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFSBS-0003zK-BH
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 21:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbbGOTR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 15:17:29 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35214 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbbGOTR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 15:17:29 -0400
Received: by igcqs7 with SMTP id qs7so114873456igc.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=O+cV7mwJABEQRE4B9jKOhiaSidPyOuo3xuPBdJlHr1E=;
        b=m2Zq79p1Wt6W12ZDQDqRQqutE53xe6Dj8tOtQFssjSrxSnjvq4Spu8YfPBoQ/2I8L1
         YICd6+8viYSC3BSrYRYLh7T45DELiUNDDO5vkf/jwP+EmjjLQQ5rgeuB9dvElY3qJLUy
         DnKz2ltvx1vVYGoj4b9YZqJRFSTSH2n49FAlpaAkf3GxMq8uyK2PD344i6vt++thN/We
         KTNPzIgMfgZnfbOI2FzVxustwokd6kY+lcJ+9/i5REb873r8GPNObdI1CkII0y5NyQYl
         fKcxkrtP9C/FHoewu4xX/7dV6cpzBAGXcKvpqe0g1acFT5OrQn3KNxlw78SLtx/63sX8
         9zOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=O+cV7mwJABEQRE4B9jKOhiaSidPyOuo3xuPBdJlHr1E=;
        b=IFNphITkdcqkdWBYp6Jpij2jtWGXjanw2Uje4wTEn0TpkXDdHCgip6xT9cIfBQSQqy
         cbeTojTYNn/hgEFDFl+wsazeM+Mz/QVk9cFaxcVDDWXdF69GR2jARuStRqWUwFyXj1PP
         UkYLwC5MXjkRmzNDO5FR+Kwq8wKDhQ56y/dNk=
X-Received: by 10.107.137.154 with SMTP id t26mr6803574ioi.13.1436987848468;
 Wed, 15 Jul 2015 12:17:28 -0700 (PDT)
Received: by 10.36.78.7 with HTTP; Wed, 15 Jul 2015 12:17:28 -0700 (PDT)
In-Reply-To: <xmqqtwt5wai9.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: t0OYiQXVhJw3XW6SiwaZoecEjJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273994>

On Wed, Jul 15, 2015 at 11:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> So this is a suggested change to "-p -m" behavior?
>
> Not really.  This is a suggested behaviour for "git log -p"

Oh, in that case I say NAK NAK NAK.

That would be totally horrible, and completely unacceptable.

I do "git log -p" all the time, and merge-diffs with --first-parent
are regularly hundreds of thousands of lines for the kernel.

So no. That is COMPLETELY unacceptable. Not even worth discussing.

                   Linus
