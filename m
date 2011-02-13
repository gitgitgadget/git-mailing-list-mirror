From: xzer <xiaozhu@gmail.com>
Subject: Re: a bug about format-patch of multibyte characters comment
Date: Sun, 13 Feb 2011 19:22:14 +0900
Message-ID: <AANLkTi=Ty22nzd6ja=XmMzMu+YzDKDSBMCOGRfKenhR4@mail.gmail.com>
References: <4D565D3B.7060808@gmail.com>
	<20110213075337.GA12112@sigill.intra.peff.net>
	<20110213083137.GB12112@sigill.intra.peff.net>
	<4D579A35.1000007@gmail.com>
	<20110213085236.GA2251@sigill.intra.peff.net>
	<4D57AEFC.10608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 13 11:22:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoZ65-0006d2-73
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 11:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339Ab1BMKWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 05:22:16 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54165 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266Ab1BMKWO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 05:22:14 -0500
Received: by iyj8 with SMTP id 8so3863296iyj.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 02:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DR6pK/yL74Rq1oc8cM5n/AzeHT4CPmexdd0NzAB85Zo=;
        b=o23hUsqGXAAjjbrPCV+8x0xLhVwSkyCqM8UFXyUcUucFTOixnLsMZWSgSkAH/1BzPl
         4dBQisRL3+XhFJ+5n9vTzr11kQf6o9N1EEivCg92vyb1hl9BkdzClN9tadYsf0hBQbvY
         AubItBxo2EtI0khKiSIAjZtbo15Ma3/wMub7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rv9ANxQzrtNTpvsb82Z0+hL+FvO+XweFn4jLjn30CWwmKdFAAhokuR/Flx+ItVxlds
         UnWan8YiuEKNaWLZe7t7jook68EANAtgntXB1arnPutY/fWfgrdFCDc5z+9UoKu8+Xbr
         P9PIiwKFZAGFXsZJlm64pS+xo8DN/h5IZSOE4=
Received: by 10.42.217.195 with SMTP id hn3mr3222835icb.332.1297592534339;
 Sun, 13 Feb 2011 02:22:14 -0800 (PST)
Received: by 10.231.35.3 with HTTP; Sun, 13 Feb 2011 02:22:14 -0800 (PST)
In-Reply-To: <4D57AEFC.10608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166657>

> A sample of rfc2047 show us a legal line broken subject mail, like
> following:
> ------------------------------------------------------------------
>  Subject: =?ISO-8859-1?B?SWYgeW91IGNhbiByZWFkIHRoaXMgeW8=?=
>    =?ISO-8859-2?B?dSB1bmRlcnN0YW5kIHRoZSBleGFtcGxlLg==?=
> ------------------------------------------------------------------
>
> I understand that the current format-patch is not not valid to
> rfc2822/rfc2047,
> but even a valid one just like above, most of the mail client will can not
> show it
> correctly, they show the first line only, I think that's a problem of user
> friendliness.

I am sorry I made a mistake, there is no problem of mail client, I just
create a wrong format to test. So now I think if we can generate a valid
rfc2047 patch file, and then make the am also analyze the patch file
correctly, there is no problem. Isn't it?

-xzer
