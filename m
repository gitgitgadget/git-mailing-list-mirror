From: Antriksh Pany <antriksh.pany@gmail.com>
Subject: Re: Is there a way to enforce '-x' when running git cherry-pick?
Date: Mon, 5 Jul 2010 10:41:18 +0530
Message-ID: <AANLkTikNktETMLyF6HUxxPb7pbMVSK5GRJquu_XPA05b@mail.gmail.com>
References: <AANLkTinWcGZksUfs33BcA-Dz6z8uvUFSW_SY6QQyDhVy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 07:11:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVdxr-0006Zp-SV
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 07:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342Ab0GEFLU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jul 2010 01:11:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49090 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab0GEFLT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 01:11:19 -0400
Received: by gye5 with SMTP id 5so1127107gye.19
        for <git@vger.kernel.org>; Sun, 04 Jul 2010 22:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vZoyvZcrFHiSaXFCnlWtyGfBxDCHNA46vgpzIa06a2w=;
        b=B2URxVy1ETEj/s7iAW3bBDww48l2CImIKYQJJ0iYtnbvcaLfmsYEiDgdLOQOzUTy/k
         U9l0qrcSYONMc8govPpPDMWnrFrBw667HdRJoZmNTuy+qi1koy6YgqVNxfqbod5F+D12
         SatDJIvphnKqoCZMoqTh3bQ6oMz5M1512fWRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JuGsAaxzEgXyhllGjyiso3JIOoEfFqbuFDB7oxQHbTbYJtmWYNxFed0DPxwFV1y75T
         ZxQAioiTZ0csFdqwLxI22b9C8YSrL1R7aUqCS/G3cbojvEp1CtcB4mOuHvoDRMfUwFH0
         EQmC+km10cnPJjy3OzZF5dvm76IWWooQ+cbWA=
Received: by 10.101.72.4 with SMTP id z4mr2916514ank.77.1278306678700; Sun, 04 
	Jul 2010 22:11:18 -0700 (PDT)
Received: by 10.151.47.13 with HTTP; Sun, 4 Jul 2010 22:11:18 -0700 (PDT)
In-Reply-To: <AANLkTinWcGZksUfs33BcA-Dz6z8uvUFSW_SY6QQyDhVy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150240>

Hi

Not sure if there is an easy way to change the default behavior
without meddling with code. An alias which can take the same name as a
command may have helped (with possible downsides), but that does not
work apparently.

You can effectively create a different command name through an alias li=
ke this:
git config alias.cherry-pick-x "cherry-pick -x"

And henceforth use:
git cherry-pick-x
(You may use a shorter/different alias as might be convenient)

Thanks
Antriksh Pany

On Mon, Jun 28, 2010 at 9:25 PM, Erez Zilber <erezzi.list@gmail.com> wr=
ote:
> Hi,
>
> Running git cherry-pick with the '-x' flag seems very helpful for me
> when cherry-picking commits between branches on a public reporsitory.
> Is there a way to run it with '-x' by default?
>
> Thanks,
> Erez
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
