From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 5/8] revert: allow cherry-picking more than one commit
Date: Tue, 1 Jun 2010 09:38:29 +0200
Message-ID: <AANLkTilgx84KIrs-z0dX6ZaZWhBRGKwtJQO3hEUQPLRN@mail.gmail.com>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org> 
	<20100531194240.28729.9164.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 09:46:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJMBA-0007Gk-C7
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 09:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab0FAHqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 03:46:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62384 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626Ab0FAHqT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 03:46:19 -0400
Received: by gye5 with SMTP id 5so889781gye.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 00:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=dWEI9e2t09le2P1PjInfF199icnR+9vr+xJ7lIWLwJg=;
        b=kI2IrWaXuKuD4xTiYuTR8vMXVn+PTnFX6ERrHycyjsKxW1zoVBB+lh/EIh7ASp1lsY
         4D+szmlgGc5H8tCqcP517DdwXCPOhdn0CZR09bI/UYCAw6ftszJ7ScMsnJX84EhNFoyF
         WSK5tChchE48MmJPgMUgMkz1/cInHxtH/KpA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=vBf0tpKrILkyBrcmvSpSjtov1ePcmOzLhlBfiUsdBWhJc5vvtasI0oxN69zrfg7okp
         ibONXD7li1Txwv01Tq7tFdVxXeRs6Yip7BVOcsMz6ypA7lUJVFfVG0rwSWej9MXRZw+i
         8JZrFA3s/lCBabbT1IGw9DH03vBBZIXN/+nKk=
Received: by 10.150.173.42 with SMTP id v42mr5861118ybe.244.1275377929115; 
	Tue, 01 Jun 2010 00:38:49 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Tue, 1 Jun 2010 00:38:29 -0700 (PDT)
In-Reply-To: <20100531194240.28729.9164.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148087>

Heya,

On Mon, May 31, 2010 at 21:42, Christian Couder <chriscool@tuxfamily.org> wrote:
> because "git rev-list --no-walk -2 master" only outputs
> one commit as "--no-walk" seems to take over "-2".

I don't understand this, what do you mean with "take over"? Is this a
bug/missing feature in rev-list?

-- 
Cheers,

Sverre Rabbelier
