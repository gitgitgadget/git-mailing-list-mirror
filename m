From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/6] Gettext poison rework
Date: Fri, 24 Aug 2012 17:54:28 +0700
Message-ID: <CACsJy8CEmafo3mXB7nS8MxN-yMwpsPEan5OU0K=SJi0jm4MtxQ@mail.gmail.com>
References: <1345786986-10826-1-git-send-email-pclouds@gmail.com> <CACBZZX7V3A02sPQex4zpBE8Tkmc2d037tJBfhn-6DeK_MwY2Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 12:55:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4rXj-0001ew-1M
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 12:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759270Ab2HXKzF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 06:55:05 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42960 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758778Ab2HXKzB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2012 06:55:01 -0400
Received: by ialo24 with SMTP id o24so3166845ial.19
        for <git@vger.kernel.org>; Fri, 24 Aug 2012 03:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7r/H4tUARV20f0tvNjWWLnpTXpR/Y/YEuXe6bwp38Dk=;
        b=e6KP2odsxoiBcpEWMG0GHuiaGfF0BLC8y/xfxUuPOQiEMQDKaF/YS6IZAQHjKPOD2m
         Y8lAEPNk8T0HkjpHXm/SUF/XcRMIqmJfIdDr66q9QqOr3ntxPGJ0NXZY1niBxTFVHwee
         MUEbtPK3xHiaZ+WUBPwY9knU0iFO6VlCz6kQY4YsaYmKF0hGLAN8u6XW2F/a0nwET4hO
         LlCSALssUlz8/wdp1wfwjCHe+6nBeqZnx67AB2NB+zqLUHZCus4wIFOde3dOwkVoV8mk
         T065hZ1VWQ1xqDBPSndjKnzmKynGUbKv4S586UVTtD6TV9/0zOUDDlyg8M+SJZ3kqGZh
         Wjzg==
Received: by 10.50.193.201 with SMTP id hq9mr1617796igc.48.1345805698435; Fri,
 24 Aug 2012 03:54:58 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Fri, 24 Aug 2012 03:54:28 -0700 (PDT)
In-Reply-To: <CACBZZX7V3A02sPQex4zpBE8Tkmc2d037tJBfhn-6DeK_MwY2Hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204204>

On Fri, Aug 24, 2012 at 3:51 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>> [1] http://bugs.locamotion.org/show_bug.cgi?id=3D2450
>> [2] http://translate.sourceforge.net/wiki/toolkit/podebug
>
> The reason I didn't do something like this to begin with is that
> gettext/glibc doesn't have support for fake locales, so you'd have to
> appropriate a real one for tests. It's good to see you poking the
> gettext mailing list about adding support far thot.

I don't see glibc getting fake locale support any time soon even if
it's more open than before. I can try to make gettext support pseudo
translations, though not sure if I can make it.

> But something like podebug gets around that quite nicely, so we can
> still have the testing the poison stuff was intended for, without the
> complexity of supporting it throughout all our i18n code.

But yes, even if gettext does not have native support, relying on
podebug should be ok. Whatever changes we need, other projects might
too. It's better to do it outside of git.
--=20
Duy1
