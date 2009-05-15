From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] Showing stash state in bash prompt
Date: Fri, 15 May 2009 16:12:10 +0900
Message-ID: <fc339e4a0905150012t28c59a5erb3f9d9eac924ab14@mail.gmail.com>
References: <20090513094448.GC2106@bug.science-computing.de>
	 <20090513112535.GD2106@bug.science-computing.de>
	 <7v4ovo4xyt.fsf@alter.siamese.dyndns.org>
	 <200905142025.02592.trast@student.ethz.ch>
	 <buo1vqrqj2n.fsf@dhlpc061.dev.necel.com>
	 <20090515021105.GA19241@coredump.intra.peff.net>
	 <43d8ce650905142339p266c2f0fye1174036d6251ed0@mail.gmail.com>
	 <81932ACA-EE6B-4922-9506-13DB5D6EF551@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Fri May 15 09:12:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4rae-0001VT-8C
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 09:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512AbZEOHMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 03:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754496AbZEOHML
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 03:12:11 -0400
Received: from mail-qy0-f112.google.com ([209.85.221.112]:52699 "EHLO
	mail-qy0-f112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384AbZEOHMK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 03:12:10 -0400
Received: by qyk10 with SMTP id 10so299627qyk.33
        for <git@vger.kernel.org>; Fri, 15 May 2009 00:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=y0t1BXsrlIGal1KFVvfl3J8ZgA9hdjZJAOVcVlVn2OI=;
        b=Luv3rk9yPimEZ1DyZbL0ECNiBWovlNw07NIXAL2WVJ+5B8KvN6TIaI9eIfvFiXhshY
         yvj6aH4JzeIWwWY8rOm3od1I2t1T5oSxCzdFkRHr5V6rgevu+J6z+2BBQM0CXInsmT3+
         0l7glb8arMuaJJBsCxr4X5pqIs9awRO8+ImT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=AfUdN8y++fKrPDDQO6k53mKwH2rajU1d72qZ/gjF/xxYyvNEdlFksetHC8FJON21pK
         ETED7CLuBc0I9Fd6y5DDzpY4WXlF3gVAm62knmPHQfrZgRB0S9TFc4S/lH/xpHvTRNv2
         2kwaMZ77CBjTA4MfClTMrrdo11+xkH2Q/Ifco=
Received: by 10.220.84.202 with SMTP id k10mr4651847vcl.77.1242371530915; Fri, 
	15 May 2009 00:12:10 -0700 (PDT)
In-Reply-To: <81932ACA-EE6B-4922-9506-13DB5D6EF551@silverinsanity.com>
X-Google-Sender-Auth: 0e251ae856f37f4e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119250>

2009/5/15 Brian Gernhardt <benji@silverinsanity.com>:
> git config --global alias.unstash "stash apply"

Tho it should really be "stash pop"

-miles
-- 
Do not taunt Happy Fun Ball.
