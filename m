From: Adam Monsen <haircut@gmail.com>
Subject: Re: Dangerous "git am --abort" behavior
Date: Mon, 20 Dec 2010 14:04:02 -0800
Message-ID: <AANLkTikUn+Mco3YeJ7Rj=xZrr1H5xr1Z0=cknf1MdCqC@mail.gmail.com>
References: <AANLkTinP4SArMkjvTXOEG=tf=8EcEdP9fPAB7F=iitSc@mail.gmail.com>
 <loom.20101220T203122-271@post.gmane.org> <1292881979.23145.5.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Mon Dec 20 23:04:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUnqG-0000mx-RO
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 23:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758166Ab0LTWEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 17:04:23 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37143 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758038Ab0LTWEW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 17:04:22 -0500
Received: by iwn9 with SMTP id 9so3593271iwn.19
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 14:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=GQ8lN6k9LZx5EtSVd2RtWmxn0HptKjhDst/xOtqvd40=;
        b=fXroQ0gsix9aVbGns2NcVwtSndAy1mlC1XJlH49+BgcTICiBBEPjQ3XkNczqe/+TVU
         fRYyoFdg1JzPyVMd4Tt9cXIxPdn2xZyHmlHeqfjxwS/rRQgl56G3fkmTvMKc0dwHZVst
         EkLuhSSoAFvHy/COlEbRrN4iqX+MBYSwOZJnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ghSrX/9SHYUGu8M5d9/tBYae0NSkImHL9TJl4z8GkyKsMCzh6gYpP+L/bambLCnUkp
         ho6iuDHk5fMuYPmg/CZiNRR3Mmoc9r5dbLbSvKtIERxKCFqdyUH4VcY6aKQT3xqF6GKL
         mCvyK1DsVP/bQ1qo2jQqM1UESXRfEs8BgVNp8=
Received: by 10.231.32.141 with SMTP id c13mr4618951ibd.101.1292882662161;
 Mon, 20 Dec 2010 14:04:22 -0800 (PST)
Received: by 10.231.15.65 with HTTP; Mon, 20 Dec 2010 14:04:02 -0800 (PST)
In-Reply-To: <1292881979.23145.5.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164015>

Another thing a pal just showed me is the awesome Git Bash/Zsh
completion stuff in contrib/completion/ . That's a good way to keep
tabs on whether you're in the middle of a rebase or am (as well as
many other statuses).

Drew Northup wrote:
> Please don't cull the CC list...

I didn't, I replied at
http://thread.gmane.org/gmane.comp.version-control.git/164002 (by
clicking "--Action--" and selecting "Followup".
