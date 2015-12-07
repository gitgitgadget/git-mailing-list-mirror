From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH] config: add core.trustmtime
Date: Mon, 7 Dec 2015 06:42:22 +0100
Message-ID: <CAP8UFD1p7kjqOnyn5Qfw5z2q0SXRnccvh1WS-+ZU+0eSkKS_2g@mail.gmail.com>
References: <1448433323-21037-1-git-send-email-chriscool@tuxfamily.org>
	<CACBZZX4YSvfA=BRayk8CC8ipk_nDdvJfznxjyb-upwP9PKRBSA@mail.gmail.com>
	<CACsJy8CT=TV8iqMsj7mU2hGn=EJ77fXqqGGdE+P7G-axC+G4YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 06:42:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5oZA-0007jU-8k
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 06:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbbLGFmY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2015 00:42:24 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33489 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbbLGFmX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2015 00:42:23 -0500
Received: by lbbkw15 with SMTP id kw15so49507272lbb.0
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 21:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LYu3mD83/oTiQDeE3/woaC0v9PgcuKtvdbzQrK/DHGE=;
        b=ciCgSxjSbQ78WlXA0DAyBB700Lsd0uVnOuf6HeGFqxPINK9z2dePrz6JdzoR+BSffc
         BwnmwgfpnoSWAPn9Twi7beP8H2SwixhBeMOOM3qwiCttbCQvqTqxh38KHBxyRv116Tx4
         2xo5Zyc5Z1zaHFeCLCTuXSgoa1POqp0gIA5dDYKlaS57JzeDiU8dL0IaPzSIymPrV1kV
         62diS8wy1Amd4eY3xK66ylZHb07qO1ZOQVqiy70kVLnRwkdrndtfB2fWn5JS+03pLUFk
         lxqocDcWMVBL7MfBskBKofIl0O1FAi/KussPou1e9+w7B6neaJtyiyXbhHyE3rT3EUNZ
         ZA3g==
X-Received: by 10.25.42.208 with SMTP id q199mr13340797lfq.67.1449466942239;
 Sun, 06 Dec 2015 21:42:22 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Sun, 6 Dec 2015 21:42:22 -0800 (PST)
In-Reply-To: <CACsJy8CT=TV8iqMsj7mU2hGn=EJ77fXqqGGdE+P7G-axC+G4YA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282081>

On Wed, Dec 2, 2015 at 8:28 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Nov 25, 2015 at 10:00 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
> <avarab@gmail.com> wrote:
>> Aside from the slight hassle of enabling this and keeping it enabled
>> this feature is great. It's sped up "git status" across the board by
>> about 40%. Slightly less than that on faster spinning disks, slightl=
y
>> more than that on slower ones.
>
> Before I forget again, you should also enable split-index. That
> feature was added because index update time cut so much into the
> saving from untracked cache (unless you have small indexes, unlikely)=
=2E
> And untracked cache can update the index often. Then maybe you can
> also think about improving the usability for it to ;-)

Yeah, we will probably have a look at split-index next.

Thanks for developing it too,
Christian.
