From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: rebasing branch with reverted patches
Date: Tue, 19 Apr 2011 12:21:45 +0200
Message-ID: <BANLkTim9vKpp6=AwSG9pkWZrw9YKCuFS9w@mail.gmail.com>
References: <BANLkTim5mf6okFN8V5V+B=Ns1JORD47a5A@mail.gmail.com>
	<4DAD4B0F.9030908@drmicha.warpmail.net>
	<BANLkTimbSes-B8zK2a2t1Jp1v+29HdNvqw@mail.gmail.com>
	<BANLkTim_QNFhChme=nxGf1_Dw8LedTS3Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Apr 19 12:22:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC84F-0003uD-Gy
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 12:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab1DSKVt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2011 06:21:49 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:38028 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768Ab1DSKVq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2011 06:21:46 -0400
Received: by pxi2 with SMTP id 2so4381870pxi.10
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 03:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JyBRZQtGx3ZMMN01NVEko3Uq1dhWuWX+dHHDdvYA9RE=;
        b=mWe5iw4lhgezNM3qC0Ktk+nWAJI3upDqV60y7v33r+5NHxt7LmxlhKztpnhU5UIoFX
         QEhpPV/GLiPMHOzAeHbmq5/llYR8o+pzUxFXYpu9Ct+G5KekwMwvRuB+so3AL5BDuCGG
         O1T8ZJaa9yI/cDgTF4U83n7B1vGsadB4B8SZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R2dSZ743iKgn02FN2qKB5ahNl3LO29w+XeDJ5Qa7GK/VZxGlGLkIIYbRvQ30htvdw8
         mm5laYR86l46kueOG+qridI3ZjELKLnGhr4q6zZawaXrginsPkCa9RyvG02uHpYJMFyQ
         8SpGs+0xuspBRlxE34hyTX3mf4HrMg6mcVZ6c=
Received: by 10.143.25.22 with SMTP id c22mr3291474wfj.267.1303208505778; Tue,
 19 Apr 2011 03:21:45 -0700 (PDT)
Received: by 10.143.18.11 with HTTP; Tue, 19 Apr 2011 03:21:45 -0700 (PDT)
In-Reply-To: <BANLkTim_QNFhChme=nxGf1_Dw8LedTS3Ag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171790>

Hello,

On Tue, Apr 19, 2011 at 11:39 AM, Santi B=E9jar <santi@agolina.net> wro=
te:
>
> You can also change the A' commit title to "fixup! original_title"
> while reverting (there is no --fixup argument like "git commit" has),
> then git rebase -i would reorder the todo file for you.

Interesting I wasn't aware of --autosquash option, thanks.

This is almost what I was asking for actually, the only part which is
missing is the fact that git-rebase detect the "Revert: " magic
string, check that the revert is sane (by comparing the diff of the
revert with the diff of the original commit) and do the same as
"fixup!" would do without the confusion of the resulting empty commit.

Thanks
--=20
=46rancis
