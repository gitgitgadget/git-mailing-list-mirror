From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: [PATCH] git-remote: make remote name optional for prune operation
Date: Wed, 6 May 2009 08:46:48 -0700
Message-ID: <8c9a060905060846o1a7b26b0m78ff0cbe48648873@mail.gmail.com>
References: <1241620621-12188-1-git-send-email-julien@danjou.info> 
	<200905061649.25351.fge@one2team.com> <20090506153212.GF10701@abydos.adm.naquadah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francis Galiegue <fge@one2team.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Julien Danjou <julien@danjou.info>
X-From: git-owner@vger.kernel.org Wed May 06 17:48:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1jL5-0002op-MQ
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 17:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574AbZEFPrM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 11:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756876AbZEFPrK
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 11:47:10 -0400
Received: from gv-out-0910.google.com ([216.239.58.187]:44139 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782AbZEFPrJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 11:47:09 -0400
Received: by gv-out-0910.google.com with SMTP id p33so47501gvf.37
        for <git@vger.kernel.org>; Wed, 06 May 2009 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=d3JP2a8VDnTvVh7UrOhTcL+DhY8tvKJAozPLSEtQ0nA=;
        b=oijieRWgLIZVWoehDiyEfoNuI8vr/QUeJHMHLAs6BR1KuGEudGnpD05ub0hF0A/vDM
         5lcRmMTg+kWOVuaxfZlf+dh0OCwA1Qq/LOe3vYDd844GpjfF+0zgZPfOxfyJP7ad9xKP
         o3FTdmnVAYmJE8jP46OjQovEcINMNSbFvJM8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OH1d7q4Ky8L8g47uVKuTLfvrj2yg8y6mzXvrQOJoHVexcsVm8y9LUJ4x/VwOZfmdh1
         hD2Nk+uZuXNT3J59DDeodYEUUrR9S/VDTAZOH9/hKM74GhgEy5/N438BXsotvkgxBu6I
         i8vZESZ2Zd3mXnk01nzQrZy+L09rH1/os84x4=
Received: by 10.142.172.12 with SMTP id u12mr425802wfe.132.1241624828039; Wed, 
	06 May 2009 08:47:08 -0700 (PDT)
In-Reply-To: <20090506153212.GF10701@abydos.adm.naquadah.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118349>

On Wed, May 6, 2009 at 08:32, Julien Danjou <julien@danjou.info> wrote:
> At 1241621365 time_t, Francis Galiegue wrote:
>> Didn't you forget a little something in your patch?
>
> If so, I really can't see what.
>
> Cheers,
> --
> Julien Danjou
> // =E1=90=B0 <julien@danjou.info> =C2=A0 http://julien.danjou.info
> // 9A0D 5FD9 EB42 22F6 8974 =C2=A0C95C A462 B51E C2FE E5CD
> // Tomorrow I was nothing, yesterday I'll be.
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkoBrXoACgkQpGK1HsL+5c1TdwCgltFTU6aZmLUWzXFzNkq7Dqo5
> FywAoJTEUtDJO2LrzQyu+jB0vf9XCbe2
> =3DpF1M
> -----END PGP SIGNATURE-----
>
>

I'm guessing, but perhaps Francis means a test for this behavior?
