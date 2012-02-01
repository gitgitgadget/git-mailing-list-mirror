From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Correct singular form in diff summary line for human interaction
Date: Wed, 1 Feb 2012 08:32:43 +0700
Message-ID: <CACsJy8Dd4_Pnvzxww38EfZt8NgRow+qxCReohc45XoNpfJCbYg@mail.gmail.com>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <20120131152028.GA10717@burratino> <7vvcnr92y0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>, dickey@invisible-island.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 02:33:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsP4x-000200-85
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 02:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420Ab2BABdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 20:33:16 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50768 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab2BABdP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 20:33:15 -0500
Received: by bkcjm19 with SMTP id jm19so555824bkc.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 17:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3ezRZSh7ixPbXDwIvOgyZTKA3PJOoxxPu6LmLvhbSe0=;
        b=vfeRY5qd0Q5ATpq2J9IjdycifcEqMLFad+Ok33761HF3Mlh1cPf9A126jOQ0ST7sUB
         W/nHCuRwS54jzvUQpl3gSbrg6f9uegyjgXw/F3O0ophKvZTPrKcihnaIwBppcOzRFugj
         ej0vsZ89E2+M/QCvvdxHIiAFPyc0suCWS2eRw=
Received: by 10.204.155.145 with SMTP id s17mr1133857bkw.19.1328059994284;
 Tue, 31 Jan 2012 17:33:14 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Tue, 31 Jan 2012 17:32:43 -0800 (PST)
In-Reply-To: <7vvcnr92y0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189491>

On Wed, Feb 1, 2012 at 12:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> If there is an environment variable to say "I don't want to see
>> variations on strings intended for humans", can it be spelled as
>> LC_ALL=C?
>
>  ...
>
> If we were to touch this, I would prefer to do so unconditionally without
> "hrm, can we reliably guess this is meant for humans?" and release it
> unceremoniously, perhaps as part of the next release that will have a much
> bigger user-visible UI correction to 'merge'.

Unconditionally change is fine to me. There's another implication
that's not mentioned in the commit message, this change also allows
non-English translations. Any objections on i18n or we just keep this
line English only? Personally if scripts do not matter any more, I see
no reasons this line cannot be translated.
-- 
Duy
