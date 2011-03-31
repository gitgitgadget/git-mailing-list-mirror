From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] reset: update help text
Date: Thu, 31 Mar 2011 19:31:59 +0700
Message-ID: <AANLkTiknvWE9Fe3u88Jbis4Cgxd5ubqaR6MzYOJZ-AtM@mail.gmail.com>
References: <1301404805-12095-1-git-send-email-pclouds@gmail.com> <20110329210457.GA14031@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 14:32:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5H3C-0001iG-KT
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 14:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757432Ab1CaMca convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 08:32:30 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56282 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab1CaMc3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 08:32:29 -0400
Received: by pvg12 with SMTP id 12so391992pvg.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 05:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=yudrBbfGmPm0bT9KEQpMqf/U1ebpTk/k2SzSgGJPiIQ=;
        b=vuXSE2LxEnpBMBdJ0V7PWmiMjAnaLyID+ccuZvhm4r65600oGkrtf9p11Ro3XW+5Ik
         a+AUDuA6MqbL35lVVaoxU4iScjidrK7xRcKP1ulkXucoyOlbeoAVHGJlsHB/9zzZrueK
         4Y4/TmCi6+Z8cqFt73J7pEBCCe81lndrWcxl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jcuWhOgv2vgzvrt1PHTgC6CbqpxZMSbyW/m7fvkckiiWzba/U2oyz1SLA7vkteHB2X
         8RjjkpxrIPBZosx7vDeZvDc4yg/0l88LDc8ixQH1cbHPxQIkXgS1gkLolfIUWqeUOhNa
         iQ/jn5E40PFr/ny8ajnFpPc6KIwMQcecB4J4k=
Received: by 10.142.44.13 with SMTP id r13mr2022725wfr.328.1301574749042; Thu,
 31 Mar 2011 05:32:29 -0700 (PDT)
Received: by 10.68.42.234 with HTTP; Thu, 31 Mar 2011 05:31:59 -0700 (PDT)
In-Reply-To: <20110329210457.GA14031@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170483>

2011/3/30 Jonathan Nieder <jrnieder@gmail.com>:
> The description does not make it obvious to me how these two (--merge
> and --keep) differ. =C2=A0I think the intent of the options are:
>
> =C2=A0--keep:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0start working on a different commit, carry=
ing over local changes
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(like "git checkout")
> =C2=A0--merge:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return to <commit>, cancelling a merge-lik=
e operation that
> =C2=A0 =C2=A0 =C2=A0 =C2=A0creates some unmerged and some clean index=
 entries
>
> Maybe something along these lines could be ok starting point?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_SET_INT(0, "keep", &reset_type,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"move to <comm=
it>, carrying over local changes in working tree",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0KEEP),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_SET_INT(0, "merge", &reset_type,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"return to <co=
mmit>, cancelling failed merge or cherry-pick",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MERGE),
>

To be honest, I have no idea what the above describes. I read 9bc454d
(reset: add option "--keep" to "git reset" - 2010-01-19) and figured
that --keep is like --merge except that "git diff" before and after
the reset is exactly the same, is it? I have never used --keep before.
--=20
Duy
