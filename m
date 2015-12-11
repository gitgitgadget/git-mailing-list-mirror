From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 5/8] dir: add add_untracked_cache()
Date: Fri, 11 Dec 2015 09:54:20 +0100
Message-ID: <CAP8UFD367LKTWHX2JdS_63n25n+0k_=OKSGQ1s7SJcJnbHjcCA@mail.gmail.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-6-git-send-email-chriscool@tuxfamily.org>
	<5667DA2B.3000506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 11 09:54:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7JTE-0000q2-27
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 09:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbbLKIyX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2015 03:54:23 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33359 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbbLKIyW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2015 03:54:22 -0500
Received: by lfap203 with SMTP id p203so6316990lfa.0
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 00:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=iHC1iE3n/gDIwpLiqW7hoG7hHPcOEuwPG3iPcHtLSsw=;
        b=tUTaTEfAd+UD3fojl1YIHfZ6CcMVylZZzkAHb2KpLGSaZctshMzSQhDkR33zMeHj7G
         esPC+H2Q39MiZux+1Xo95CVE7JDCLYY7WxsMKRlHid5BgfQDpTlpiRMaUcG25aOYn05t
         nTRyv6YQDMOBhKOgblSeloqXWp+ov4TzzpYYH3hH9M+WHspFntZyuduwNuIvHT51J/X+
         G5vgVYIVuW8iv82ETfy20aL5xXT5G4CxVhipX9BCX+hYbs2Q6lnNsFms6NA6VeQQeQHa
         m4+jBFc8XLGK2qyp4K3/ZNW8hFWL4Lbm7nIPn68Kd8s3sfTAmpqngtKvicCiv3UWaqy0
         Ykuw==
X-Received: by 10.25.3.207 with SMTP id 198mr7331160lfd.47.1449824061025; Fri,
 11 Dec 2015 00:54:21 -0800 (PST)
Received: by 10.25.23.90 with HTTP; Fri, 11 Dec 2015 00:54:20 -0800 (PST)
In-Reply-To: <5667DA2B.3000506@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282252>

On Wed, Dec 9, 2015 at 8:37 AM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 08.12.15 18:15, Christian Couder wrote:
>> This new function will be used in a later patch.
> May be
> Factor out code into add_untracked_cache(), which will be used in the=
 next commit.

Thanks for the suggestion. I think I will put something like this:

    Factor out code into add_untracked_cache(), which will be used
    in a later commit.
