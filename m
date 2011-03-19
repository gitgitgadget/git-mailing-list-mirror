From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] git-init.txt: move description section up
Date: Sat, 19 Mar 2011 23:13:10 +0700
Message-ID: <AANLkTi=DtKbpF9YdKJJij0PSpRnneDsthk7Pv5NH_x+N@mail.gmail.com>
References: <1300547816-4768-1-git-send-email-pclouds@gmail.com> <vpqbp17hzoz.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Mar 19 17:13:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0ymf-0003Gu-H5
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 17:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab1CSQNm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 12:13:42 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56232 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473Ab1CSQNk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 12:13:40 -0400
Received: by gyf1 with SMTP id 1so1926001gyf.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=3cdinrkWUi/hU0tmkSQYSSO8Rn0jj7ZnT1reYrGO3zc=;
        b=iXAghtqUW28y5RfyOZtkDh9r0VpOOvOmnfwDS4mt91jHa/0E44yfuu4qoHXRIoavm1
         kjF8UGj0duRFh//bn7cqsYRdcbPRErQaYVxc+3q69UpOUYxd8RmrCiV6ltv3oqpzddIg
         QdP58aYAcMvO+mRDvWjPdiOhnbHTGrrrgsETo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GWLaUGZ3jQP2i5jjupHN02fL1z2ZQ/ej+j3cSUsmzeLbTamDxePrzw4Z91MoYo+OfP
         vAGmqmHNiKj02UrgoyhLyYBAycalhUZJYKHkGBax3W5J1um8vGnA52NG2pKFjbhH8Z+v
         F+v7jBM4X8c8AygEzyktKyr4FI3A4AQlzXROk=
Received: by 10.150.169.3 with SMTP id r3mr2420184ybe.331.1300551220141; Sat,
 19 Mar 2011 09:13:40 -0700 (PDT)
Received: by 10.150.220.14 with HTTP; Sat, 19 Mar 2011 09:13:10 -0700 (PDT)
In-Reply-To: <vpqbp17hzoz.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169444>

2011/3/19 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-d=
b.txt
> index 2c4c716..b2b959e 100644
> --- a/Documentation/git-init-db.txt
> +++ b/Documentation/git-init-db.txt
> @@ -3,13 +3,7 @@ git-init-db(1)
>
> =C2=A0NAME
> =C2=A0----
> -git-init-db - Creates an empty git repository
> -
> -
> -SYNOPSIS
> ---------
> -'git init-db' [-q | --quiet] [--bare] [--template=3D<template_direct=
ory>] [--shared[=3D<permissions>]]
> -
> +git-init-db - Deprecated alias for linkgit:git-init[1]

You should remove DESCRIPTION section too.
--=20
Duy
