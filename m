From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH v2 00/16] First class shallow clone
Date: Wed, 24 Jul 2013 10:30:12 +0200
Message-ID: <CAA01CsrHaCGrt37r4bn1OBY-=skJXZBHOaPH=Gsz-8BCmiW6jQ@mail.gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
	<1374314290-5976-1-git-send-email-pclouds@gmail.com>
	<79A9AB6FF00042D1B3E0D26B9855CCAB@PhilipOakley>
	<CACsJy8AJjXMATEPrAgSYOgpZcR_khC=9S28H8LuCvuTuJk0x8w@mail.gmail.com>
	<8BDFF5EEBDC8422681F1AB2C0A153CC6@PhilipOakley>
	<CACsJy8AzFogspTih4mJoog6MGEWgmuae2KmFysQ0-siCvfH2yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 10:30:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1uSm-0005cE-R8
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 10:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857Ab3GXIaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 04:30:17 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:58045 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab3GXIaO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 04:30:14 -0400
Received: by mail-ee0-f50.google.com with SMTP id d49so70183eek.37
        for <git@vger.kernel.org>; Wed, 24 Jul 2013 01:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UMjZk+AAi/pHvybDCDB0Hm8zccwzH4QIG71V59y7XSw=;
        b=fDpyY22jLU5Vso8kkIfPypX2m/MG9Xthe2Gt7V0xQiKQPyXwcAQqM4YzMAZGfaoOQC
         j8q0N12anmHGLf5EX3Eo7ddb2AyAszNCtYqyqU9nMzA79t4l4svYAk9SxaIlD2jB8VzL
         4py5XF/DgnttDFopxlUOwTuecYILDMwIWjtkYOVXel1eoBT6LoTcbMudZ2WH8+eFaQtF
         qqpIlqQNsZfSmeA80ZKhtnqfODVLUtyGXqJHM7eugPG+nuvKNimbb+/guos4IyIlOMuz
         wdKlz6BmZLRB3BGdjhghlpBlp4kH00ncJDm0UNegBncui23R2H6kuFGcp04/3cUWUAKK
         j2rw==
X-Received: by 10.15.23.194 with SMTP id h42mr35846463eeu.123.1374654613189;
 Wed, 24 Jul 2013 01:30:13 -0700 (PDT)
Received: by 10.223.98.193 with HTTP; Wed, 24 Jul 2013 01:30:12 -0700 (PDT)
In-Reply-To: <CACsJy8AzFogspTih4mJoog6MGEWgmuae2KmFysQ0-siCvfH2yA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231088>

(resending, as my phone mail client decided to send it in html, sorry
about that)

On Wed, Jul 24, 2013 at 3:57 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jul 24, 2013 at 5:33 AM, Philip Oakley <philipoakley@iee.org> wrote:
>> There have been comments on the git-user list about the
>> problem of accidental adding of large files which then make the repo's foot
>> print pretty large as one use case [Git is consuming very much RAM]. The
>> bigFileThreshold being one way of spotting such files as separate objects,
>> and 'trimming' them.
>
> I think rewriting history to remove those accidents is better than
> working around it (the same for accidentally committing password). We
> might be able to spot problems early, maybe warn user at commit time
> that they have added an exceptionally large blob, maybe before push
> time..

I can imagine a situation where large files were part of the project
at some point in history (they were required to build/use it) and
later were removed because build/project has changed.

It would be useful to have the history for log/blame/etc even if you
could not build/use old versions. A warning when checking
out/branching such incomplete tree would be needed.

-- 
Piotr Krukowiecki
