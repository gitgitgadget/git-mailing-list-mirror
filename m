From: Christopher Faylor <me@cgf.cx>
Subject: Re: Cygwin playbook?
Date: Thu, 7 Sep 2006 10:23:44 -0400
Message-ID: <20060907142344.GB1835@trixie.casa.cgf.cx>
References: <46a038f90609062159v3858a771t38355ed60867ccfc@mail.gmail.com> <7v7j0g40xh.fsf@assigned-by-dhcp.cox.net> <20060907072741.GA10652@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 07 16:24:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLKnD-0003CN-RL
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 16:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWIGOXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 10:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWIGOXp
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 10:23:45 -0400
Received: from pool-71-248-179-229.bstnma.fios.verizon.net ([71.248.179.229]:478
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S932226AbWIGOXo
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 10:23:44 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id 5092D13C042; Thu,  7 Sep 2006 10:23:44 -0400 (EDT)
To: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060907072741.GA10652@spearce.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26641>

On Thu, Sep 07, 2006 at 03:27:41AM -0400, Shawn Pearce wrote:
>Git pretty much works as you would expect; its just somewhat slower
>than on a good UNIX system.  Maybe its Cygwin, maybe its Windows,
>maybe its the 4+ year old system its running on.  :-)

It's likely to be the fact that Windows doesn't support fork or exec
so Cygwin has to emulate both - slowly.

cgf
