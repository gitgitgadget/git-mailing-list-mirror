From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] t3700: note a .gitignore matching fault
Date: Wed, 4 May 2011 06:43:36 +0700
Message-ID: <BANLkTi=ZL5aPnPMXai==gyjYRT_LHovisA@mail.gmail.com>
References: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
 <1304340923-15927-1-git-send-email-pclouds@gmail.com> <4DBEC766.8020008@viscovery.net>
 <BANLkTik=GYXUOeo3hA5yyXfOuBydT40koA@mail.gmail.com> <7voc3jis61.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 01:44:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHPGI-0001xD-T7
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 01:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104Ab1ECXoJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 19:44:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37757 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab1ECXoI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 19:44:08 -0400
Received: by bwz15 with SMTP id 15so546908bwz.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 16:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=WuFd98SoAclagMYqj6TsgVCIZEF8uxD/NKyXUt1H+A0=;
        b=RR1UUtyitHB5Y/sykQfhm1GwntZ3MxfF+GOtuHZhnXszeUBpH8QikTBcZZ+snglaLL
         c4qYVduH4WXc+ZKjt/bpB6r7XROpkR11UCbgMYYE5HSwNAqftynWRyVOWXoSGDUiweI0
         gyR1BxYLlq/3fLHqjEw/a/O5mIvRpADgId5YA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=G+RVZLkUoJl81kGWAE1Avwq9jEhCIkHNiWxShQIn71UVR75tPvsGAijbncq5CcGMxV
         T3p1DrHzS97VWdFVLKjVQppRmIEpZ5O79/othyKFmMeLrOMsBRTSBG+I97t4/fDjlJ21
         LBzrBn66LDH/bLb+Gf872zgWrbZ4phTzffCDc=
Received: by 10.204.20.142 with SMTP id f14mr424959bkb.155.1304466246124; Tue,
 03 May 2011 16:44:06 -0700 (PDT)
Received: by 10.204.53.13 with HTTP; Tue, 3 May 2011 16:43:36 -0700 (PDT)
In-Reply-To: <7voc3jis61.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172704>

On Wed, May 4, 2011 at 12:56 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> ... The point is make it
>> configurable with sane default. It's up to users to decide how they
>> want to pay.
>
> Hmm, I am confused.
>
> Isn't that what we already have? =C2=A0If you want to pay, you just d=
o not
> define a do-not-descend ignore entry at such a location so close to t=
he
> root of the working tree.

Yes. But git still silently ignores some rules in the .gitignore.
There's another case when you rather update $GIT_DIR/info/exclude than
 .gitignore in the tree (import tree for example). Same trap again.
--=20
Duy
