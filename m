From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/6] Towards a generalized sequencer
Date: Fri, 12 Aug 2011 08:47:20 +0530
Message-ID: <CALkWK0=z20TMJAMnkkjrYrDVmpf9gvXxhBgeOTDY7yNNU39Buw@mail.gmail.com>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <20110811190312.GD2277@elie.gateway.2wire.net> <CALkWK0nXAU+jFwyzmYC6XuPGy8Cdmbpis0Nvb-M+tQSNk_PXiQ@mail.gmail.com>
 <20110812023323.GA672@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 05:17:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QriFo-0006ke-Ib
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 05:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511Ab1HLDRn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Aug 2011 23:17:43 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:53656 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463Ab1HLDRm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2011 23:17:42 -0400
Received: by wwe5 with SMTP id 5so4633480wwe.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 20:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rJoIkS9xoDNvNFAGQIe//lvH4K0iZQT3m5Pse6nkV8c=;
        b=JrztlKE//JYuqTsoHjLXnSerrz+Du+Zm6TFHs5Z74+emLM5FrWy8wn2fxdO7kJdGdN
         mQZLKSEDT4CImSg5OYIUXcZo7Fql7L7CNYpO6A54O0ukO+0XfFETD7WX+hWKwGxdRyUh
         tF4tSgDmM+DtEooEyU6U9OnKsvWP+74WkzZw4=
Received: by 10.216.162.5 with SMTP id x5mr283118wek.78.1313119061122; Thu, 11
 Aug 2011 20:17:41 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Thu, 11 Aug 2011 20:17:20 -0700 (PDT)
In-Reply-To: <20110812023323.GA672@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179162>

Hi,

[+CC: Johannes Schindelin]

Jonathan Nieder writes:
> Isn't it still the same built-in cherry-pick code, originally by Dsch=
o
> and improved over time by others? =C2=A0The filename is irrelevant.

True, but we can't have "This implements the builtins revert and
cherry-pick." in sequencer.c, no?

> If you want to add your and Christian's names to reflect
> multiple-cherry-pick and the restructuring, I guess that would be ok.
> Better yet, if you want to remove Dscho's name to encourage people to
> look at the commit log and get a richer story, just ask Dscho.

I thought about this a bit.  I'm completely against the former option
-- I merely meant it as a "I'm confused; help!" rather than a
suggestion; adding contributors' names to the list is a bad idea.  I
looked at some copyright notices in other files and re-evaluated: it's
a cute historical note to have. Unless Johannes wants to remove it
now, I'd like to put the following in sequencer.c:

/*
 * Used to implement the builtins revert and cherry-pick.
 *
 * Copyright (c) 2007 Johannes E. Schindelin
 *
 * Based on git-revert.sh, which is
 *
 * Copyright (c) 2005 Linus Torvalds
 * Copyright (c) 2005 Junio C Hamano
 */

Sorry about the confusion. Feel free to suggest a better "title line".

Thanks.

-- Ram
