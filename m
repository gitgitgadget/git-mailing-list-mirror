From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] revision: add --reflog-message=<pattern> to grep reflog messages
Date: Wed, 26 Sep 2012 21:15:43 +0700
Message-ID: <CACsJy8D=OPtbuygjSFx+Wcwo=hgq2RsumgeNzpNk-4QGH1CVdg@mail.gmail.com>
References: <1348661565-30484-1-git-send-email-pclouds@gmail.com> <7vpq58ubbx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 16:16:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGsPY-0006D5-2O
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 16:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539Ab2IZOQO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Sep 2012 10:16:14 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59330 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab2IZOQN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2012 10:16:13 -0400
Received: by ieak13 with SMTP id k13so1489741iea.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/QPtoDOt//8vTs/9ZEMQQ4E8ne+qejNE9ZDZdylwvC4=;
        b=Hnn5d+7hAkslJ6u7rVQvDlu3moMy8AUX/RdD97e7tIM9BL33KmIvU+yy0TT2hlpRlF
         M9IOPW/Ft/epJEfb6q5i+SWFFdmaTngR1rMwU28wCMtpAFqXLww8P9vHWwg0MyD6ZpeB
         B0z6CK28dQFRHKzpk4DUe+KY8hLJM6vlSet3y8cXy8Q6eE6tHrjXCYMYtgnfMC9mVldw
         TT6PhDgDvW6BbgTtR9x7DewtJ6f2uYsC1nKaXucNnGA/LcgTIMM3twhNQGKaWVY7vRT8
         p+bz/grsH3yEcc82VHqy+vCWmohaUjz2xcq7b6KIocdIGNttAWXs//ickfpAmf+8l8zn
         5aqQ==
Received: by 10.42.129.83 with SMTP id p19mr543714ics.9.1348668973203; Wed, 26
 Sep 2012 07:16:13 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Wed, 26 Sep 2012 07:15:43 -0700 (PDT)
In-Reply-To: <7vpq58ubbx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206418>

On Wed, Sep 26, 2012 at 9:07 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Both "git log" and "git reflog show" recognize this option.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> How well does it interact with --grep and/or --all-match?

Good point. It currently works like and operator. But people might
expect to combine them in different ways.
--=20
Duy
