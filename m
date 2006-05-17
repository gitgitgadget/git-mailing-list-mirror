From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC 2/5] Improve abstraction of ref lock/write.
Date: Wed, 17 May 2006 03:46:50 -0700
Message-ID: <7vk68lgc85.fsf@assigned-by-dhcp.cox.net>
References: <20060517095502.GC28529@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 12:47:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgJZ3-0004JP-D0
	for gcvg-git@gmane.org; Wed, 17 May 2006 12:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWEQKre (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 06:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWEQKre
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 06:47:34 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:52683 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751140AbWEQKrd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 06:47:33 -0400
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k4HAlKj5032366
	for <git@vger.kernel.org>; Wed, 17 May 2006 10:47:32 GMT
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517104651.HVQB25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 06:46:51 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060517095502.GC28529@spearce.org> (Shawn Pearce's message of
	"Wed, 17 May 2006 05:55:02 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20187>

Shawn Pearce <spearce@spearce.org> writes:

> Created 'struct ref_lock' to contain the data necessary to perform
> a ref update...
>
>  fetch.c |   32 +++++----
>  refs.c  |  236 ++++++++++++++++++++++++++++++---------------------------------
>  refs.h  |   24 ++++--
>  3 files changed, 144 insertions(+), 148 deletions(-)

Looks a bit intrusive probably necessary so not necessarily bad
but I'll postpone looking at this for now; maybe tomorrow or
more likely over the weekend.

Eyeballs from people touched the affected files in the past are
greatly appreciated.
