From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] t9400: Use the repository config and nothing else.
Date: Sat, 12 May 2007 21:36:08 +0200
Message-ID: <20070512193608.GB7184@planck.djpig.de>
References: <7v8xbvj5mx.fsf@arte.twinsun.com> <20070512162819.GA7184@planck.djpig.de> <7vabwa3swp.fsf@assigned-by-dhcp.cox.net> <7vhcqi2c1g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 21:36:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmxO8-0005a8-68
	for gcvg-git@gmane.org; Sat, 12 May 2007 21:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759528AbXELTgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 15:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759393AbXELTgO
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 15:36:14 -0400
Received: from planck.djpig.de ([85.10.192.180]:2820 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758915AbXELTgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 15:36:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id D7E77274014;
	Sat, 12 May 2007 21:36:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8KfYfeiINuyC; Sat, 12 May 2007 21:36:09 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 53FD8274013; Sat, 12 May 2007 21:36:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhcqi2c1g.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47084>

On Sat, May 12, 2007 at 10:21:15AM -0700, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> When you prepare gitcvs.enabled config in the cloned gitcvs.git
> repository, you do not want to have GIT_CONFIG=.git/config in
> the environment.  As you give GIT_DIR to these two commands, not
> having GIT_CONFIG would make them do the right thing.

Yeah, which was the reason I unset it in the first place. But
if your concern is not to use other config files it should still
set GIT_CONFIG explicetly for these cases and leave it to the
default for all calls inside the non-bare repository, right?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
