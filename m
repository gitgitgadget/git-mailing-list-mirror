From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/4] git-sh-i18n--envsubst: our own envsubst(1) for eval_gettext()
Date: Mon, 9 May 2011 09:52:09 +0200
Message-ID: <BANLkTino5PpXY8eD+T3Ki+2Xn1MLjZojTQ@mail.gmail.com>
References: <1304856659-10672-1-git-send-email-avarab@gmail.com>
	<1304856659-10672-2-git-send-email-avarab@gmail.com>
	<7v1v09un8y.fsf@alter.siamese.dyndns.org>
	<BANLkTikSvU4haNpRmPq8o2P0yB1Y3t0Ahg@mail.gmail.com>
	<7vsjsor29t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 09:52:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJLGK-0000au-1L
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 09:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab1EIHwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 03:52:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46974 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab1EIHwK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 03:52:10 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so3415514fxm.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aXdBOfEZz9P5STR3a4b1qcD4VghPPaIFhpmoDytOYfA=;
        b=Eqx90RAZAI0ZiHlpkeqjzOiBslERyHqE6vHym9inELKeUN4hQU7ieovtuEq2tR1rTb
         VWZzjzYcWHnTjmFYwEU17DE7XyE0n3vdcGheD248z2y/QljpugGQqPAPHe3hcffvnY9K
         zP1TvvQmY9WQKI7265nkCP50MIi6k/MQtJj6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PUHNJzV1samcWH7qbf17A3kG8x/RfTpiYdKNr04a4MhnqHJUzbjkR18lJxInu1WW8c
         Bfm1FvPS4hM0oTsOQs7vBAPS8rl0HIDQGi4OGtmrYDmDosKdR2s2BTKqSNJZxCQS6VkC
         zHcFxZ0/Vd4DbiVzoDtfOxBAYT/IgGNcBbFUk=
Received: by 10.223.161.194 with SMTP id s2mr3321146fax.143.1304927529435;
 Mon, 09 May 2011 00:52:09 -0700 (PDT)
Received: by 10.223.105.9 with HTTP; Mon, 9 May 2011 00:52:09 -0700 (PDT)
In-Reply-To: <7vsjsor29t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173204>

On Mon, May 9, 2011 at 05:17, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Or are we sure that this can't work in POSIX (or non-POSIX shells)?
>
> You need to implement the same logic to tokenize enough to understand=
 the
> expansion the shell does inside dq. =C2=A0Yes, shell is general progr=
amming
> language and you can theoretically implement it, but would the result=
 be a
> practical solution? =C2=A0I doubt it.

I'll write a better commit message and re-send this soon (after some
other comments have trickled in).
