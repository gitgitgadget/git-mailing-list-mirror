From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: preserve-merges fails on
 merges created with no-ff
Date: Wed, 27 Apr 2011 10:15:35 +0200
Message-ID: <BANLkTi=Cu2nXiLaOT0v-Zwz6uGg=UKuyfg@mail.gmail.com>
References: <1303357080-25840-1-git-send-email-andrew.kw.w@gmail.com>
	<4DB77E53.7070206@sohovfx.com>
	<7v1v0ob851.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Wong <andrew.w@sohovfx.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 10:16:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEzuk-0004hO-Ne
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 10:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652Ab1D0IPk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 04:15:40 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42590 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab1D0IPg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 04:15:36 -0400
Received: by gxk21 with SMTP id 21so522507gxk.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 01:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sQKDAGBffnfHfqHOGggr2y9BmMR3DlbP6rTcpTQgfFU=;
        b=yBMCK15ouh0Tmgskf9abwgJAw0dOYVJbo0LQXTw2JD/e+7qz1Ra4JQm5SvdW6vu+r4
         Dh9Msp7N2gW2VwNP5zINKBaIHN7oHyoBcvqG1S3C9xnw2c1snJTR0b6wo/vKOmVveuHN
         uCwTZStN4WBb59jZBfaQowB5dptn7rcBMmbAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Gpuqvh6n0v26EF4TmReKU5pROwLwJrEMYEuQGUduTYyJQ/SKL3F93LT/++pEPhgHIf
         3kQeITWiPl5XJQphZCKGvfpx6U8Lm22IWBLYOx9zURg4SlSxDQiWMR1dqLp04fqERAZh
         p5yLTosY7L5XKzX4bmTiuj858oX1RVIrnV+g0=
Received: by 10.236.178.102 with SMTP id e66mr2258106yhm.213.1303892135938;
 Wed, 27 Apr 2011 01:15:35 -0700 (PDT)
Received: by 10.146.82.10 with HTTP; Wed, 27 Apr 2011 01:15:35 -0700 (PDT)
In-Reply-To: <7v1v0ob851.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172188>

On Wed, Apr 27, 2011 at 7:00 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Andrew Wong <andrew.w@sohovfx.com> writes:
>
>> Could someone please take a look at this patch?
>
> I took a look at it when you sent it out, and found it so obviously a=
nd
> trivially correct that I expected that others will soon say it looked
> obviously the right thing to do.

Me too!

> =A0So I decided to wait until that to
> happen before applying it.
>
> But nobody said anything, and forgot about it.
>
> Let's see if it happens soon enough this time ;-). =A0Thanks for a re=
minder.

Thanks from me too,
Christian.
