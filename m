From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull behavior changed?
Date: Wed, 21 Apr 2010 20:13:48 -0400
Message-ID: <k2t3abd05a91004211713u24ff93f3of758e5e09c7b8059@mail.gmail.com>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com> 
	<v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com> 
	<y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com> 
	<vpqsk6omppf.fsf@bauges.imag.fr> <h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com> 
	<vpq8w8gjvhn.fsf@bauges.imag.fr> <z2t3abd05a91004211541y1c2c5467k5731819da7fe625@mail.gmail.com> 
	<20100422000131.GB14249@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 22 02:14:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4k3d-0004VM-89
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 02:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010Ab0DVAOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 20:14:11 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33739 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab0DVAOK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 20:14:10 -0400
Received: by wyb39 with SMTP id 39so4435368wyb.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 17:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=NHvTAzF6qaWGhDVPpBeOLXq5Kj/WFrSt4R+zY+n5csg=;
        b=DMvFa/Gmu6xiEd22abAkry5D6v5IgpNFT9N51Z9j5gMWe8f48v0U6LnwLp0znjDxOM
         ntJp2QV/ZDecZf00+3MaULRV6Dv/wVAjbQ2tWYnpU2RfZh04O0s1GR/XyUkHn9iApnSR
         iexNwKbrwI/g4unQ9rL2sBZufHFZrtuDcQY8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tKZ6QZAq4yz0KaMTNWPhZ8XSblfoB4lW1uuWobRtjGLHV9jOp1PzvvxzfoZ4qjS2au
         qWOm+1aG6xrPcNAIy5hW9+UXxhaNbmtslLY953YflRdz4Tc/uyp8AMDEwb6M9GWuyxRp
         hSZ+3jprpH5TENSvVpbUzyyOvUqNJTxW7DUFY=
Received: by 10.216.157.212 with HTTP; Wed, 21 Apr 2010 17:13:48 -0700 (PDT)
In-Reply-To: <20100422000131.GB14249@coredump.intra.peff.net>
Received: by 10.216.91.6 with SMTP id g6mr5936775wef.37.1271895248307; Wed, 21 
	Apr 2010 17:14:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145483>

On Wed, Apr 21, 2010, Jeff King wrote:

> What was the old version of git? A long time ago (maybe 1.5.x or
> earlier?) we used to default unconfigured pulls differently.

I don't have the information handy but it was most probably pre-1.5.
I don't know if my 'branching habits' are common, but I found that
the old behavior to be more natural with the way we work (creating
branches for quick parallel work).

If the current behavior is here to stay, I would humbly suggest to
mention the 'git checkout -b x origin' syntax in the manual (and
'git branch --track x origin').

On a positive note, I would like to say that there is a good progress
regarding the messages git prints to guide the user. That is helpful.

  -- aghiles
