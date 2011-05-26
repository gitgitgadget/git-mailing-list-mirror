From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] sh-18n: quell "unused variable" warning
Date: Thu, 26 May 2011 15:46:00 +0200
Message-ID: <BANLkTikmNxkCyAK1C4AWYVE-mjGYxKSLmQ@mail.gmail.com>
References: <62c2e1619edcb37c0411f29a34b6bc10e3899a97.1306317312.git.git@drmicha.warpmail.net>
	<BANLkTi=Mgd7=eriOsz1phDBJ25Com2Y=mQ@mail.gmail.com>
	<4DDE4F92.7030301@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 26 15:46:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPat8-00018j-FN
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 15:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965Ab1EZNqE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 09:46:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63598 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab1EZNqC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2011 09:46:02 -0400
Received: by fxm17 with SMTP id 17so689427fxm.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wz4QRAEq2iTfNzuvT2IHV50dOcX2R7dNLs8ddSbZGNQ=;
        b=taT0SoClYv+p3LkbM6o7ggM6VQrritcx1vtwj3yGZ/XIgXz+CDuyVwtQ5Cj6g2VPC0
         F6YblLScc2oijCqy9Ln5V9tNBtp3AJd8agHfF6TXwyZsY8o9+/eYo9BTfvWyQB7VZI+T
         hHxrsL7ebLuL29GBWy2e/jZLQA/bXuTGkJClc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h6QzkUSaGhxR/mLqo4JUn12UzsvsvS61MmAxzUO4EAcidFy+49c0ji6ilqyxLWRgUd
         2Sxsf8eQfnkTYKlqcwzzJ1vGbPP0PWUXwV72R4sckTy/qDseoU25P7h4W0LtaliKOiL2
         G570WElAYUTv1tEQLCI3dp9i7I6aKtev4nOuU=
Received: by 10.223.73.139 with SMTP id q11mr975851faj.56.1306417560866; Thu,
 26 May 2011 06:46:00 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Thu, 26 May 2011 06:46:00 -0700 (PDT)
In-Reply-To: <4DDE4F92.7030301@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174507>

On Thu, May 26, 2011 at 15:03, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 26.05.2011=
 01:33:
>> On Wed, May 25, 2011 at 11:55, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>
>> I suppose it was inevitable that we'd end up maintaining this since
>> upstream only maintains the GPLv3 version now.
>>
>>> =C2=A0 /* Default values for command line options. =C2=A0*/
>>> - =C2=A0unsigned short int show_variables =3D 0;
>>> + =C2=A0/* unsigned short int show_variables =3D 0; */
>>
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 show_variables =3D 1;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* show_variables =3D 1; */
>>
>> Can we just remove these lines instead of commenting them out?
>
> Sure, I just didn't know what is more convenient for the maintainer. =
I
> noticed a few comments in there already but have not compared with
> upstream. Resend necessary?

No it's fine.

But I/we are the upstream for this program now, since GNU only
maintains the GPLv3 version.

We could just use that actually, since this is a stand-alone
program. Or do we have intrinsic objections to GPLv3 code in our
source tree?
