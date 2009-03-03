From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: remote branches, and branch names in general
Date: Mon, 02 Mar 2009 16:38:42 -0800 (PST)
Message-ID: <m3vdqrtp84.fsf@localhost.localdomain>
References: <450196A1AAAE4B42A00A8B27A59278E709F07398@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "John Dlugosz" <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 01:40:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeIgA-0004Xj-Cs
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 01:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756AbZCCAir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 19:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbZCCAir
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 19:38:47 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:38665 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbZCCAiq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 19:38:46 -0500
Received: by fxm24 with SMTP id 24so2238507fxm.37
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 16:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=9E5UG5uvU6HvTJvBA4lZzGT+nsoOVXwRewEtqfclnL8=;
        b=Y/JdSmB+NIdx/81W+HSuoSe1iDiXzyp/CNZ0sqz1R7YxythOgTDJVm3mGbd+SKC1L9
         H+djI6KLoR+hW2SJ/pUDt46ibm5cl4Xr562ok/FpyvR8z4vXVcgAr/NEk1weV5/dToZJ
         BrX5xITN8Om6CYruasuBcBUThU2YSSe4IPJVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=aCTl3JSg3RGhn2KS3O/QsyCalzxm9+u4yIlC3X5EOZXSorhgM8nRU/33YL91SLoEJZ
         V4c/9fUYMnNU2KJMXpkkI0VFfoxhL5y7BgjgijisfqRAg8xFNReuq0xooztXOzBn786A
         rDlanXcm1UlM0/KoJp6PbcyWehVm9fokKoygo=
Received: by 10.86.87.13 with SMTP id k13mr7401262fgb.35.1236040723350;
        Mon, 02 Mar 2009 16:38:43 -0800 (PST)
Received: from localhost.localdomain ([83.8.240.47])
        by mx.google.com with ESMTPS id l12sm60340fgb.31.2009.03.02.16.38.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Mar 2009 16:38:42 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n230cdku015205;
	Tue, 3 Mar 2009 01:38:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n230caW9015202;
	Tue, 3 Mar 2009 01:38:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709F07398@EXCHANGE.trad.tradestation.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111984>

"John Dlugosz" <JDlugosz@TradeStation.com> writes:

> I see the remote branches with names of the form remotes/pub/name where
> pub is the nickname of the place I pull from.  To specify such branches,
> must I always spell it out with the leading "remotes/", or can that be
> shorted or implied somehow?  

You usually can omit "remotes/" prefix, and just use
"<remote>/<branch>" (or even "<remote>" for "<remote>/HEAD"). You need
it only if there is need for disambiguation.

> 
> Meanwhile, I see that branch names can be hierarchical, as I found out
> when I accidently created a branch called "pub/xxx".  So I'm wondering
> about the usefulness of using that for organizing topic branches based
> on assigned tasks organization and the person owning that branch.

Junio uses branches like 'fc/parseopt-config' (initials + feature)
in git development...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
