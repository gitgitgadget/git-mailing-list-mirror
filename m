From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: t7610-mergetool.sh -q isn't quiet
Date: Fri, 20 Aug 2010 21:03:01 +0000
Message-ID: <AANLkTink1HaOWCYsr5+Q+JAi_zA_gEHmOU1J3fvq8jnd@mail.gmail.com>
References: <E395511F-ACF9-4390-A081-4AC4C072C7CC@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Charles Bailey <charles@hashpling.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 23:03:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmYk1-0002X9-QT
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 23:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038Ab0HTVDE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 17:03:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58873 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab0HTVDD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 17:03:03 -0400
Received: by fxm13 with SMTP id 13so2005425fxm.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 14:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dF3crXWgvelKwzsQ3KYx2K1VFYQZdWd6FfUmGfk5nHQ=;
        b=RtaYZx4LfkphzdLazR7NC4BRt1aK7OqMF9TYrqp+C35jDARPEnYfMSQTesGdAlIpt4
         ysaTI9qIHoS9Kvo71AQihjBT+ZzAw6DLGXQvcl2J+bmSj90ilK0EpU0iMOjQ9565XdVg
         QTf2IG0B8Mntt8SzemlEz9n5wSnT6IYSWBU6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xe8u+1t8LZUi0dnGGhp87HhkXIrDwssBedo6RiftAgSwhFnpbvahkX3euYtldj0ZSi
         91hqF4BnWRu3bFU1LuhDq01QRP2a1EUNgwTIHllrrAKGYhetpyNpXrTnzhw6hOa1H5oU
         f8xSaFhEV+B1feya/HmdFcW2QqyFP7iEXfHjs=
Received: by 10.223.126.84 with SMTP id b20mr1532898fas.98.1282338181178; Fri,
 20 Aug 2010 14:03:01 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Fri, 20 Aug 2010 14:03:01 -0700 (PDT)
In-Reply-To: <E395511F-ACF9-4390-A081-4AC4C072C7CC@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154082>

On Fri, Aug 20, 2010 at 06:50, Brian Gernhardt
<brian@gernhardtsoftware.com> wrote:

> =C2=A0 =C2=A0test "$(cat ../file1)" =3D "master updated" &&
> =C2=A0 =C2=A0test "$(cat ../file2)" =3D "master new" &&

That should also use test_cmp.
