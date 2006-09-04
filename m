From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] gitweb: Add GIT favicon, assuming image/png type
Date: Mon, 04 Sep 2006 15:46:17 -0700
Message-ID: <7virk3l07a.fsf@assigned-by-dhcp.cox.net>
References: <200609041810.09838.jnareb@gmail.com>
	<200609041813.49103.jnareb@gmail.com>
	<200609042032.13742.jnareb@gmail.com> <edhrij$l9j$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 00:46:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKNCk-00056Y-JM
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 00:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWIDWpy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 18:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWIDWpy
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 18:45:54 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:30624 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932205AbWIDWpx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 18:45:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904224553.EDQH6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Mon, 4 Sep 2006 18:45:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JNlm1V00r1kojtg0000000
	Mon, 04 Sep 2006 18:45:47 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <edhrij$l9j$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	04 Sep 2006 20:34:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26441>

Jakub Narebski <jnareb@gmail.com> writes:

> Jakub Narebski wrote:
>
>> index 199fbe87384cd3f4686916277dd124cefc751e8a..f3b762de92e579300eba3f53ee26b2a80b4e76c7 100644
>
> Hmmm... I do wonder why --binary implies --full-index option.

Patch safety.  Yours happened to be a creation patch so it might
not matter in this particular case, but we would want to be
reasonably sure there is no ambiguity in the preimage when you
are doing a modification patch.
