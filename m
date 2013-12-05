From: Christian Couder <christian.couder@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2013, #01; Wed, 4)
Date: Thu, 5 Dec 2013 08:24:25 +0100
Message-ID: <CAP8UFD2BVYR=CcRvi3rAqNqbeBeiz+tRpEG+FKp-cfh0JOcKKQ@mail.gmail.com>
References: <xmqqiov4hz07.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 08:24:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoTIU-0004RM-89
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 08:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab3LEHY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 02:24:26 -0500
Received: from mail-ve0-f171.google.com ([209.85.128.171]:64299 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab3LEHY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 02:24:26 -0500
Received: by mail-ve0-f171.google.com with SMTP id pa12so13319825veb.16
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 23:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x8Vg9EcUdYrji8vkgYRnWHoqhP80Oi40VSH6O0VGSlo=;
        b=DKvawAQ/59qAJvhbuMlLGHPtOIL0ihqtkiXaceiASs/9hFIyjHp93fEEiJZwBVjNq4
         quxqO3s+kODCjD4uzepLxoz2A/6RQIIimJ/y4rUffHmGkV4bFMV/R03vcObQuj8btARz
         emRk11aYpxkxl2ju6nYQumtdqqW164dI2Y9Ozu9qVEuA3NiDXbWGfM4WOxC0ITlgM6gH
         ntlHwIjD8gjN2acPGKodDOaVmltTwfJqqfnpVGQwgb7Aov10G8aOOWlnqqgLx8YB0Asi
         q2NqMz7Hi/wBNIahvTD+TvXXOTBZf5xGY9WTl4878oZ7eXRb/Uz9oesBu85pqc0BJFAc
         XRYQ==
X-Received: by 10.220.199.5 with SMTP id eq5mr62355187vcb.16.1386228265615;
 Wed, 04 Dec 2013 23:24:25 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Wed, 4 Dec 2013 23:24:25 -0800 (PST)
In-Reply-To: <xmqqiov4hz07.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238847>

On Thu, Dec 5, 2013 at 2:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> * cc/starts-n-ends-with (2013-12-04) 4 commits
>  - replace {pre,suf}fixcmp() with {starts,ends}_with()
>  - strbuf: introduce starts_with() and ends_with()
>  - builtin/remote: remove postfixcmp() and use suffixcmp() instead
>  - environment: normalize use of prefixcmp() by removing " != 0"
>  (this branch is used by cc/starts-n-ends-with-endgame.)
>
>  Remove a few duplicate implementations of prefix/suffix comparison
>  functions, and rename them to starts_with and ends_with.
>
>  This conflicts with a part of cc/remote-remove-redundant-postfixcmp
>  topic (I think it actually subsumes it).

Yeah, it subsumes it.

Thanks,
Christian.
