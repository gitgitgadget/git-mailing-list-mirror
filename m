From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Thu, 25 Nov 2010 19:06:19 +0100
Message-ID: <AANLkTi=hRk-bqNvvMRCmbSu8Mc4uux5aowgLGnPLnD4A@mail.gmail.com>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org>
	<AANLkTi=U=Km28W-xUM0vmRhhYCuhjSxxk5Fk_yhvjz8K@mail.gmail.com>
	<AANLkTinWtG8dp_CvoH+EWYz4d=D-N0QUiBSrCNwamROo@mail.gmail.com>
	<AANLkTim0hYKcPPaZjxjbpekhR4Ho_cOVaE=41HyJOrMZ@mail.gmail.com>
	<AANLkTi=N=-e+BYM+Bjp665pN=GxK5fWSKbJ34T8Qfh77@mail.gmail.com>
	<AANLkTind1tQ2bE3O-_dz+LOa4gW1X3J28uvRg1mP7aU=@mail.gmail.com>
	<AANLkTi=gg=cqTewgUfqctbd=MdYNcL=jECyCXJycwx_k@mail.gmail.com>
	<AANLkTikcZ1-7+ATH1mB+ycQiL7-WRtjwBZ8rkue_-Vom@mail.gmail.com>
	<AANLkTin-kF_+DKDAu=gt12WfOcEVJaED-Qny8sFQ=oKP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 25 19:06:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLgDC-0003hy-Sw
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 19:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992Ab0KYSGW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 13:06:22 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50109 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab0KYSGV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 13:06:21 -0500
Received: by fxm15 with SMTP id 15so101156fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 10:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rJomF4zACZjdY7iXHnIoIqPgyu0L+TW0CwKJfIOLG6k=;
        b=YdYZCubnVYuI8c/WRYcjo3eOgCsnj3Ti6KC7IhQzfKLJ5ulNDs8nYQ8kTKE15yxVuf
         R2hgiMJxDRSw/MqO/zJiG0Ou2ZGTenv71ytpiWZrEyJ7KTyfWuxC65JwPIpbarExy/8t
         kenY70+Xb5F4CQZ0jsZoVsiOxmJnMu3vUnR24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F+6/ZYQOhQqgwqBI5u4addgzp6fkO73OQwvg30HMK+cDqYk5cv9Mjp1qlPIypakiZv
         ffuOw1nW1RfrbuuPj6z7482QlBXFrjIk4+jQN+7OA5aSr6OVV3iVIWrz9emLHnAQElm1
         t10t3PYkv86mHqkHQrg9g9J5GIM6IEXeLNuTQ=
Received: by 10.223.93.142 with SMTP id v14mr1085741fam.49.1290708380067; Thu,
 25 Nov 2010 10:06:20 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Thu, 25 Nov 2010 10:06:19 -0800 (PST)
In-Reply-To: <AANLkTin-kF_+DKDAu=gt12WfOcEVJaED-Qny8sFQ=oKP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162149>

On Thu, Nov 25, 2010 at 18:55, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> On Thu, Nov 25, 2010 at 5:33 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> Anyway, if that works it's a cleaner way to disable it.
>>
>
> Yes, that works. But that is a work-around, not a solution. I already
> told the make system not to translate git, why should I have to
> anything else? In fact, I did exactly what the documentation at the
> top of the makefile told me to do. It says to set NO_GETTEXT, nothing
> about clearing NEEDS_LIBINTL.

Oh yeah that's definitely a bug that I need to solve. But that should
just be something like:

ifdef NO_GETTEXT
    NEEDS_LIBINTL =3D
endif

Stuck in some strategic location. Then it all should just work.
