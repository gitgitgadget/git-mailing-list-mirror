From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCHv2] doc: Clarify that "cherry-pick -x" does not use "git notes"
Date: Sat, 16 Apr 2011 18:55:41 +0200
Message-ID: <BANLkTimX6QQB8uASjNw4azG4Gdchc-S=rQ@mail.gmail.com>
References: <4DA7F73B.9050007@gmail.com>
	<7v7have8wo.fsf@alter.siamese.dyndns.org>
	<4DA8862F.5070102@gmail.com>
	<BANLkTi=HecmdGbEX5inqUi4FZ5Ty+L1Ybg@mail.gmail.com>
	<BANLkTi=jr0hkmBUGj7tHURSj5XiJkyyQqg@mail.gmail.com>
	<7vk4eub1g9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 18:55:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB8mi-0001Lw-4B
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 18:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575Ab1DPQzn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Apr 2011 12:55:43 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33620 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab1DPQzl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2011 12:55:41 -0400
Received: by qwk3 with SMTP id 3so1850249qwk.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 09:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3U6dIzTguJeE0k1QdT86sFhChpmHnPFaQfU2LAXs7z8=;
        b=fKc6uQSwzfZ0ckGXk8Ry25pgIGU1a20fhgwdPBSWfbt1DV3LxsrYVakceG6g7FTOHd
         oo0eA8WQEZGflogkdNE3vBRPPOc9hQlsoUrGbPOtWG9sG+0mkRv4X+y5GXWW2mN49tMJ
         2EUsbryFEeChGDYAGZapFR0iXjpgx0K14z+m4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sgbOHO2lJ0/dX6Ua1/Ft8Csnlg/xAknNeJ+OlHp46BfcwGyT7y2KEX9rUtzzi5YW17
         tWE8FM0VrxAY7owJ11nl2uxwAIAhP2oPIn1WdKH+jevbug0thPAwFMgY9JbuPB7vR6eT
         tu9UZYpcwxpoOMOGU9maBLQcCMowpCE3lthiw=
Received: by 10.229.30.3 with SMTP id s3mr2182666qcc.253.1302972941153; Sat,
 16 Apr 2011 09:55:41 -0700 (PDT)
Received: by 10.229.241.17 with HTTP; Sat, 16 Apr 2011 09:55:41 -0700 (PDT)
In-Reply-To: <7vk4eub1g9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171681>

On Sat, Apr 16, 2011 at 18:33, Junio C Hamano <gitster@pobox.com> wrote=
:

>> How can this be not true anymore? If you get a conflict while pickin=
g,
>> you're asked to resolve the conflict and then commit via "git commit
>> -c <picked_sha1>". Doing so will *not* give you the mentioned "(cher=
ry
>> picked from commit ...)" line.
>
> I suspect Jay had the recent CHERRY_PICK_HEAD series that lets you om=
it
> saying "-c <picked>" in mind. =C2=A0We should not leave the cherry-pi=
cked from
> in such a case, I think, but the new code may be buggy.

Thanks for explaining. I keep my patchv2 as-is in this case.

--=20
Sebastian Schuberth
