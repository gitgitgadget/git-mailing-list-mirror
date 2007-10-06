From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] makefile: Add a cscope target
Date: Sat, 6 Oct 2007 03:04:37 +0200
Message-ID: <20071006010437.GS31659@planck.djpig.de>
References: <20071005223336.GA4556@luggage>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kristof Provost <Kristof@provost-engineering.be>
X-From: git-owner@vger.kernel.org Sat Oct 06 03:04:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idy6D-0000jd-8M
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 03:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761553AbXJFBEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 21:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759466AbXJFBEs
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 21:04:48 -0400
Received: from planck.djpig.de ([85.10.192.180]:4221 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757393AbXJFBEr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 21:04:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 6B2D988231;
	Sat,  6 Oct 2007 03:04:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id goovxlDp9g9e; Sat,  6 Oct 2007 03:04:37 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 7101088232; Sat,  6 Oct 2007 03:04:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071005223336.GA4556@luggage>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60138>

On Sat, Oct 06, 2007 at 12:33:36AM +0200, Kristof Provost wrote:
> +cscope:
> +	$(RM) cscope*
> +	$(FIND) . -name '*.hcS]' -print | xargs cscope -b


missing [

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
