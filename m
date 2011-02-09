From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 5/7] help: reuse struct column_layout
Date: Wed, 9 Feb 2011 18:21:33 +0700
Message-ID: <AANLkTinTvTdng2MpVmPfF3O1c08mFEEr1x_pv1_1unBX@mail.gmail.com>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
 <1297178541-31124-6-git-send-email-pclouds@gmail.com> <20110209073953.GB2135@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 12:22:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn87h-0003FC-7U
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 12:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab1BILWH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 06:22:07 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54712 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab1BILWF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 06:22:05 -0500
Received: by wwa36 with SMTP id 36so56330wwa.1
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 03:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=6Dz4mbpS9boN3uSomlLikqvTFD0TnSvgxikxHaULBpg=;
        b=PuibRoD0NiyRDJruk5YsTNeTZojJeTLgpiWKA7MbCBgWf+NghnbOw/klRSzzNDYesX
         k5lDtdhKRCpDMpNdQRzgpCfs3MJBjSCwu+LPqt3sn0tkv3Ld0CCiB4yUHEKDbQQErEsZ
         q+7DdhpSADWKf8Q0ztX6bfh8C7yWcAFHNjWgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xuKlcUvyQdOsEZ1Sf7gZJSNwSWsCKiRAgiDiDt3iMwu28OSEsMyu6rJNsvqs/hozCa
         K0uaIZMIguxrDGo8V5WZ1bpgjOV08ESyMBs7XISpstSHYaMRewjZZRSYdlD9u9S7wyro
         mY+KcF8gQr4VfjrCNmv7/FCoR4RDTvJ7UYMNY=
Received: by 10.216.89.71 with SMTP id b49mr17008428wef.28.1297250524266; Wed,
 09 Feb 2011 03:22:04 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Wed, 9 Feb 2011 03:21:33 -0800 (PST)
In-Reply-To: <20110209073953.GB2135@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166403>

2011/2/9 Jonathan Nieder <jrnieder@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> [...]
>> +++ b/help.c
>> @@ -72,29 +73,17 @@ void exclude_cmds(struct cmdnames *cmds, struct =
cmdnames *excludes)
> [...]
>> + =C2=A0 =C2=A0 struct column_layout c;
>> + =C2=A0 =C2=A0 int i;
>> +
>> + =C2=A0 =C2=A0 memset(&c, 0, sizeof(c));
>
> Might be nice to have a COLUMN_LAYOUT_INIT, I suppose.
>
> Looks sane. =C2=A0What output changes would be noticeable, if any?

Two spaces between column instead of one. Will fix.
--=20
Duy
