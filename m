From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] cvsserver: added support for update -p
Date: Thu, 11 Oct 2007 23:07:37 +0200
Message-ID: <20071011210737.GP31659@planck.djpig.de>
References: <200710101316.03633.jan@swi-prolog.org> <1192120573-16765-1-git-send-email-frank@lichtenheld.de> <Pine.LNX.4.64.0710112158330.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Jan Wielemaker <jan@swi-prolog.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 23:08:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig5GB-0001Fk-Co
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 23:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828AbXJKVHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 17:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754438AbXJKVHu
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 17:07:50 -0400
Received: from planck.djpig.de ([85.10.192.180]:3151 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753831AbXJKVHt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 17:07:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 06A6188234;
	Thu, 11 Oct 2007 23:07:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GUff5E3xzWSM; Thu, 11 Oct 2007 23:07:37 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id D251B88232; Thu, 11 Oct 2007 23:07:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710112158330.4174@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60637>

On Thu, Oct 11, 2007 at 09:59:28PM +0100, Johannes Schindelin wrote:
> On Thu, 11 Oct 2007, Frank Lichtenheld wrote:
> 
> > +	if ( exists ( $state->{opt}{p} ) )
> 
> I see you kept the coding style, which is not in agreement with the rest 
> of git...  Intention or oversight?

It is in agreement with the rest of git-cvsserver. I really like the
style of the other perl stuff in git better, but I wasn't sure what
style takes precedence...

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
