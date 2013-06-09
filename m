From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Mon, 10 Jun 2013 01:24:09 +0530
Message-ID: <CALkWK0kX1E9A9q1ptfx-QA1LiBf4UEeHF92xR21am=vv_zKZZA@mail.gmail.com>
References: <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
 <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
 <20130608164902.GA3109@elie.Belkin> <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
 <20130608173447.GA4381@elie.Belkin> <CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
 <20130609014049.GA10375@google.com> <CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
 <20130609052624.GB561@sigill.intra.peff.net> <CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
 <20130609180437.GB810@sigill.intra.peff.net> <CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
 <87zjuz84tp.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:54:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllhX-0000K0-Nx
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425Ab3FITyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:54:51 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:44065 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab3FITyu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:54:50 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so8130246iea.4
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Czv64JxBBWD71tIpjcWr8l76gPAtlVRyTpVh/+D1e8A=;
        b=Iy8ByiyJyFayr5DR1Qv/BDKLqr02qHg+3mLfiIZbMHHeo71hjWC7iPgFMYtZSPiYZ7
         hIDjLA3tpHPtELJ9160DzRMb2dnlOLFFkWGYHCRhKVFOSBULW+cJ83DpZww6Q7ISVWHe
         Pnp80sxigz61Gbkz1FVUtu8XGzCj2h5Y89a7vd7h5OZSIZjtCPn/CiurVHr6sD2Pb1RR
         X84kBStjjSn8w9uNWDWhvFnRQarKW6b5c0JcC2bX0wKSkvo6lfAT5R7MEG8s+EnZ0uT4
         9YyqgF88KnEJaloKo1BJ0YnLSxuxxMdVy/lbZlrAAQvqV6XQCZmU78EWdhc5FGd+1SiD
         LZAQ==
X-Received: by 10.50.98.104 with SMTP id eh8mr2739215igb.111.1370807689946;
 Sun, 09 Jun 2013 12:54:49 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 9 Jun 2013 12:54:09 -0700 (PDT)
In-Reply-To: <87zjuz84tp.fsf@hexa.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227157>

Thomas Rast wrote:
> The arguments arise to a large degree from attempting to review his
> work.  Not doing so is not an option, see e.g.:

I don't recall saying that you shouldn't review his work (?).  What I
_am_ saying is that there is absolutely no point belaboring over
what's wrong with Felipe's "tone", "demeanour" and "style of
discussion".  It has been discussed a zillion times now.  You're doing
it under the pretext of "agreement" and "setting a good example" (in
jk's words); in reality, you're setting a bad example by showing
everyone that it is okay to do the same thing (welcome jh!) and waste
everyone's time.

>   http://article.gmane.org/gmane.comp.version-control.git/223279
>   http://article.gmane.org/gmane.comp.version-control.git/225969
>   http://article.gmane.org/gmane.comp.version-control.git/226125

All these are legitimate reviews, and they and everyone's getting
along just fine.  What argument are you talking about?  *scratches
head*

> And that's not even counting the part of the argument that arises purely
> from deliberate flaunting of the project's guidelines.

What guidelines?
