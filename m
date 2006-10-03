From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Check that a tag exists using show-ref instead of looking for the ref file.
Date: Tue, 03 Oct 2006 13:26:30 -0700
Message-ID: <7virj1m9hl.fsf@assigned-by-dhcp.cox.net>
References: <20061001223304.d37df36f.chriscool@tuxfamily.org>
	<7vlknxrcja.fsf@assigned-by-dhcp.cox.net>
	<200610032211.05847.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 22:27:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUqqY-0001uu-JJ
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 22:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWJCU0b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 16:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWJCU0b
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 16:26:31 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:2552 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030324AbWJCU0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 16:26:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003202630.ITGH13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Oct 2006 16:26:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VwSQ1V00F1kojtg0000000
	Tue, 03 Oct 2006 16:26:24 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <200610032211.05847.chriscool@tuxfamily.org> (Christian Couder's
	message of "Tue, 3 Oct 2006 22:11:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28300>

Christian Couder <chriscool@tuxfamily.org> writes:

> Junio C Hamano wrote:
>> Thanks.  We also need this to avoid refetching already packed
>> tags.
>
> Yeah, I did a very quick check on the shell scripts and I obviously missed 
> some places that need updates.
>
> In fact, I couldn't resist to start implementing the deleted-refs/$frotz~ref 
> stuff we talked about...

How would that help?  We need to audit the existing scripts
since they would not look under $GIT_DIR/deleted-refs currently
anyway.
