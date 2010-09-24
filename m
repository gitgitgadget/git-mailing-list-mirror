From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Let's bump the minimum Perl version to 5.8
Date: Fri, 24 Sep 2010 14:04:08 +0000
Message-ID: <AANLkTikLYjKHyYOqiubygOD6nWO-FUS38dLALnx3iJ_8@mail.gmail.com>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>
	<86pqw3uuba.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arntsen <tor@spacetec.no>, Tait <git.git@t41t.com>,
	git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 16:04:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz8t7-0004pR-BA
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 16:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261Ab0IXOEO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 10:04:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50531 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932257Ab0IXOEN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 10:04:13 -0400
Received: by gyd8 with SMTP id 8so972307gyd.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W/wpdUDnzNnE8OyKGEUc3vzcJ3c17/IFFYXqDoacr6s=;
        b=crAaE7x9I/wwpIOBp3A2cXtGuDrWLjHzzGu7VzIslvzVZ6j/VNsgRTC4s0QvJaqBAe
         gHf3AKng8dGdQwbVYDaIFrXIjkht5fcCXq7eQE8R9QK5URVXDJ7DaBJRoXLU1jfndMiS
         cFY/4Q2iE7Q9+2xF7Op3C2WF2Sue1ovLKg1Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MRmZCA0J6eLr3MQYCfv7XmUnwhkxNu0VbZ67VLicOP9C/P5+++KLHaKfG+ZVN5UJIB
         xDRy9YMROmGYRklfcZdkUaLkWUuRahkm70nUrLQ9Y0rZ2GaGPVNmDitQV5juz+LktRM2
         vGTmfeouIa1UOgV3ERmlGCAMPUz5sRENxYU5U=
Received: by 10.100.8.11 with SMTP id 11mr3862079anh.66.1285337048951; Fri, 24
 Sep 2010 07:04:08 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 07:04:08 -0700 (PDT)
In-Reply-To: <86pqw3uuba.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156990>

On Fri, Sep 24, 2010 at 13:47, Randal L. Schwartz <merlyn@stonehenge.co=
m> wrote:
>>>>>> "=C3=86var" =3D=3D =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> writes:
>
> =C3=86var> Since we're not getting patches for common things that hav=
e been
> =C3=86var> broken on 5.6 for years and bumping the requirenment to an=
 8 year old
> =C3=86var> perl (5.8) instead of a 10 year old one (5.6) would make t=
hings much
> =C3=86var> easier, including:
>
> =C3=86var> =C2=A0* Fixing the perl/ Makefile mess
>
> =C3=86var> =C2=A0* Being able to use 5.8 features
>
> =C3=86var> =C2=A0* Being able to honestly support the 5.8 release, 5.=
6 doesn't even
> =C3=86var> =C2=A0 =C2=A0compile on modern systems without undocumente=
d monkeypatches, and
> =C3=86var> =C2=A0 =C2=A0few people use it so we don't get fixes for i=
t.
>
> =C3=86var> I'd like to propose dropping 5.6 support, and move to say =
5.008. I can
> =C3=86var> do the work required to add appropriate docs / use stateme=
nts and
> =C3=86var> fixes to bugs that we can't fix on 5.6.
>
> As the token resident Perl expert, I'd be completely fine with that.
> Sane choice.
>
> It might be useful to document that by adding:
>
> =C2=A0require 5.008;

Right, except that should be `use 5.008`. Since you don't want to run
anything else within an implicit or explicit BEGIN block before perl
fails on that. E.g. `require 5.008; use Digest::MD5;` would just spew
an error about Digest::MD5.

The only reason you'd want `require $version' is if you care about
5.005, but even then you can do `BEGIN { require 5.008 }`.
