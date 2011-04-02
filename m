From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Documentation/git-update-index.txt: Remove obsolete note
Date: Sat, 2 Apr 2011 15:52:07 +0700
Message-ID: <BANLkTi=gadRz0XXp2Jd1Jnv7hH4fbnE45Q@mail.gmail.com>
References: <4D9329C5.3060809@elegosoft.com> <AANLkTik3nEE2mtpRVwuQxfoNZd8Ejpgc=T=GS_jEpXsB@mail.gmail.com>
 <7v7hbfj7d6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakob Pfender <jpfender@elegosoft.com>, git@vger.kernel.org,
	torvalds@osdl.org, spearce@spearce.org, johannes.schindelin@gmx.de,
	peff@peff.net, nico@fluxnic.net, barkalow@iabervon.org,
	chriscool@tuxfamily.org, jrnieder@gmail.com, raa.lkml@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 10:52:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5wZa-0002CH-Rj
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 10:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172Ab1DBIwj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Apr 2011 04:52:39 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57315 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803Ab1DBIwh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Apr 2011 04:52:37 -0400
Received: by pzk9 with SMTP id 9so836916pzk.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=eVq7aYCF96olp7fprkZ0Xg3XQlR10I2g8O+orV9GAw0=;
        b=tEIfGbCdp0KKw33cYfY0TKcbtvDE3W2umS6IqbbaSLRTbSvSCZLDEkSexVD7bzg0+b
         NFwQRH4S/s8p4NnLPrutV1ML43986wjyFtP2fyWOw456eRTEMpot0gPgPEPh1L76SlOD
         lDb2/Cn213XRBLaLkkSKqhy9B1Pyfbb006wU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ip/SHwp2Od/Ilr3PWP3ILe1OMAxB2G5tmRz2Ag7G+ghVzR8zJD4ldSFinT5gmM7z1+
         ArVk4eue9JWxtP1KqN5fuaft6CWvmdjtFZltsMBic4eiNvhcwN6m71FW3Pw+feEFYAxN
         1BGzDY76DDxOfI7Ih7PC9V270cicbFyZqs2mo=
Received: by 10.142.142.4 with SMTP id p4mr4234717wfd.43.1301734357074; Sat,
 02 Apr 2011 01:52:37 -0700 (PDT)
Received: by 10.68.54.201 with HTTP; Sat, 2 Apr 2011 01:52:07 -0700 (PDT)
In-Reply-To: <7v7hbfj7d6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170645>

On Fri, Apr 1, 2011 at 4:41 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Wed, Mar 30, 2011 at 8:01 PM, Jakob Pfender <jpfender@elegosoft.c=
om> wrote:
>>> 8dcf39 (Prevent bogus paths from being added to the index) introduc=
ed a
>>> check for files beginning with '.', preventing path names such as
>>> `./file`, `dir/./file` or `dir/../file` from being added. This was
>>> reflected in the man page.
>>>
>>> d089eba (setup: sanitize absolute and funny paths in get_pathspec()=
)
>>> removed this check without reflecting the change in the man page.
>>
>> Sounds good.
>
> When I first read it, however, I thought that the "removal" meant tha=
t the
> rewrite made the code riskier by accepting nonsense, which turns out =
not
> to be what the author meant. =C2=A0It was more like "instead of rejec=
ting,
> accept these paths after normalizing", no?
>

Yes it's more like that.
--=20
Duy
