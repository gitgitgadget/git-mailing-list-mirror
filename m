From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 0/5] bisect: Add support for a --no-checkout option.
Date: Sat, 30 Jul 2011 18:30:55 +1000
Message-ID: <CAH3AnrpgERC+BH6k3o4AHScpxDDCyXQRKw45pdH_OiuxPQb-OA@mail.gmail.com>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: j6t@kdbg.org, gitster@pobox.com, jnareb@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 10:31:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn4wo-000322-Hc
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 10:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab1G3Ia6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jul 2011 04:30:58 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56304 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab1G3Ia4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2011 04:30:56 -0400
Received: by vws1 with SMTP id 1so3459616vws.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 01:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bkyyWkHZgNOFArWgb0tAEkvEbrBoE4p7VT4JMkJfqLs=;
        b=IjqodC5eOeZQT/aSaMhcDqpUmzPCJoPMNnZ++018iRBDgpqqihc1y7rPqSWIVi9wNa
         teLHb15FD2O4d1/WWfat62lY9w3qKR1Lj32l26bid8byl29jYLGFOrNfsyHu5X3bjQ5H
         0TRH4whQ8BdfDQb3t7u87eCLUy+sCelZiyyBs=
Received: by 10.52.97.1 with SMTP id dw1mr1311222vdb.307.1312014655867; Sat,
 30 Jul 2011 01:30:55 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Sat, 30 Jul 2011 01:30:55 -0700 (PDT)
In-Reply-To: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178186>

On Sat, Jul 30, 2011 at 6:28 PM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> For some bisection tasks, checking out the commit at each stage of th=
e bisection process is unecessary or undesirable.
>
> This series adds support for a --no-checkout[=3D<ref>] option to git-=
bisect.
>
> If specified, this option causes git-bisect to update the specified r=
eference at each stage of the bisection process instead of checking out=
 the commit at that point. If <ref> is not specified, HEAD is assumed.
>
> One application of this option is to find, within a partially damaged=
 repository, the earliest commit such that the graph of commits, trees =
and blobs reachable from the parents of that commit is completely reach=
able.
>
> For example:
>
> =C2=A0 =C2=A0git bisect start HEAD <known-good-commit> [ <damaged-or-=
missing-commit> ... ]

Sorry, this example should include --no-checkout.

    git bisect start --no-checkout HEAD <known-good-commit> [
<damaged-or-missing-commit> ... ]

Example in documentation is correct.

jon.
