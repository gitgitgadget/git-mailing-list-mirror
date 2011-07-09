From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Do not trust PWD blindly
Date: Sat, 9 Jul 2011 22:06:49 +0200
Message-ID: <CAHGBnuO_p8WfBowiBw=4t8432nc0UvpNS_emWZEYBn1zNY+c5Q@mail.gmail.com>
References: <CABNJ2GKgzXGDq9FhKcVP380bs=rEKqYdrOaCb+A99_TBm7A4_A@mail.gmail.com>
	<alpine.DEB.1.00.1107091935210.1985@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@gmail.com>, gitster@pobox.com, j6t@kdbg.org,
	msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 09 22:07:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qfdnu-0007yM-QH
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jul 2011 22:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544Ab1GIUGv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jul 2011 16:06:51 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44864 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384Ab1GIUGu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jul 2011 16:06:50 -0400
Received: by qwk3 with SMTP id 3so1382088qwk.19
        for <git@vger.kernel.org>; Sat, 09 Jul 2011 13:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=iOebZRHc+7/+iZH7fWmhBCdLk++ki+qQEbO1SO5/MXA=;
        b=ZwyW+umJBb8jOVLim3GtePbVdvulVsEz1YRwpXH5UtIgy2qOKrZj8g6FMhN78ciGuW
         po3tup9ynNq8OKjDEisntFtx/luRUW38YNSzHYsAg38s2upxg6ajc8uABdNd7GLdJcse
         fSwNO0j6LeY1jLT4ZUd7Oa1AhSfxMZzoVR5Lg=
Received: by 10.229.7.3 with SMTP id b3mr2450307qcb.194.1310242009686; Sat, 09
 Jul 2011 13:06:49 -0700 (PDT)
Received: by 10.229.215.8 with HTTP; Sat, 9 Jul 2011 13:06:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1107091935210.1985@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176820>

On Sat, Jul 9, 2011 at 19:38, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> =C2=A0 =C2=A0 =C2=A0 =C2=A0On Fri, 8 Jul 2011, Pat Thoyts wrote:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0> ! t5516-fetch-push =C2=A0 =C2=A0 =C2=A0(=
60 receive.denyCurrentBranch =3D updateInstead)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0This patch fixes that.

I can confirm that the patch fixes test 5516 on Windows. Thanks Dscho!

--=20
Sebastian Schuberth
