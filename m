From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Small "git clean" annoyance
Date: Fri, 1 Apr 2011 11:20:14 +0200
Message-ID: <AANLkTinHD6ZEwnSNxU1DC2gBF9ZpKPuDdgW=EUiPSWZK@mail.gmail.com>
References: <AANLkTinQscpkRDftLmCrQR+Aq5RacGyurd3kb15y=1FK@mail.gmail.com>
 <AANLkTikksQj3HfOJmi-uZTfc7sTNNuDA4bFVaj2cY3Ad@mail.gmail.com> <AANLkTikP17k4FWgfuZa6Fto5qtp1Bp_+4vOBwp=e2JZy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Apr 01 11:20:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5aX2-0007IP-Th
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 11:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab1DAJUg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 05:20:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57374 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab1DAJUf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 05:20:35 -0400
Received: by bwz15 with SMTP id 15so2370173bwz.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 02:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=FSgH2Jf5A9/QzvmNBdgyxs0pW43mGr/taLZrQEHLqs0=;
        b=ahyOefKGdZvO8mqZoYN4heB7iKoySA1+vf72ARRe9lIH/nLDyUr/sgpbNcJwXC80Gx
         e8lA7TLmsSLG/J3wVNpEQXFD+owugC/NS+zMf8i9vqFftk3ZmsC24xiSVQv8/pQWOieE
         1URcXOiVDji2VDBmEKF5OuIF8Ync1CSaQnHBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oHYRjIyRlPXtJ92HqLyI9a7Urew9at3OHz1rxIfIJvcNhUo3NlNYkfu3dsokeBYNuh
         SAssKdHLSvRO3XOai5x22RK4kGI5Fzh6LHfRjIdWAZ/A8LSjtkAIynG0gEeyWdp42LPE
         +eFrj79E+9PUO5OLSbv54i97O3hjJnj+3Fs8g=
Received: by 10.204.33.72 with SMTP id g8mr822537bkd.3.1301649634132; Fri, 01
 Apr 2011 02:20:34 -0700 (PDT)
Received: by 10.204.29.2 with HTTP; Fri, 1 Apr 2011 02:20:14 -0700 (PDT)
In-Reply-To: <AANLkTikP17k4FWgfuZa6Fto5qtp1Bp_+4vOBwp=e2JZy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170565>

On Fri, Apr 1, 2011 at 10:29, Erik Faye-Lund <kusmabite@gmail.com> wrot=
e:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rmdir(path->b=
uf) =3D=3D 0)
>
> nit-pick:
> don't we usually do "if (!rmdir(path->buf))"?
>

Not in this file.
