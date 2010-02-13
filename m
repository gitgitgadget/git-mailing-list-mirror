From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-subtree.sh - regression introduced by da949cc55
Date: Sat, 13 Feb 2010 14:49:18 -0500
Message-ID: <32541b131002131149v27df5655mf400fc8c39834856@mail.gmail.com>
References: <20100211130837.GA29916@lonquimay.wrk.lsn.camptocamp.com> 
	<508e1531002110526u623bffbdi119d009a7af460b8@mail.gmail.com> 
	<32541b131002120952gcb5116as730fff8bdcf005c1@mail.gmail.com> 
	<508e1531002131141o32fdc555keb31a3d8b05d7109@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marc Fournier <marc.fournier@camptocamp.com>, git@vger.kernel.org
To: Jakub Suder <jakub.suder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 20:50:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgO07-0003DH-Gd
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 20:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758059Ab0BMTtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 14:49:41 -0500
Received: from mail-yx0-f196.google.com ([209.85.210.196]:64100 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758032Ab0BMTti (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 14:49:38 -0500
Received: by yxe34 with SMTP id 34so1565146yxe.15
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 11:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=232N2TNedVBY5aYu6sLkgwyiKt3LBxaEpQxRB48OvMI=;
        b=aCWBCVfOapyEU6Glmgm5ovqmqzvBj1UR5CrqPeHEBbpbI1eY1ZCQpVlZvV90eW+6Os
         /tPgmncOe1Rs1HhH4WAEthzRwVtSMkN3QQUMJxxoKlTjp1p5pDu4jP/BNZVTWYSzATYR
         W3XeosEu8ee9Vn5jqlF0murYSlEVpOblaPkro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XwiM6BiWJ6hnn8oabvOboSUDcdPGEWGm7w45dGnNAc3pZl2/lvk5W4RlMD0MwdXb5J
         QXIcqx8ACkfR1PemriiTmuPzwyxSiv31A/u4Rzqer6CSVrDbK4sJBTrE3BojoQepvx+p
         zdogCKikpv16aJAQOm4YIJylHUc/RLRamJhTY=
Received: by 10.150.48.33 with SMTP id v33mr5616241ybv.16.1266090578358; Sat, 
	13 Feb 2010 11:49:38 -0800 (PST)
In-Reply-To: <508e1531002131141o32fdc555keb31a3d8b05d7109@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139825>

On Sat, Feb 13, 2010 at 2:41 PM, Jakub Suder <jakub.suder@gmail.com> wrote:
> We just need some different way of determining if this is a commit
> from subtree timeline or the main timeline - I'll see if I can come up
> with something...

Great, thanks.  By the way, the fact that the unit tests didn't catch
this is a bit worrisome, so if you could take a look at that at the
same time it would be great.

(BTW, I just merged a patch from someone to add the long-awaited "git
subtree push" and 2-argument "git subtree add" commands.  So I'm not
*totally* useless. :))

Have fun,

Avery
