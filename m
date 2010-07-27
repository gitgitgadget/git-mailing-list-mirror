From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 2/2] Allow "git log -S string" as synonym for "git log 
	-Sstring".
Date: Tue, 27 Jul 2010 01:42:03 -0500
Message-ID: <AANLkTik-5FVwrFz+5hzqT4_u7MLOPg352+G3XoDcgdKs@mail.gmail.com>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr> 
	<1280168078-31147-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jul 27 08:42:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oddrz-00020Q-Aa
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 08:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab0G0Gm0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 02:42:26 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49687 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab0G0GmZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 02:42:25 -0400
Received: by yxg6 with SMTP id 6so369041yxg.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 23:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=CRiHdWRFLIlkDGMuOLbE8K+1Ah0eeoeAdLKFajsWuDM=;
        b=AEq4BDk+A7J6GPNS7b+oqpJ2qPk0AJHPY37ve41dgNMsOcdL4FIR5tMJd5QbH3kSen
         5x7qO2Y6YYGHhjAm0ZmghnfCEqr/5RfTICAMzpmsV2ZvgBksOKVnpFR1kHPSkjW0Wdjp
         DDzvtV93Hx0Ur3l4WOZcU8/zHVpsEx+sjMWic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IKsswrlQ3EYrkgyR1dsI+kaohuuqiD1aDR4tHOxfL3dxpWIO8EPNsznTbymcn/Q6/X
         LAqd+/sLkQ2J1cFYf4VgAl9gVWpcDhl4S8PWMhrMju5FiwpVCglC8jQ6x+iBu4UO8CfP
         oZKKJQWb1dpM1B7rDzyi/zo/VE+DqikPxeC8g=
Received: by 10.151.132.9 with SMTP id j9mr2623449ybn.403.1280212944338; Mon, 
	26 Jul 2010 23:42:24 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Mon, 26 Jul 2010 23:42:03 -0700 (PDT)
In-Reply-To: <1280168078-31147-3-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151914>

Heya,

On Mon, Jul 26, 2010 at 13:14, Matthieu Moy <Matthieu.Moy@imag.fr> wrot=
e:
>

> + =C2=A0 =C2=A0 =C2=A0 else if (!strcmp(arg, "-S")) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options->pickaxe =3D=
 optarg;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 2;
> + =C2=A0 =C2=A0 =C2=A0 }

TYVM.

--=20
Cheers,

Sverre Rabbelier
