From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Thu, 25 Nov 2010 13:00:46 +0100
Message-ID: <AANLkTim0hYKcPPaZjxjbpekhR4Ho_cOVaE=41HyJOrMZ@mail.gmail.com>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org>
	<AANLkTi=U=Km28W-xUM0vmRhhYCuhjSxxk5Fk_yhvjz8K@mail.gmail.com>
	<AANLkTinWtG8dp_CvoH+EWYz4d=D-N0QUiBSrCNwamROo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 25 13:01:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLaVr-0006cX-Up
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 13:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab0KYMAs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 07:00:48 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45980 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab0KYMAs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 07:00:48 -0500
Received: by fxm13 with SMTP id 13so693316fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 04:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l4RMzCzwKPmBoc/2LZ8rYvXYMgvHAgaBRzkbV3Zq7ak=;
        b=AuR0CnaXsxGZEWfb0b5PYzZlIWAQR0Iv+9ZEu8/h6caOKHlJkfIofD4Pbe+gSUlOzG
         RTkRgG1Vq385zqDAtYPnbsS+pSVDRSiSkSOulaQFG+Fl29+jzjSiGoEBWDXRg08nYNGg
         zWRhb/fevpaIjt/wzYA9XboPlPLSDOF77+nLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=udCAIlmPiQ2KX6Zrgm/avIKSyxNsoI1QKgdgCIPSY5SKJzCrW5mnA9EVoYOfMxjaMX
         zDrQa6A9ODjinvE+0XkVs3Zxaz1odPBtZn48rCiEvWX5rdTWA+cIPaZiJl8ditsgZNk/
         qKoQn17qOlfXF5OtwiPCxGT+D6nxfYJfc3li4=
Received: by 10.223.108.147 with SMTP id f19mr639480fap.68.1290686446587; Thu,
 25 Nov 2010 04:00:46 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Thu, 25 Nov 2010 04:00:46 -0800 (PST)
In-Reply-To: <AANLkTinWtG8dp_CvoH+EWYz4d=D-N0QUiBSrCNwamROo@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162128>

On Thu, Nov 25, 2010 at 11:35, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> On Thu, Nov 25, 2010 at 10:45 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
> <avarab@gmail.com> wrote:

>> Is there anything else than that (the builtin.h includes) that you
>> think needs work?
>
> There was an issue where setting NO_GETTEXT wasn't enough to disable
> internationalization. Has this been fixed?

Do you mean the issue with eval_gettext in git-sh-i18n.sh? I fixed
that issue, but even under NO_GETTEXT=3DYesPlease we'll still pass
things through git-sh-i18n--envsubst. Since I can't just #define
things out under NO_GETTEXT=3DYes like I can in the C code.

Maybe you mean something different that I'm forgetting. But IIRC that
was the only issue.
