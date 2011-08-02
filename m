From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 0/5] bisect: Add support for a --no-checkout option.
Date: Wed, 3 Aug 2011 07:27:05 +1000
Message-ID: <CAH3Anrryu5k_3ykC=PzsPoik_0+HaG+5d9HdW2qsJTmS41j+oQ@mail.gmail.com>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
	<201107301548.09815.chriscool@tuxfamily.org>
	<CAH3Anrp8aT1UwfstJ99Ug4MD2CZKB9oE_oRLksbkGGE1xSELsg@mail.gmail.com>
	<201107301619.51438.chriscool@tuxfamily.org>
	<7v39hmkkth.fsf@alter.siamese.dyndns.org>
	<CAH3AnroxjFiv25L3N1CQWW6S4vMS7C42b5AzXO09u9091S9asA@mail.gmail.com>
	<7vvcuhhw96.fsf@alter.siamese.dyndns.org>
	<CAH3Anrqp3BVMpTz7DhYBL=9nt1F30_20t=FmcmdZHqMHLEqXqA@mail.gmail.com>
	<7vaabshfmb.fsf@alter.siamese.dyndns.org>
	<CAH3AnrrrvX64s3p_=5mrVcwx5FeO0iT8uX47remyCuCwPpOo=A@mail.gmail.com>
	<CAH3Anro-ve2ZoTnbEvWyNH7kEMBCQOoCDfqZbPPxymn12pzAbQ@mail.gmail.com>
	<7vvcufem32.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 23:29:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoMWc-0007Wz-3u
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 23:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405Ab1HBV3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 17:29:14 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44271 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383Ab1HBV3N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 17:29:13 -0400
Received: by ewy4 with SMTP id 4so116685ewy.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PmXPEF6If/6hXW5zcm0bR9DQLj3Ek5kySJR/+DtV9Xo=;
        b=VyHipUq9Y7nWA++c0dq9vRstoZhG/92NjqSkwbkjpSy1moCuhpog94RoQ1TxPuExmR
         xOT7J/KnB1SzJKR+KM9jlmsbPnsWHkfQkxrcGWXtk1wes2Fdcx3YToRHMZT+iHZc1aIa
         ajjREF2BRP1doF5toqSexpzd31YeSsd+BdwFY=
Received: by 10.14.41.8 with SMTP id g8mr1975701eeb.58.1312320425962; Tue, 02
 Aug 2011 14:27:05 -0700 (PDT)
Received: by 10.14.28.6 with HTTP; Tue, 2 Aug 2011 14:27:05 -0700 (PDT)
In-Reply-To: <7vvcufem32.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178511>

On Wed, Aug 3, 2011 at 3:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>>> Then, the next series can add a --bisect-head option (instead of
>>> --update-ref) to allow the head to be varied (defaulting to
>>> BISECT_HEAD) if not specified.
>>
>> To clarify: --bisect-head would default to HEAD if mode is checkout,
>> to BISECT_HEAD if the mode is update-ref.
>
> I am not sure if we ever want to allow updating anything but HEAD under
> checkout mode, so I would rather think --bisect-head is _always_ invalid
> under that mode. IOW, as I said in the previous message, these two are not
> independent options.
>

I agree. In fact, I like your idea of a BISECT_HEAD for --no-checkout,
and I don't see any need (even in the future)
to allow this to be configurable [ except perhaps if someone thinks
doing a --no-checkout with HEAD is actually useful ].

jon.
