From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v6] Add log.abbrevCommit config variable
Date: Wed, 18 May 2011 13:51:06 -0400
Message-ID: <BANLkTimiWRAz-RNEbFgip2DQrfsjcJTFLQ@mail.gmail.com>
References: <1305740910-26983-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 19:51:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMktt-00034j-8d
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 19:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882Ab1ERRvI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2011 13:51:08 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44434 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab1ERRvH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 13:51:07 -0400
Received: by pwi15 with SMTP id 15so853474pwi.19
        for <git@vger.kernel.org>; Wed, 18 May 2011 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=a840B2D1Y/kUs/gBZwSPASGrHxzOM1UE49YgNC7Nw0o=;
        b=qbDYgSVGQf32UnktwqYOVAdNwCzLuF+Puljr5gZrBI8I4KyODakvC896FSqkYzPvt0
         Idd+AEb/oGqQGGuZnCBI63Ay9Bhvjp38gV9ZunS/oxoO6Yc5cJvUqok39DAre8NXz+nD
         h+Ek+rt9DYmMZ2yhrYOewz5LqSu/fKZcm7dRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=HJPCV44iAuNuDyvKEhDJzeaLLfj+OoE7zaPv9I9AbNs2adTOxwv59i1c0lXf/LelOw
         Jq7lXguUmkZQmOCX9rSNMhRkqzSyweSd8RU3I/OfGvUTUc91s6Zj4faidSPdKLmjC1A+
         lY7gnTfpq3j4+qagBfqFNL96T8HLhkREiFxig=
Received: by 10.143.28.6 with SMTP id f6mr1329846wfj.169.1305741066916; Wed,
 18 May 2011 10:51:06 -0700 (PDT)
Received: by 10.142.200.15 with HTTP; Wed, 18 May 2011 10:51:06 -0700 (PDT)
In-Reply-To: <1305740910-26983-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173890>

On Wed, May 18, 2011 at 1:48 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> + =C2=A0 =C2=A0 =C2=A0 git reflog >actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect.reflog.abbrev actual.reflog
> + =C2=A0 =C2=A0 =C2=A0 git reflog --no-abbrev-commit >actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect.reflog.full actual

Grr, why don't I see these typos when I proof them before I send?

j.
