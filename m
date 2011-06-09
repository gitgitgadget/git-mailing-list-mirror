From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitweb: do misparse nonnumeric content tag files that
 contain a digit
Date: Thu, 9 Jun 2011 02:11:23 -0500
Message-ID: <20110609071123.GB735@elie>
References: <20110301190229.11297.17767.reportbug@cassiopeia.kleinek>
 <201103030142.17258.jnareb@gmail.com>
 <20110303081904.GM22310@pengutronix.de>
 <201103071900.16126.jnareb@gmail.com>
 <20110609070857.GA735@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, "J.H." <warthog9@kernel.org>,
	git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 09:11:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUZOw-0007VF-Aj
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 09:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323Ab1FIHL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 03:11:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41993 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879Ab1FIHL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 03:11:28 -0400
Received: by iwn34 with SMTP id 34so1074131iwn.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 00:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=R9oA/c9JdS7Te1jtv29TEKFEqEOWFumL0InhgzfNcpQ=;
        b=mP/g5E5ruLA+YS11NF2LMFv/dZEWn3OUu/2LTdbXEwKndB/4o43E0B2fYY5VEYOoNN
         jIUQBdvGKgdSW2PKsGh7biVimby9ziU5yTnPkWJrFq3mX7E11a3NiSghKJ+ro8SqqBTb
         7MSt20WE2OaY7aNDXPciIlTBe3OotcfJwH2Ak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=I0Eeyf6ZgCGu12vtOD2JanNa291g2+DKYtxCjRBlfBKD0X/aTYgamYHAJK8HPauQI5
         vrGXl2gpI+AR8N4mrTXNtmaQTAsWaR14DxIEfJTtLgy/j/kHS+P2xyNmJmPo/W4s/rMz
         /k2ZiEQwjXVRcGCLjLE8QIgrqIfgkoVQEpuP0=
Received: by 10.42.132.69 with SMTP id c5mr593788ict.459.1307603488200;
        Thu, 09 Jun 2011 00:11:28 -0700 (PDT)
Received: from elie (adsl-69-209-61-87.dsl.chcgil.sbcglobal.net [69.209.61.87])
        by mx.google.com with ESMTPS id a9sm1118104icy.18.2011.06.09.00.11.26
        (version=SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 00:11:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110609070857.GA735@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175497>

Jonathan Nieder wrote:

> [Subject: [PATCH] gitweb: do misparse nonnumeric content tag files that contain a digit]

Sigh, it's only after sending that the obvious typos jump out.

"do" should be "do not" in the subject.  Sorry for the trouble.
