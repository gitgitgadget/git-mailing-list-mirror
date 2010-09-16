From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Thu, 16 Sep 2010 11:51:15 +0000
Message-ID: <AANLkTi=D1+DQ=JXBrWmf142dqTPhQbSa0hw=j8TLrGVX@mail.gmail.com>
References: <20100915093313.44396t6yr62ixccg@webmail.tu-harburg.de>
	<20100916125751.163d8691@jk.gs>
	<AANLkTikvW=YY2X9VR8oS2pk3fs9KFkQ_O7m=zOEN4nEk@mail.gmail.com>
	<4C91FF90.6050902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>, trast@student.ethz.ch,
	git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 16 13:51:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwCzq-0007UF-4u
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 13:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434Ab0IPLvR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 07:51:17 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38158 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806Ab0IPLvQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 07:51:16 -0400
Received: by gyd8 with SMTP id 8so349070gyd.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tCjo2ikkjKtFHIWlMVnKcMLsmB+5r5XZb5yFw8Jo5E0=;
        b=lXiWaM1Tmg/YN4jzBqs4AdQV/sNd2ff5pAj7cqHXuEsJmXu050RkEenZSjoilxmIUX
         /cIKsN41lZlKl5SnBPKfdkRwporc5xkkOhr0i0gCK8Q6neq+siZuLgy85KSsCSDGJD9x
         iJ94zglqy7dL795VYFM5hSwCCUk3m1b1Y+Rh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ffNCgZDU3mmKTef67U5Vn1zKxb3qcpl+HMKe2CrTRjDz/t/Cz47BmVINcE2x49Dhy9
         Wgtv7E3ILYtVfnwjM1z9PIg21ZyXqJDNL4vGd0AtnAieQAkyJopxdckab0aS3pFt6eKG
         NPUjyaxToupZw7Kh3Vcoz/TpADV1iofzIpD1o=
Received: by 10.100.207.7 with SMTP id e7mr3550053ang.52.1284637875413; Thu,
 16 Sep 2010 04:51:15 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 16 Sep 2010 04:51:15 -0700 (PDT)
In-Reply-To: <4C91FF90.6050902@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156324>

On Thu, Sep 16, 2010 at 11:29, Jens Lehmann <Jens.Lehmann@web.de> wrote=
:
> Am 16.09.2010 13:09, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> On Thu, Sep 16, 2010 at 10:57, Jan Kr=C3=BCger <jk@jk.gs> wrote:
>>
>>> My main reason for not translating this one is that we have a comma=
nd
>>> called "branch" and since people need to learn what it means anyway=
,
>>> and we're certainly not going to change the command names in differ=
ent
>>> languages [...] "Markierung" doesn't come close at all to describin=
g the same
>>> concept. Conflicts markers are "Markierungen"; tags are not.
>>> The command name reasoning applies here, too.
>>
>> FWIW we could translate the command names if we wanted to, but wheth=
er
>> to do that or not is something we'll have to look at in due time.
>
> Are you seriously thinking about translating the "git branch" command
> into "git zweig"???

I am. I don't think we should do it, I'm just saying we can.

    char *allowed_names[] =3D { "branch", _("branch"), NULL };

Right now we only talk to the user in their native language, but we
could extend that so that the user can also talk to us.

> Locale-specific batch files should be real fun ...

We'd only translate the porcelain commands, and document that using
the translated versions anywhere but interactively on the command-line
is a bad idea.

But to re-iterate, I'm not saying we should do it, just that it would
be easy to add it if we want to, and it would presumably be easier to
use a translated git in if we did this.
