From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 1/4] git-credential-store: support multiple credential files
Date: Wed, 18 Mar 2015 14:39:39 +0800
Message-ID: <CACRoPnRpSV9q1A24=8jP1bRCf5sTZRY7owWqMtWCGq-R1b5Rjg@mail.gmail.com>
References: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
	<1426056553-9364-2-git-send-email-pyokagan@gmail.com>
	<20150313061530.GA24588@peff.net>
	<CACRoPnR9pTc2LC87Vf0bMAgTj-FnbsRBpjn+3RCxCP6yrzsCkw@mail.gmail.com>
	<xmqqfv97w7k5.fsf@gitster.dls.corp.google.com>
	<vpqbnju7aex.fsf@anie.imag.fr>
	<xmqqy4myt4dt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 07:39:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY7ds-0001NB-QX
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 07:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591AbbCRGjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 02:39:41 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:36831 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbbCRGjk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 02:39:40 -0400
Received: by lamx15 with SMTP id x15so27889022lam.3
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 23:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IEcgkIanATCV8xcO26lyHJ99kxVtrJHxRZYZ6uq0MkM=;
        b=g4juFXkMHHHjI2MKiTkR2TEPcqcnX8tEFn4CxTDdBhoX7ooSI/csIersqurkqPetf6
         If7IGrwdUHW64jyrcnA58cpObOlO2FuaKNRLyECVSzhFXyqRjEiDz0NtvlU0tjtykPTy
         Y+lEf/OCQoDWr8YPIXCvj3CJScPvVezOqXanpjPeyOzfM1iceKD2II8uLn8FBtv9F8W+
         BWu87HtRAo2RjYjf8g6lm3UDnEPN1Of9D2nJ0AdXUr+2GaHnON1igW2gtB7wcNEhKWUb
         Pu+3dRzCZvggLLRy76kZjQ/zgE2wPTiCgDBzTUidO/TfiObPjOpODSKVUx1N0zH9igDm
         WhIw==
X-Received: by 10.112.201.231 with SMTP id kd7mr42823869lbc.35.1426660779141;
 Tue, 17 Mar 2015 23:39:39 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Tue, 17 Mar 2015 23:39:39 -0700 (PDT)
In-Reply-To: <xmqqy4myt4dt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265682>

Hi all, thanks for providing your feedback.

On Sun, Mar 15, 2015 at 6:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I am not sure if this is not a premature over-engineering---I am not
> convinced that such a future need will be fulfilled by passing just
> a single default_fn this version already passes, or it needs even
> more parameters that this version does not pass yet, and the
> interface to the function needs to be updated at that point when you
> need it _anyways_. One thing that we all agree is that we don't need
> the extra parameter within the context of what the current code does.

After considering everyone's responses, I've decided to remove the
argument in the v4 patch. As Junio says, when there is a policy change
the code can be modified anyway.

Regards,
Paul
