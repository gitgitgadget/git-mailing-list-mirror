From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Correct singular form in diff summary line for human interaction
Date: Wed, 1 Feb 2012 09:37:57 +0700
Message-ID: <CACsJy8DMkdsJ2ZmyyLVSUHyWj=qw6pkBB9CXQARfmZeQ_=YaNQ@mail.gmail.com>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <20120131152028.GA10717@burratino> <7vvcnr92y0.fsf@alter.siamese.dyndns.org>
 <CACsJy8Dd4_Pnvzxww38EfZt8NgRow+qxCReohc45XoNpfJCbYg@mail.gmail.com> <20120201015606.GA24482@debian50-32.invisible-island.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>, dickey@invisible-island.net
To: dickey@his.com
X-From: git-owner@vger.kernel.org Wed Feb 01 03:38:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsQ5h-0001E7-VA
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 03:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380Ab2BACi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 21:38:29 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64393 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab2BACi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 21:38:28 -0500
Received: by bkcjm19 with SMTP id jm19so592844bkc.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 18:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6FJbfzhdDMY2Z0X5Wzrn0GMdssip6PvM0i4HU0geNfI=;
        b=A1R5nkcNFbaJx3LlPnlBPer39tHoA3sKNoIqelWJ9qc6KwuneINKP4uSe8uvybIpGm
         vaSFaU1jkY5e7bRylonXSSm0ybyYDi6FbmZ4Pr38hYp0v3tkLkFz6KgNWBMJNu22Ds2t
         Ux74H86vo8LpNDSYjFc03pBZJaGgcgp7Yp/BU=
Received: by 10.204.155.145 with SMTP id s17mr1207488bkw.19.1328063907249;
 Tue, 31 Jan 2012 18:38:27 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Tue, 31 Jan 2012 18:37:57 -0800 (PST)
In-Reply-To: <20120201015606.GA24482@debian50-32.invisible-island.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189494>

On Wed, Feb 1, 2012 at 8:56 AM, Thomas Dickey <dickey@his.com> wrote:
>> > If we were to touch this, I would prefer to do so unconditionally without
>> > "hrm, can we reliably guess this is meant for humans?" and release it
>> > unceremoniously, perhaps as part of the next release that will have a much
>> > bigger user-visible UI correction to 'merge'.
>>
>> Unconditionally change is fine to me. There's another implication
>> that's not mentioned in the commit message, this change also allows
>> non-English translations. Any objections on i18n or we just keep this
>> line English only? Personally if scripts do not matter any more, I see
>> no reasons this line cannot be translated.
>
> I seem to recall that gettext does support plurals...
>
> However, going that route means that even innocuous things like the
> parentheses "(+)" can be mangled by translators (guaranteed to break
> scripts ;-)

We disregard scripts at this point already, I think. "+" and "-"
should not be translated. We could either leave them out of
translatable text, or put a note to translators saying not to
translate them.
-- 
Duy
