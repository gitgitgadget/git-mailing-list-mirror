From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [RFC/PATCH] rebase: Allow to turn of ignore-if-in-upstream
Date: Tue, 13 Jul 2010 21:33:14 +0200
Message-ID: <AANLkTikjTgc2OVuyFTHdnHNDq9II-lGSvmin-4EWELPg@mail.gmail.com>
References: <4C3C1FE9.40605@drmicha.warpmail.net>
	<645d8a9bf671937c1a6962b49cf1c512e0af0d82.1279008702.git.git@drmicha.warpmail.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Marat Radchenko <marat@slonopotamus.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jul 13 21:33:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYlEN-0000et-1v
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 21:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579Ab0GMTdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 15:33:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61450 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab0GMTdP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 15:33:15 -0400
Received: by wyb42 with SMTP id 42so441811wyb.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 12:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=WMlOrc8KuYSbJ1owT9+ZP7fIiSDNLaZQ3bhm41QrE6w=;
        b=eYYzypN9tHpkSlkozCnWXmcphIpSEf30PjaEvqNk7wsKb8XF+/wa/bz8dAN7dSgzLo
         b5U+t1jANXmOgBZDZIWk1TEzX8Nv3csb1OJx/RLrGX4+PyeIgrHpSmd3h8t9CjnsvTFT
         ZQCsuEeNOqdPDbCCcK4T8OwUwuOJnvIo6m5Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=J37BHyCIxX/oB+Tp0Wtx2K9Q5ro0SD1pkjOweiPjfiWgB2MhTpKpzxpkABHWTdedyz
         cx5oyKVTPwqYZktpaIhcYWndTwMlfhneOoT9m4WgapDrfoFrryOe7HHwThVVmbZPqaTN
         Itn/zYahSf3BCTRfbwfQ/MFLWS7OPPApIxlhg=
Received: by 10.216.180.74 with SMTP id i52mr10697469wem.71.1279049594197; 
	Tue, 13 Jul 2010 12:33:14 -0700 (PDT)
Received: by 10.216.234.164 with HTTP; Tue, 13 Jul 2010 12:33:14 -0700 (PDT)
In-Reply-To: <645d8a9bf671937c1a6962b49cf1c512e0af0d82.1279008702.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150907>

s/of/off/ in the subject ;)

On Tue, Jul 13, 2010 at 10:13 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> git-rebase uses "format-patch --ignore-if-in-upstream" do determine
> which commits to apply. This may or may not be desired: a user may want
> to transplant all commits, or may opt to avoid the possibly time
> consuming calculation of patch-ids.
>
> Therefore, introduce rebase.cherry (defaulting to true) and --cherry and
> --no-cherry options (to override the config), where --cherry means the
> current behavior and --no-cherry avoids "--ignore-if-in-upstream".
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> RFC for obvious reasons (doc, tests).

-- 
Erik "kusma" Faye-Lund
