From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-cvsimport-script: handling of tags
Date: Tue, 06 Sep 2005 12:01:27 -0700
Message-ID: <7vwtluaum0.fsf@assigned-by-dhcp.cox.net>
References: <431DD381.4050709@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 21:03:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECihI-0005sa-Ev
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 21:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVIFTB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 15:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVIFTB3
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 15:01:29 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:40636 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750801AbVIFTB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 15:01:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050906190129.SQUG11315.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Sep 2005 15:01:29 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <431DD381.4050709@zytor.com> (H. Peter Anvin's message of "Tue,
	06 Sep 2005 10:36:01 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8138>

"H. Peter Anvin" <hpa@zytor.com> writes:

> This patch changes git-cvsimport-script so that it creates tag objects 
> instead of refs to commits, and adds an option, -u, to convert 
> underscores in branch and tag names to dots (since CVS doesn't allow 
> dots in branches and tags.)

Looks good.  Thanks.
