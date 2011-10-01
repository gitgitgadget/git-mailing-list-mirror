From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/8] checkout: check for "Previous HEAD" notice in t2020
Date: Sat, 1 Oct 2011 21:02:06 +0200
Message-ID: <CAGdFq_gYBg21mh7xiPdqqKLG8ZDM_Eebj5+E0=U4duQG2BJUDw@mail.gmail.com>
References: <4DF6A8B6.9030301@op5.se> <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk>
 <4E84B89F.4060304@lsrfire.ath.cx> <201109291411.06733.mfick@codeaurora.org>
 <4E8587E8.9070606@lsrfire.ath.cx> <7vfwjeotv1.fsf@alter.siamese.dyndns.org>
 <4E8607B6.2040800@lsrfire.ath.cx> <4E8731AF.2040305@lsrfire.ath.cx> <4E8733FA.6070201@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Oct 01 21:02:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA4po-0006p9-7y
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 21:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755613Ab1JATCs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 15:02:48 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57122 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab1JATCr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2011 15:02:47 -0400
Received: by ywb5 with SMTP id 5so2405159ywb.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 12:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Bvl39uBnGDC/IF3k5DJ5wetCc0CWdKbvwLoOCREygtU=;
        b=hKR8663CT5Y6iK5ipb6kZSYPV6aTRWJaoe/i2Zj8QX4MzgRM+7wZkP4000E0jelSMU
         18aXTchapDSBYbkr7N+0qvAdEZYyedBXJMQNsqbml4snfKAQ7E992xoNXBSm1rdUMWCy
         zB92sXWU6By3G2+8pVzm2Rv79bK+suRac85Ug=
Received: by 10.68.33.164 with SMTP id s4mr46363906pbi.119.1317495766168; Sat,
 01 Oct 2011 12:02:46 -0700 (PDT)
Received: by 10.68.62.3 with HTTP; Sat, 1 Oct 2011 12:02:06 -0700 (PDT)
In-Reply-To: <4E8733FA.6070201@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182570>

Heya,

On Sat, Oct 1, 2011 at 17:38, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.a=
th.cx> wrote:
> If we leave a detached head, exactly one of two things happens: eithe=
r
> checkout warns about it being an orphan or describes it as a courtesy=
=2E
> Test t2020 already checked that the warning is shown as needed. =C2=A0=
This
> patch also checks for the description.

A cover letter would have been nice for such a long series :).

--=20
Cheers,

Sverre Rabbelier
