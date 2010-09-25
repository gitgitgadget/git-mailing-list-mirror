From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv3 15/16] Add missing &&'s throughout the testsuite
Date: Sat, 25 Sep 2010 13:48:47 -0600
Message-ID: <AANLkTim2axfaZ-ehBie4UhSfEDtkofvbW-1DZxe0mp_V@mail.gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
	<1285441627-28233-16-git-send-email-newren@gmail.com>
	<AANLkTi=5_vAu=X0Rg9WeOko1DrYsF6dc=FeHGfUHsUzd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 21:52:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozana-0006dV-7p
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070Ab0IYTsu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 15:48:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34262 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab0IYTst convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 15:48:49 -0400
Received: by fxm3 with SMTP id 3so1244581fxm.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=exn4zXDln/wTSpZZPCnvaggo+y15kstNn5KjBjXYOKw=;
        b=FLdE0f5OhLGOOJ41Z2yQ0JvN8guhO+CxXfxpXqUoKLKZ7GUMdtiTYrhxJWo6PpU0f6
         DXHzjL2LlQVtt7RP8thIv8rxgLsnSuNn9WPD6E2UTiUxi4l8Zz+1N8QSS7xWk1y6CfcU
         koTuxIjUfuwHxnkXxPz2MLAhUV259LHsKry40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YE/pHer/fNg1sq6eWM/2MJ87EaAmTT/YY7RBLsSerTvsTNLCfcdYCVdP+GMwrhZ2bY
         nXg/zjzuPSKQdAboZ7C0TSYnyXdIDYg79AMTtBETv9NWjGDYJbm6D8WkWcMd+EkD/nVW
         6nceq4wp415lGKhcEndC7+7Ea4sxOsPx8TwM8=
Received: by 10.223.114.20 with SMTP id c20mr5284557faq.26.1285444127924; Sat,
 25 Sep 2010 12:48:47 -0700 (PDT)
Received: by 10.223.119.209 with HTTP; Sat, 25 Sep 2010 12:48:47 -0700 (PDT)
In-Reply-To: <AANLkTi=5_vAu=X0Rg9WeOko1DrYsF6dc=FeHGfUHsUzd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157194>

On Sat, Sep 25, 2010 at 1:38 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Why is the && at the end of the EOF, on my system with dash:
>
> =C2=A0 =C2=A0$ cat /tmp/meh.sh
> =C2=A0 =C2=A0#!/bin/sh
>
> =C2=A0 =C2=A0cat <<EOF >/tmp/file
> =C2=A0 =C2=A0foo
> =C2=A0 =C2=A0bar
> =C2=A0 =C2=A0EOF &&
> =C2=A0 =C2=A0cat <<EOF >>/tmp/file
> =C2=A0 =C2=A0foo
> =C2=A0 =C2=A0bar
> =C2=A0 =C2=A0EOF
>
> =C2=A0 =C2=A0$ /bin/dash /tmp/meh.sh ; cat /tmp/file
> =C2=A0 =C2=A0foo
> =C2=A0 =C2=A0bar
> =C2=A0 =C2=A0EOF &&
> =C2=A0 =C2=A0cat <<EOF >>/tmp/file
> =C2=A0 =C2=A0foo
> =C2=A0 =C2=A0bar
>
> The && should be directly after /tmp/file, no?

Yes, it should.  Not sure how I didn't catch this, but thanks for the s=
harp eye.
