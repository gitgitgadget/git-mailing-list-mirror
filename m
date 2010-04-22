From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull behavior changed?
Date: Wed, 21 Apr 2010 21:27:31 -0400
Message-ID: <v2z3abd05a91004211827ua3955912w676d8a3e001ed461@mail.gmail.com>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com> 
	<v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com> 
	<y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com> 
	<vpqsk6omppf.fsf@bauges.imag.fr> <h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com> 
	<vpq8w8gjvhn.fsf@bauges.imag.fr> <z2t3abd05a91004211541y1c2c5467k5731819da7fe625@mail.gmail.com> 
	<20100422000131.GB14249@coredump.intra.peff.net> <k2t3abd05a91004211713u24ff93f3of758e5e09c7b8059@mail.gmail.com> 
	<20100422004136.GA18570@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 22 03:28:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4lCx-0002k1-7E
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 03:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226Ab0DVB1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 21:27:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45753 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014Ab0DVB1w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 21:27:52 -0400
Received: by wyb39 with SMTP id 39so4460390wyb.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 18:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=vje3YSWPXjXYPo9vsxdEmO5h5vkafDrFkkmzqKfN7TQ=;
        b=hHyS0pZ9z/TBTLoOXTSKlDChikEUhaMdo+FLOji58xcOBAuHyh32USkk8Xs76H11pY
         C7+Z4zHZXR4FlK59YzL0CAKorVSskuOymJKPemepLhpDI/+8mg+LWbK3VzcvDzp2FNNa
         bAgYbqdLbzlqwg2H5kRTmFeA7G2oU5MeI4hlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ceTxHKomhjA6z7Lnie+LauOsMz3dVvHh+lD/7yQJPKFuxWPHCHp35BBSq0uLT6QjkE
         MM5fpY9W/RgjaOqB0vll0PA94YO9x2il5YnR+HhUYaELiT9+jv/HMl9EttDCbwltBsOg
         NC3V2kmM163FnzukybPxPgVq5WcMLvkpLCXaM=
Received: by 10.216.157.212 with HTTP; Wed, 21 Apr 2010 18:27:31 -0700 (PDT)
In-Reply-To: <20100422004136.GA18570@coredump.intra.peff.net>
Received: by 10.216.90.201 with SMTP id e51mr2682944wef.72.1271899671149; Wed, 
	21 Apr 2010 18:27:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145490>

> OK, then the behavior did change for you. But you are probably about 3
> years too late to complain and try to get it changed. :)

Dammit. :) But really no biggie. I just entered panic mode because I
thought something got borked in my favorite tool, which is not the case
obviously.

> You may also be interested to know that "git checkout foo" these days
> when you have no "foo" branch will do the equivalent of "git checkout -b
> --track foo origin/foo", which would also do what you want.

Wouldn't that create/track a remote 'foo' branch ? I have no remote branches
but only local ones so I am always tracking origin/master.

  -- aghiles
