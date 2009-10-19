From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use "--no-" prefix to switch off some of checkout 
	dwimmery
Date: Mon, 19 Oct 2009 08:07:37 +0200
Message-ID: <81b0412b0910182307n53b4a51cvaa14829ea8b40207@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
	 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
	 <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
	 <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
	 <7v7huspjg0.fsf@alter.siamese.dyndns.org>
	 <20091018210222.GA5371@blimp.localdomain>
	 <7vzl7omi5z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 08:09:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzlQc-0008Dw-Fx
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 08:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbZJSGHf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 02:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbZJSGHf
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 02:07:35 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:40881 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbZJSGHe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 02:07:34 -0400
Received: by fxm18 with SMTP id 18so4630537fxm.37
        for <git@vger.kernel.org>; Sun, 18 Oct 2009 23:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MIzPXwiEkUtPwuVmiqLL0dzOpWO+jnVCvjsH0ZdSaqM=;
        b=ZNGCF1Rvum71x4tAbmCDoAoFipubtEbmc4O9JonR4OXSikS0gbaC/IczSHLC1BdkNA
         kSP/FhuQ/ZIvoilGV5JCrDMP4fAJ5aqocsnj5U5p3BQhiO6Kje/ycni0ZsDVGYhsh3xS
         PDpr8HZLDFpAA8KNm1lXw/RqMWxclgebZAP3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Mk9FmpKYNsnHbPh7Qu7uOZIon2mqpcXpO2CuMdZKvt/35BfpQ+rEBfCtZ+aRjS6vEf
         oUdNujTURBeo0UwF7epw9mheHyWz2M2Oc99HbrJhesELvJ8RXY+1uuhnM0y84u6eUEyl
         hQEDP1MYxlztT4rUDn7POLcz90Z9Qh0nnGm3I=
Received: by 10.204.34.9 with SMTP id j9mr4367915bkd.10.1255932457775; Sun, 18 
	Oct 2009 23:07:37 -0700 (PDT)
In-Reply-To: <7vzl7omi5z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130656>

On Mon, Oct 19, 2009 at 00:49, Junio C Hamano <gitster@pobox.com> wrote=
:
> Alex Riesen <raa.lkml@gmail.com> writes:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_SET_INT(0, "dwim", &=
dwim_new_local_branch,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 "Guess local branch from remote reference (default)",=
 0),
>
> Humph, how does SET_INT know to set it to 1 with --dwim and set it to=
 0
> with --no-dwim?

It seems to do, though (I checked before sending).
