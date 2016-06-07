From: =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Subject: Re: [PATCH 1/2] git-prompt.sh: Don't error on null
 ${ZSH,BASH}_VERSION, $short_sha
Date: Tue, 7 Jun 2016 08:22:04 +0300
Message-ID: <CABr9L5Bntn1+FGks6DfeJ6QMRr4CSHWwn8ggNGWroXe1kWczXQ@mail.gmail.com>
References: <1465230573-18357-1-git-send-email-ville.skytta@iki.fi> <xmqq37oqw05b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 07:22:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA9TC-0001ty-Ga
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 07:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbcFGFW0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 01:22:26 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38595 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbcFGFWZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 01:22:25 -0400
Received: by mail-wm0-f53.google.com with SMTP id m124so97589596wme.1
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 22:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=gz5q90TPfWOMSOfzdh5deYStkZRGMNYH4dU11+BWq6U=;
        b=0AaP/yW3aFKk15ze3isINIDiQjBjswzBNHHJscJnLiB/qB2/3Ong+WieqvSZfbybGN
         ad9mpn2yaB6dQCjCd9b1NPRBq/j0ByxgvpoNJVA2mL8LZSp2zfHLxT1LuUeQQ+kamXLp
         5T4dWxPiNfxYmFYDcbUid3JuSiTOy/hyLBo1a/IP9pkKUupsEV5FGI6SDD4sEm0dgnTe
         /dDfO9ZH05bBhp1F1ivnuCb8Z0lVHCGSkYkjU6OAlgOOcSRlo6bXnrsymVt32wfLexTy
         PAIRFyM8PPfYURevWThWWWJH9ZG6GFAISoQEwTxsF4QjBEVnMm2Z5OKQlGNuJ2bIT6g1
         ZqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=gz5q90TPfWOMSOfzdh5deYStkZRGMNYH4dU11+BWq6U=;
        b=lyN6Bdk9fwpEPdelAKJoUrW/850TZs6y3HD7+ihyRg9JRfrWk814E8WCaSQUZQyXcy
         pwWdyWOtgqA07f5t2hRVHQ/Ww7MluBMhhHYi+fPXXlQnTOd6wkbXzwmMonjtgN19s0U1
         3IptWsQHv9s67OClg2i/W+tBIUtL6dZTs1DFJqW+LPY0Qy/Vpglfp5KU87vgpgum0Mrk
         fKzPHV7Iz0lnYzuecIUGHnJvI1x7fuZJa4PUCNtERjhshctt+Zf8wWphx7J9FYQk2ScE
         HuXybhKZdwEyrvlAgL/g04cTfWdCKlf3XcI+xkgtH8UzDRzirP2lpcajVh9H+IQiC90M
         j6XQ==
X-Gm-Message-State: ALyK8tItBg4+iNSKs75V73Hh6cr0Mb8D0cqTGUT/JpUv/8kGx7c3vNKb2RHBRe6WK16E4m1/Oq+ky++nIlTHiw==
X-Received: by 10.28.85.69 with SMTP id j66mr581423wmb.91.1465276943568; Mon,
 06 Jun 2016 22:22:23 -0700 (PDT)
Received: by 10.194.9.195 with HTTP; Mon, 6 Jun 2016 22:22:04 -0700 (PDT)
In-Reply-To: <xmqq37oqw05b.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: FAe9D8sjDRW00n0lurSivh_oPjc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296595>

On Mon, Jun 6, 2016 at 11:08 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:
>
>> When the shell is in "nounset" or "set -u" mode, referencing unset o=
r
>> null variables results in an error. Protect $ZSH_VERSION and
>> $BASH_VERSION against that, and initialize $short_sha before use.
>>
>> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
>> ---
>
> Thanks for following up.  I do not run my interactive shells with
> "set -u", so I never noticed these, but apparently you do (or you
> know who does)

I don't personally, but some do. The issue pops up every now and then
with bash-completion, e.g.
https://github.com/scop/bash-completion/issues/44

> does this patch cover everything that is not "-u" safe?

I don't know. These were the low hanging fruits I've come across. Null
$ZSH_VERSION in git-prompt.sh was the thing I ran into immediately
when enabling "nounset" mode to start looking into the above
bash-completion issue. Quick testing with zsh revealed the same issue
with null $BASH_VERSION, and you found the $short_sha one.
