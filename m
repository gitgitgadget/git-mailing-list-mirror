From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Update the documentation for git-merge-base
Date: Mon, 15 May 2006 23:13:12 -0700
Message-ID: <7vhd3qebuv.fsf@assigned-by-dhcp.cox.net>
References: <20060516055815.GA4572@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 08:13:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffso4-0003qT-Tn
	for gcvg-git@gmane.org; Tue, 16 May 2006 08:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWEPGNO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 02:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWEPGNO
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 02:13:14 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:18348 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751487AbWEPGNN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 02:13:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060516061313.ZEYH27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 May 2006 02:13:13 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060516055815.GA4572@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Tue, 16 May 2006 07:58:15 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20103>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> Is the code guaranteed to return a least common ancestor? If that is
> the case we should probably mention it in the documentation.

Unfortunately, no, if you mean by "least common" closest to the
tips.

See the big illustration at the top of the source for how you
can construct pathological case to defeat an attempt to
guarantee such.  --all guarantees that the output contains all
interesting ones, but does not guarantee the output has no
suboptimal merge bases.
