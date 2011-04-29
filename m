From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] avoid set-but-not-used warning
Date: Fri, 29 Apr 2011 13:34:25 -0300
Message-ID: <BANLkTi=KZxTrAzoj3Bhwr3XTEPNnOvcvdQ@mail.gmail.com>
References: <874o5hv1f2.fsf@rho.meyering.net>
	<7vwridxbs9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:34:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFqeF-0001UD-GG
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 18:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197Ab1D2Qe1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2011 12:34:27 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46797 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076Ab1D2Qe0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2011 12:34:26 -0400
Received: by wya21 with SMTP id 21so2965165wya.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 09:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BI8YJBzxMlV5AimsI9X5phH+vhtmYMugbHieN7NB/Y0=;
        b=m5D4QbXNI2qTw7k/do97DPD/kKk4LiNl+T3S0HwXsfCVHEgzyFSM1r60kbFFaMMTN0
         2RYB4y4bHs/Z1jXeFOS48mH97Gi02KtfxVeyMCEjiY9A6W9/ZYR2MSlsFOMji87YVUgl
         Vx1zKTQUU9/jENEMobmi9Wl5RhDiWXdV4QygA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JdAZMepfcDainlPqxZDXb43hjqu7elARnvzDBLD3mpr0BEHQRUeg/N5fIkq04aSJ23
         FW7DaHqEPG0l/Js9JarKX9qXHLrbXGBa+ptEwtRjyg1PBBQPc2wKNDXgnyyYVqxy5dWf
         e84Bo4R634LRYXM0OkNjtabykVPNVfgOwhwis=
Received: by 10.216.143.74 with SMTP id k52mr5079189wej.0.1304094865288; Fri,
 29 Apr 2011 09:34:25 -0700 (PDT)
Received: by 10.216.164.4 with HTTP; Fri, 29 Apr 2011 09:34:25 -0700 (PDT)
In-Reply-To: <7vwridxbs9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172470>

On Fri, Apr 29, 2011 at 1:28 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Thanks.

Ingo Molnar has posted the same fix in "diffcore-rename: Remove unused
variable 'num_src'".

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
