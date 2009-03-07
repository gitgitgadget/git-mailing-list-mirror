From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] config: set help text for --bool-or-int
Date: Sat, 7 Mar 2009 23:07:46 +0200
Message-ID: <94a0d4530903071307p46092810rb1637bfc853ee4d1@mail.gmail.com>
References: <1236446046-18319-1-git-send-email-peff@peff.net>
	 <1236446046-18319-3-git-send-email-peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 07 22:09:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg3lm-0006bZ-0N
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 22:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755622AbZCGVHu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 16:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755423AbZCGVHu
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 16:07:50 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:44752 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163AbZCGVHt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2009 16:07:49 -0500
Received: by fxm24 with SMTP id 24so787113fxm.37
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 13:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hcGhCxJRH7s2RMH8h0tANvHHSuuFEn33JVIllSYWBBc=;
        b=uIHB+m60GtCwZqoSY80yCs4WTwagFRgDvfheuz8UFJsaWwDO+tRNtORwlVtbHf0tMQ
         CO7p0hSUxvSHmSqoMkSd3cuBVR1fzSJrbIvqoGlv5kD1nvMzNBKGsOiFfi5q+A+BJ1pW
         o3VaV2knUTve0dWBQweAOtASZZbugRciTaiKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FjapaqQpan2eOp9qSDR9jbEyksNnV0SJZcY+zVgJKhp4Fb2Ghc2i3BqbmDzDBszuBZ
         3PY9L1WCJHsVdrIlbtSHP84wzgQP+ScKQPrGymhur28jEe+3C5V6j+dYSMewxZ2GoZCl
         5nNOckhOI/YBbON3ef7Ko885AF0RGBSzUP1gQ=
Received: by 10.86.95.8 with SMTP id s8mr2902982fgb.28.1236460066562; Sat, 07 
	Mar 2009 13:07:46 -0800 (PST)
In-Reply-To: <1236446046-18319-3-git-send-email-peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112585>

On Sat, Mar 7, 2009 at 7:14 PM, Jeff King <peff@peff.net> wrote:
> The conversion to parse_opt left this as NULL; on glibc
> systems, the usage message prints
>
> =C2=A0 --bool-or-int =C2=A0 (null)
>
> and on other ones, segfaults.

Shouldn't then OPT_BIT make sure there is no crash?

I was surprised when it didn't complain. I thought on making it "" but
I wanted to make it visible that there was no documentation for that,
which is the reason I left it that way.

--=20
=46elipe Contreras
