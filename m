From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 0/5] bisect: Add support for a --no-checkout option.
Date: Tue, 2 Aug 2011 08:19:59 +1000
Message-ID: <CAH3Anrqp3BVMpTz7DhYBL=9nt1F30_20t=FmcmdZHqMHLEqXqA@mail.gmail.com>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
	<201107301548.09815.chriscool@tuxfamily.org>
	<CAH3Anrp8aT1UwfstJ99Ug4MD2CZKB9oE_oRLksbkGGE1xSELsg@mail.gmail.com>
	<201107301619.51438.chriscool@tuxfamily.org>
	<7v39hmkkth.fsf@alter.siamese.dyndns.org>
	<CAH3AnroxjFiv25L3N1CQWW6S4vMS7C42b5AzXO09u9091S9asA@mail.gmail.com>
	<7vvcuhhw96.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 00:20:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo0qE-0006eJ-3D
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 00:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678Ab1HAWUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 18:20:01 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36368 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665Ab1HAWUA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 18:20:00 -0400
Received: by vws1 with SMTP id 1so4829155vws.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9FYEyE1qmw1Z42gXlgSnnUSbGjhsix6b4o6IrcdW9wg=;
        b=aX/5EqKuB5ZYMAQhRs0xGFwYsPsP57D/wn2OfPqYAA/v3Iu97XbmDVv/4ZBJ53Z6B3
         dV02H3FIZq+Krk6/DmPIQEDvvLof3LjOop2O+DvudnTgieBW3MLaFkQoyQIp1CbEXqeF
         9NbyFXkPd79yK8qiLqnoNllRyzX0B/4EkToc0=
Received: by 10.52.26.170 with SMTP id m10mr9303vdg.164.1312237199692; Mon, 01
 Aug 2011 15:19:59 -0700 (PDT)
Received: by 10.52.183.39 with HTTP; Mon, 1 Aug 2011 15:19:59 -0700 (PDT)
In-Reply-To: <7vvcuhhw96.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178422>

On Tue, Aug 2, 2011 at 3:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> It might become more important if someone ever writes a tool that does
>> a bisection on the user's behalf. In this case, aborting the tool
>> might leave the HEAD in, what appears to the user, a confused state.
>
> Yes, I would prefer a series without --use-this-ref-for-bisect-status and
> then a follow-up series on top of it to add that as a separate feature.
>
> Thanks.
>

Ok, I understand that you are not convinced that such a series is
necessary and so may not integrate it at this point.

However, I will prepare one, just for the record.

In this hypothetical additional series, are you happy for
--no-checkout to become a synonym for --update-ref=HEAD in the manner
of v8? From a technical perspective, it doesn't seem necessary to
duplicate the state variables and parameters.

jon.
