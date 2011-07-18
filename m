From: Mike Shal <marfey@gmail.com>
Subject: Re: git show-branch --topics and merge commits
Date: Mon, 18 Jul 2011 19:34:59 -0400
Message-ID: <CA+6x0LUD7yQ3DRTvJfP3Y85QPgA1aH40ssiS5+yXu8uDtZxhdA@mail.gmail.com>
References: <CA+6x0LWXz-SpnZjdiV3UKJzUz3+0LiMOsbZHTn2gJ+v6bPGndA@mail.gmail.com>
	<7v8vrwl46q.fsf@alter.siamese.dyndns.org>
	<CA+6x0LXHKZgvW4_hWz8qrWQshqxB3pQ-=08itqnV5smA_NCrBA@mail.gmail.com>
	<7v4o2jlalx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 19 01:35:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixLJ-00028V-03
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933Ab1GRXfA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 19:35:00 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35621 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab1GRXfA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 19:35:00 -0400
Received: by vws1 with SMTP id 1so2537209vws.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 16:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=S5i1L3MYmihnXRv4OZruwX8u0f8nUG5HOJ4XoKmPoKA=;
        b=I4RtLOOtpxqGItrgZZ8YolCnfmLWIbHvPhy2cuLcMKKrSUm/+qQenIvSdWCfsnYHes
         E4Os6KqclYv92t1oPwsxiH2TnLCXPHaADDQDZeDxQkJC3X7VzPwBlUUtjaF2e7MjLTeN
         kac+IdxHE0LXq2NrlZHPcna/aag8kLgxq6nT0=
Received: by 10.52.174.49 with SMTP id bp17mr880874vdc.243.1311032099514; Mon,
 18 Jul 2011 16:34:59 -0700 (PDT)
Received: by 10.52.188.102 with HTTP; Mon, 18 Jul 2011 16:34:59 -0700 (PDT)
In-Reply-To: <7v4o2jlalx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177413>

On Mon, Jul 18, 2011 at 2:14 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Note that show-branch was invented way before the log family of comma=
nds
> (which rev-list is a member of) learned --left-right/--boundary/--gra=
ph
> options, and I personally think its graphical output mode outlived it=
s
> usefulness as a stopgap measure. =A0As its "merge-base" and "independ=
ent"
> modes have also been made redundant (see "git merge-base" for two opt=
ions
> to mimic their behaviour), we may want to start thinking about deprec=
ating
> the command, and the first step perhaps would be to replace its menti=
on
> from the first part of the Everyday Git document with something more
> appropriate such as "git log".

Hmm I had no idea 'git log' was so powerful. I'll be using that from
now on instead of show-branch --topics :)

Thanks for your detailed response,
-Mike
