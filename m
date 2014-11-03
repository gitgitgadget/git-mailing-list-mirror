From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [L10N] Startup of Git 2.2.0 l10n round 1
Date: Mon, 3 Nov 2014 09:46:25 +0800
Message-ID: <CANYiYbERpzF2Fo2nnEmMmELh3ES10q87Tt13F4r5VZsb9UuJhw@mail.gmail.com>
References: <CANYiYbH-Gz8rSo1OX8ApA1ysgpi=YaE+yq9XDOa-DUXeppxQOw@mail.gmail.com>
	<CAP6f5M=OqzH8R6QPxPr3yn1xCFJPA8N6q33BZGg4t8T96KaEgg@mail.gmail.com>
	<20141102.200647.1807459583469654728.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>
To: Alexander Shopov <ash@kambanaria.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 02:47:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xl6js-0002x8-Tq
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 02:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbaKCBq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2014 20:46:27 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:50940 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbaKCBq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2014 20:46:27 -0500
Received: by mail-wi0-f170.google.com with SMTP id q5so4963218wiv.1
        for <git@vger.kernel.org>; Sun, 02 Nov 2014 17:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UyJQ05zUdpsh6mby8+J2270Ogwh+BXSyMbIjFhb+QhM=;
        b=b0m5ET2oBrVw7Sd8TS/CgSHTIqsyTi7WHAzmzlFb1TQbfdCSRK+QdFb5M47N9zLVhH
         OS7anekRzrbmXwTjwGRnhgI3PEuRCxwLqfh4gSkhW31DLHWlx0uJ3xSq7yQXdflPrz/R
         0tGZRxtSNJ+Db+heCp1WxqCWeMHMfDGduWErUQ/LOarAZubfjtPynwZhsl+i3h9sw0u9
         sqhOBqgyeX4RUUuQHD9tXnYVOT+kfNbXJ2WlpYhV03WyA1sPWOz/gQROoJEA67jGHjjt
         lXNr82XOknhc3LJ9RnxMkGkiT4nksH+cLeYN1E9xBmC1AquRqiH2xUwH26yiPK309Se+
         suHQ==
X-Received: by 10.180.208.100 with SMTP id md4mr12997941wic.53.1414979186003;
 Sun, 02 Nov 2014 17:46:26 -0800 (PST)
Received: by 10.194.169.103 with HTTP; Sun, 2 Nov 2014 17:46:25 -0800 (PST)
In-Reply-To: <20141102.200647.1807459583469654728.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2014-11-03 3:06 GMT+08:00 Christian Couder <chriscool@tuxfamily.org>:
> From: Alexander Shopov <ash@kambanaria.org>
>
>> Can you please disambiguate message:
>> msgid "more than one %s"
>>
>> It means that something somewhere was repeated but does not point what
>> and where. Perhaps users care about that.
>
> If you configure something like:
>
> [trailer "stuff"]
>         key = Stuff
>         key = Other
>
> You will get:
>
> $ echo | LANG=C git interpret-trailers
> warning: more than one trailer.stuff.key
>
> Which means that more than value was configured for the
> "trailer.stuff.key" configuration option. And it makes no sense
> because only one should be the canonical one.
>
>> It is now used 3 times (trailer.c:552 trailer.c:557
>> builtin/remote.c:288) but points to different things that were
>> repeated. It used to mean only that there is a "remote' section
>> repeated.
>
> In builtin/remote.c the warning is also when more than one value is
> given for a configuration option.
>
> Feel free to suggest some more explicit warning in both cases if you
> want. (Maybe adding " is configured" at the end would be enough.) A
> patch would be even better.
>

Yes, Alexander could send a patch for this. It's an I18N thing, not L10n,
so send a patch to the list if you like. @alshopov

> Thanks,
> Christian.

-- 
Jiang Xin
