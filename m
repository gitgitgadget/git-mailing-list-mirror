From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff --stat: do not drop rename information.
Date: Thu, 20 Apr 2006 03:18:12 -0700
Message-ID: <7v4q0o1rff.fsf@assigned-by-dhcp.cox.net>
References: <7vzmig3o7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0604201138130.9099@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 12:18:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWWEs-0006RU-1F
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 12:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWDTKSP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 06:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWDTKSP
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 06:18:15 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:48560 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750827AbWDTKSO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 06:18:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420101814.YZEO17757.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Apr 2006 06:18:14 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18962>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ... This also shows deletes and adds as "bla/bla => /dev/null" 
> and "/dev/null => bla/bla", right?

Dunno.  It's still essentially your code ;-).

The usual "diffstat" does not do that, but it might be useful.
Another thing that could be done is to fold in mode change
information (usually people care only about chmod +/-x).
