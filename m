From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 9/9] Add git-check-ignores
Date: Mon, 10 Sep 2012 19:25:07 +0700
Message-ID: <CACsJy8Dwpx-Qs0+du6rHvbwL_A4H_DqBMP4umhBiDK2Fc8icww@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-10-git-send-email-git@adamspiers.org> <CACsJy8A2-C9xSz2LXt9Ptjxhe++i2vcBSMY-cxJLWUiutajZUQ@mail.gmail.com>
 <20120910110928.GA12974@atlantic.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 14:25:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB33m-0005FJ-0d
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 14:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757670Ab2IJMZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 08:25:39 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43529 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757571Ab2IJMZi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 08:25:38 -0400
Received: by ieje11 with SMTP id e11so2928868iej.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 05:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=ERCWVJU0OHttQVSFhhOdaYftGYCQm21clTCwgTGYlMw=;
        b=pk6bhMoimHa97b6gy8b27U6Qvjz0GaCGJwMEVlSkVH6Wa5ZdLRMwCFcUlCaenKrw0j
         gTs3REMNIB5qzth86jhgzkDPSoz02zvItc6VfLhlkmrpEDxtbNT+ztuREviRZa9zASpp
         /y8fEPBGYkkI5wHQbQLxdOVkZYIyWf0sp3EJEbX/fXA97HxSmI2jDZp01wl/62maCR26
         3DnfPbK2uSwbUhrc3AP0KvrUeR7hX7LlYCnZgZiVgZM+9hfyl28Ewlm+w0Og+FOLaih2
         NOaSBWoz3aBKtbSJfMWkkGh0F0YgmfEFo8QwfWB5L0v/UGEiR88yLLbiNogMhI2FPDSu
         l8rA==
Received: by 10.50.13.200 with SMTP id j8mr10715721igc.48.1347279938223; Mon,
 10 Sep 2012 05:25:38 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Mon, 10 Sep 2012 05:25:07 -0700 (PDT)
In-Reply-To: <20120910110928.GA12974@atlantic.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205122>

On Mon, Sep 10, 2012 at 6:09 PM, Adam Spiers <git@adamspiers.org> wrote:
>> >                         fprintf(stderr, "%s\n", dir->ignored[i]->name);
>> > -               fprintf(stderr, _("Use -f if you really want to add them.\n"));
>> > +               fprintf(stderr, _("Use -f if you really want to add them, or git check-ignore to see\nwhy they're ignored.\n"));
>> >                 die(_("no files added"));
>> >         }
>>
>> String too long (> 80 chars).
>
> You mean the line of code is too long, or the argument to _(), or
> both?  I didn't like this either, but I saw that builtin/checkout.c
> already did something similar twice, and I wasn't sure how else to do
> it.  Suggestions gratefully received.

I don't rememeber :( I might mean the output because I missed "\n" in
the middle. At least you can split the string in to at "\n" to make it
resemble output.

>> You should support ignore rules from files and command line arguments
>> too, like ls-files. For quick testing.
>
> You mean --exclude, --exclude-from, and --exclude-per-directory?
> Sure, although I have limited time right now, so maybe these could be
> added in a later iteration?

Sure, no problem. It's not hard to add them anyway (I think).
-- 
Duy
