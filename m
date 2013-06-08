From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Sat, 8 Jun 2013 21:00:27 +0530
Message-ID: <CALkWK0km0C6q7-LoZBiAtzVh_Uv-bbEZuecv5uCsAk6E=uXxfg@mail.gmail.com>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 17:31:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlL6s-0002d6-MP
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 17:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab3FHPbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 11:31:09 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:49112 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab3FHPbH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 11:31:07 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so6528986iea.4
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P6J+uqFu/zVUKg2ZRdnm32/GUT1BfX1vTyJjue53gJ0=;
        b=WzBr61mT41hDotsEWw8HNHGSWD+oEyzeSlPkW0qyMqbu07jzIv+LlEO7jCjSaRHSB1
         hX7nVM0ub7aDkrO4gVCwUPqvA46yyR/z5dTemHTaTy2bNHqtoQIcuSPf36auEPRt0b5c
         uMpC0N4zF5MErfxzXJX1pX0/rpGeZzSiW0rkJ6uEK6WvO4/eJt9ccVIw4yBVTA5ysnKL
         1eHizT4AUS+pxBHp65dfbG5ZyARSe/O3YAafRnM3bmExG/0U1uk5FakB8csDOaaKMF4m
         m3KzLbWOfwMSniJ3gRv+Wp1DedBv8RU6PaP3l65ovELijehW5LajVVJPGTR5z94XEgZG
         1qmQ==
X-Received: by 10.50.25.194 with SMTP id e2mr1014647igg.111.1370705467467;
 Sat, 08 Jun 2013 08:31:07 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 8 Jun 2013 08:30:27 -0700 (PDT)
In-Reply-To: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226834>

Junio C Hamano wrote:
> * mm/color-auto-default (2013-05-15) 2 commits
>  - make color.ui default to 'auto'
>  - config: refactor management of color.ui's default value
>
>  Flip the default for color.ui to 'auto', which is what many
>  tutorials recommend new users to do.  The updated code claims the
>  switch happened at Git 2.0 in the past tense, but we might want to
>  expedite it, as this change is not all that important to deserve a
>  major version bump.
>
>  I'd vote for merging this without waiting for 2.0.  Comments?

Yes, please merge.  The commit message looks good as well: it doesn't
say anything about waiting for 2.0.

>  Waiting for a reroll.

The one in pu looks fine to me.  What am I missing?
