From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and Mercurial
Date: Sun, 26 Apr 2009 01:16:16 -0700 (PDT)
Message-ID: <m363grq13i.fsf@localhost.localdomain>
References: <200904260703.31243.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 27 05:42:55 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxzYm-00086M-1K
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 10:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbZDZIQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 04:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbZDZIQV
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 04:16:21 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47238 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbZDZIQT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 04:16:19 -0400
Received: by fxm2 with SMTP id 2so1766083fxm.37
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=DF/iJYvK0J9b31MUlSfKSDA2sFa346WO27kaj1qUOH0=;
        b=HdXq4S52rTFrKK8lHrIzXNMIEzDdkcjSKUQEFh1LQZJ28ng5b+y0Nuz9VpdwwC/k9g
         LPto/CdCy0SoCDggO5O4L0UptzJs7SAX9E8cRaD8EtXsv9LerWr5otfq2OJNiA+iTgQj
         B593drq2EBMLtOJI9vBaKNl5w/1JG24TPTxsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=goaOpLRNTqukXRD5HU6hDqd/+Fpl4Qax25GxAluMc2U+tW5g2Eou1kGOmFRkqRmRLN
         dvGJ/rN63QNajACCzSmaiknSvReeL/36NbHyuA33Qyxo+tolEPb03pgz2xtlOoxqs8/s
         cJNRJT49NhQV6j+P6qqiq/qUoNHPWgkuQR8iY=
Received: by 10.103.173.5 with SMTP id a5mr2414173mup.57.1240733777262;
        Sun, 26 Apr 2009 01:16:17 -0700 (PDT)
Received: from localhost.localdomain (abwp56.neoplus.adsl.tpnet.pl [83.8.239.56])
        by mx.google.com with ESMTPS id 12sm8752333muq.21.2009.04.26.01.16.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Apr 2009 01:16:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n3Q8JEmO025108;
	Sun, 26 Apr 2009 10:19:24 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n3Q8Iw7T025101;
	Sun, 26 Apr 2009 10:18:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200904260703.31243.chriscool@tuxfamily.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117597>

Christian Couder <chriscool@tuxfamily.org> writes:

> For information, now Google Code supports Mercurial for project hosting:
> 
> http://google-code-updates.blogspot.com/2009/04/mercurial-support-for-project-hosting.html
> 
> Mercurial was choosen over Git because of this (one year old) analysis:
> 
> http://code.google.com/p/support/wiki/DVCSAnalysis
> 
> There is this article on LWN about the analysis:
> 
> http://lwn.net/Articles/330138/

It is a pity that the choice was based on year old analysis.  One year
for actively developed and fast moving targets such like Git and
Mercurial is ages in terms of development history.  But I guess this
is unavoidable.

For example periodic "maintenance" (garbage collecting) is nowadays
quite automatic in git, with fetching into pack, periodic repacking if
number of loose objects is above tthreshold, and "git gc --auto".

Whether Mercurial or Git has better UI and better documentation is
IMHO a matter of debate.  Git documentation is much better that it
was, with "Git User's Manual" and "Git Community Book"; UI also is
being improved.

I can't comment on MS Windows support, but AFAIK Mercurial has better
support here than Git.


The deciding feature (well, one of deciding features) was the fact
that Mercurial has better HTTP support... I guess (it was not obvious
from the analysis, but it was hinted at) that Mercurial uses its
custom protocol over HTTP, as opposed to "dumb" HTTP protocol support
in Git.

Perhaps it is time to restart work on _"smart" HTTP protocol_?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
