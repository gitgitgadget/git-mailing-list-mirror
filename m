From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: cvsserver and wincvs (cvsgui)
Date: Fri, 13 Apr 2007 02:05:33 +0200
Message-ID: <20070413000532.GI7085@planck.djpig.de>
References: <Pine.LNX.4.64.0704121821150.27922@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 02:06:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc9Ie-0000dF-Gq
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 02:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbXDMAFh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 20:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753914AbXDMAFh
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 20:05:37 -0400
Received: from planck.djpig.de ([85.10.192.180]:3287 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753913AbXDMAFg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 20:05:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id D2995274014;
	Fri, 13 Apr 2007 02:05:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hKLUr66PSLMl; Fri, 13 Apr 2007 02:05:33 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 588DA274013; Fri, 13 Apr 2007 02:05:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704121821150.27922@iabervon.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44370>

On Thu, Apr 12, 2007 at 06:54:22PM -0400, Daniel Barkalow wrote:
> Anybody got any experience with wincvs and cvsserver, or any idea how 
> things could be different between git-cvsserver and real cvs? He's 
> presently going to use his own version control and just send us results, 
> but it would be nice if this could be magically worked out before we 
> started working together closely again in a couple of weeks.

Looks like a problem with newline conversion. You should probably
try the gitcvs.allbinary option (available since 1.5.0 I think),
that makes git-cvsserver send all files with -kb which should suppress
the conversion.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
