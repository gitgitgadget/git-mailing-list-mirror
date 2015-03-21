From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 4/4] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Sat, 21 Mar 2015 18:01:17 +0800
Message-ID: <CACRoPnRC0V6MZvfBBG9sx4vxnC4J1UdyiGoXaxbRHd=PZjC_kA@mail.gmail.com>
References: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
	<1426662276-8728-4-git-send-email-pyokagan@gmail.com>
	<vpq3852dzry.fsf@anie.imag.fr>
	<CAPig+cTaQAnWoz7=v9tOPZoeE3LTV+H6KD_tAzmOXi3Tjay_WA@mail.gmail.com>
	<vpqy4mtrtxm.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Mar 21 11:01:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZGDj-0000yL-5z
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 11:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbbCUKBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 06:01:21 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34163 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbbCUKBT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 06:01:19 -0400
Received: by lbbsy1 with SMTP id sy1so90524149lbb.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qDCFiPk/rPBV4oEbUcRkeYEgV5yTQ5fCb4tiEDjUQIM=;
        b=Cofh4774vrvCCjALUWnUuRs8ZiJQdL1T/YMqqgLsWt8ZKYdMmGU4z4GrRkF1S2jTBd
         rs73JIeY08kkyU5HK3B7DXTjM1jo/ySF72KyQdfe4n0ox7unaxwKygFS9QalnBBE7hF3
         SlhYWXPgg9e5GXJIiZFcPAmVpNdaThzq+Wo4z1AizThEg7246kOQgOFhrVq94gNR2noj
         rjnItjRkv14nMj7z6QuGLc9Yo6lZVu/yiojcJIpLtaSUCNpXGf7oyZfQ6Ogc4IHA4Kh0
         V7h6lHWyHxVBEjEl2wpB/wWQ3dTW1lc8Yv3O+WpJIFS3yK6sQZRCs68JgehxH985D9y/
         /enA==
X-Received: by 10.112.218.5 with SMTP id pc5mr395703lbc.32.1426932077963; Sat,
 21 Mar 2015 03:01:17 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Sat, 21 Mar 2015 03:01:17 -0700 (PDT)
In-Reply-To: <vpqy4mtrtxm.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266017>

Hi,

On Thu, Mar 19, 2015 at 9:35 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> I also tend to favor adding "failure" tests which are flipped to
>> "success" when appropriate, however, as this is an entirely new
>> feature, this approach may be unsuitable (and perhaps overkill).
>
> I can buy the "overkill", but not unsuitable. Even for new features, the
> tests should fail before and pass after. Otherwise, the tests are not
> testing the feature. Actually, this is a strong principle in test-driven
> development: don't write code unless you have a failing test.
>
> But I was just thinking out loudly, certainly not requesting a change.

I also think that the tests belong in their own patch as the patch is
really long compared to the rest of the patch series and it makes it
easier for me to respond to comments as well.

Putting the tests before the implementation, though, makes sense in
this case as it is just an implementation of a well-defined set of
requirements. Some tests will still pass with or without the feature,
but that is the requirement of the feature -- which is to not be
enabled until the user explicitly creates the xdg file. Will re-order
the patch series in the next version.

Thanks.

Regards,
Paul
