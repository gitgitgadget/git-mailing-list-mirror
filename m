From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 10/11] config: add core.untrackedCache
Date: Thu, 24 Dec 2015 17:13:22 +0700
Message-ID: <CACsJy8C0CwbFy+Ghk3EWTyhqPYcr6xE5jczumWW98cAAHdfmPg@mail.gmail.com>
References: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org> <1450904639-25592-11-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 11:13:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aC2uE-0006dJ-EM
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 11:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbbLXKNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2015 05:13:54 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:32772 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbbLXKNx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2015 05:13:53 -0500
Received: by mail-lb0-f181.google.com with SMTP id sv6so51673175lbb.0
        for <git@vger.kernel.org>; Thu, 24 Dec 2015 02:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QBACvEiS6LZBPBEu4dPBfjZHe4mLMPLZ2ESwmTkg8Zg=;
        b=MtU+sdeL3bSWRCWltOdJbZcN74qCMx/R2KtSnX8/Qc8lvokSHVGRGLhWqI73sVCN9j
         vZ7BPETwbrFWAOl4zUpqJPdcJW5n4J03pAZk1dvSztkSvKwJkQTFNbrUlcZSRrX+qlav
         5b/nx/Jv5/NuG0r3vdvfBQ54Lhr1k7omS9xjUfwXSMA2DIHSyc2o6zf/7nX8GxvYQ7U2
         cNaREE9wg1aFGKR8jQ5D8hpmHSJ1PlPVXC35bsJXkecoLoAOhQYEfFFKxvBuq1otCh/w
         3U8LXm+59vDnlCm9pLIDCA8F0wOkM342CPLvLh16R/9RkqZcVm3fICfGMSk0li4tRsHU
         bK5A==
X-Received: by 10.112.172.233 with SMTP id bf9mr12136881lbc.137.1450952031807;
 Thu, 24 Dec 2015 02:13:51 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Thu, 24 Dec 2015 02:13:22 -0800 (PST)
In-Reply-To: <1450904639-25592-11-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282979>

On Thu, Dec 24, 2015 at 4:03 AM, Christian Couder
<christian.couder@gmail.com> wrote:
>  --force-untracked-cache::
> -       For safety, `--untracked-cache` performs tests on the working
> -       directory to make sure untracked cache can be used. These
> -       tests can take a few seconds. `--force-untracked-cache` can be
> -       used to skip the tests.
> +       Same as `--untracked-cache`. Provided for backwards
> +       compatibility with older versions of Git where
> +       `--untracked-cache` used to imply `--test-untracked-cache` but
> +       this option would enable the extension unconditionally.

Nit. The reason --force-untracked-cache remains can probably stay in
the commit message. Here we can simply say "synonym of
--untracked-cache, deprecated" or something like that (or even ".. to
be deleted in version N.M").
-- 
Duy
