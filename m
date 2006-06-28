From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport - cleanup of the multi-indexes handling
Date: Wed, 28 Jun 2006 04:10:38 -0700
Message-ID: <7vzmfx1qoh.fsf@assigned-by-dhcp.cox.net>
References: <11514896033560-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Wed Jun 28 13:10:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvXwR-0003R1-Us
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 13:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbWF1LKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 07:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932779AbWF1LKl
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 07:10:41 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:51144 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932778AbWF1LKk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 07:10:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060628111039.WWNM12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Jun 2006 07:10:39 -0400
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <11514896033560-git-send-email-martin@catalyst.net.nz> (Martin
	Langhoff's message of "Wed, 28 Jun 2006 22:13:23 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22803>

Martin Langhoff <martin@catalyst.net.nz> writes:

> Indexes are only needed when we are about preparing to commit. Prime them
> inside commit() when we have all the info we need, and remove all the
> redundant index setups.

Obviously makes sense although I admit I do not have to interact
with CVS these days anymore (lucky me ;-).
