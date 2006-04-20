From: Junio C Hamano <junkio@cox.net>
Subject: Re: cg-clone produces "___" file and no working tree
Date: Thu, 20 Apr 2006 13:17:38 -0700
Message-ID: <7vslo8xaql.fsf@assigned-by-dhcp.cox.net>
References: <20060419053640.GA16334@tumblerings.org>
	<20060419094916.GD27689@pasky.or.cz>
	<20060419142131.GD4104@tumblerings.org>
	<20060419144827.GX27631@pasky.or.cz>
	<20060420164908.GA540@tumblerings.org>
	<7vejzsywrq.fsf@assigned-by-dhcp.cox.net>
	<20060420200849.GA3653@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 22:17:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWfay-0000Oe-9e
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 22:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWDTURl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 16:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWDTURk
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 16:17:40 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:46059 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751248AbWDTURk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 16:17:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420201739.BKVQ24981.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Apr 2006 16:17:39 -0400
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20060420200849.GA3653@tumblerings.org> (Zack Brown's message of
	"Thu, 20 Apr 2006 13:08:49 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18992>

Zack Brown <zbrown@tumblerings.org> writes:

> Not true. I went into the git source directory, and ran "make". Nothing more.

Ah, I misunderstood.  You are trying to run it _without_
installing it.

Well, then probably you do not have templates installed
anywhere, especially not where git-init-db expects them to be
found.
