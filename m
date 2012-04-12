From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Parallel refactoring and git merge nightmare
Date: Thu, 12 Apr 2012 12:03:17 -0400
Message-ID: <CAPZPVFbBPXzTaY5rAqs8NMWMaepo_pmB6-skDL-=VbOHzUz55A@mail.gmail.com>
References: <1334160803.74554.YahooMailNeo@web160603.mail.bf1.yahoo.com>
	<CAJDDKr6v6uPLoAQ96fP7JM5F0_WHqfbaD=QKyfrWPWd2St7tKQ@mail.gmail.com>
	<1334208237.82681.YahooMailNeo@web160606.mail.bf1.yahoo.com>
	<CAFfmPPMbr-db+OnTwK-ry+wGQSEeunsD+QrmAVS2fzDH+hGnbg@mail.gmail.com>
	<1334238768.18499.YahooMailNeo@web160601.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Pap_L=C3=B4rinc?= <paplorinc@yahoo.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 18:03:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIMUW-0000FJ-FA
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 18:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934448Ab2DLQDU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 12:03:20 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:60133 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932965Ab2DLQDS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 12:03:18 -0400
Received: by lahj13 with SMTP id j13so1686347lah.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=ydrxIPah5pQn8pzktsdaxSE/bBDu2RDLFjvMnFzqQqc=;
        b=uSsa1Q/bt0O+IhosffGVCgTJo1nIK/HwSiN2M1fXFU/4LT33IA5nFigaawYa9WWlSc
         oSOtl4jsccak55IHr4XKmMTl1CcRPF0J7PtOJ9M/LN5uk93PaA/BujwPSiMBNE+DvANN
         qSS9t3t3q+ni9fLbpey+8ETdLt35iZocQ4Vt/la0S+ZAryyHQrEDI9Jfe0SI2SMZCpv0
         3MVJGNedpNtrNuDffgNwi8JAKo24V6X5ZxA8rlUMyPuJaajxDMWTC7bLR5IViLeco6KG
         8tDekRdiQyG4ExYWEuF4InadtlNWZCYB/Ym5AuP6vx/8THKhms0cAHlpb5REINfEreHv
         8CvA==
Received: by 10.152.105.241 with SMTP id gp17mr2922317lab.21.1334246597320;
 Thu, 12 Apr 2012 09:03:17 -0700 (PDT)
Received: by 10.112.20.202 with HTTP; Thu, 12 Apr 2012 09:03:17 -0700 (PDT)
In-Reply-To: <1334238768.18499.YahooMailNeo@web160601.mail.bf1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195343>

On Thu, Apr 12, 2012 at 9:52 AM, Pap L=C3=B4rinc <paplorinc@yahoo.com> =
wrote:
> Thank you all for the answers! :)
>
>
> I have already set the rename limit to 0, and upon committing and fet=
ching the renames are calculated and found.
>
>
> The commands are (I use tortoise git now, but tried the console and o=
ther GUIs, as I said in my first post) "git svn fetch" and "git merge r=
emoteBranch".
> I figured now, that this was the problem, I should have used rebase i=
nstead of merge (I still don't understand why merge doesn't work, but r=
ebase and conflict resolution with a GUI (where I can resolve more file=
s at once) seems acceptable). Thanks David! :)
>
> L=C5=91rinc
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml


As an addition I would recommend to be a little more strict about how
refactoring is committed:
I.e. split up the repackaging and actual code refactoring - as a rule
we are committing renames separately from other changes or with
minimal changes (like package change for java classes)
Then i would use the rebase if there is some parallel work as suggested=
 above

Hope that helps,
Eugene
