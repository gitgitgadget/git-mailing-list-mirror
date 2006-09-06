From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 8/8] gitweb: Remove --parents from call to git-rev-list in parse_rev_list
Date: Wed, 06 Sep 2006 14:51:06 -0700
Message-ID: <7vy7sw64vp.fsf@assigned-by-dhcp.cox.net>
References: <11575480921132-git-send-email-jnareb@gmail.com>
	<11575761821830-git-send-email-jnareb@gmail.com>
	<Pine.LNX.4.64.0609061404490.27779@g5.osdl.org>
	<edndud$csb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 23:51:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL5IU-0005aT-FV
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 23:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWIFVu7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 17:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWIFVu7
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 17:50:59 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:27321 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932125AbWIFVu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 17:50:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060906215057.SBIS12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Sep 2006 17:50:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id K9qy1V00M1kojtg0000000
	Wed, 06 Sep 2006 17:50:58 -0400
In-Reply-To: <edndud$csb$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	06 Sep 2006 23:18:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26566>

Jakub Narebski <jnareb@gmail.com> writes:

> Linus Torvalds wrote:
>
>> But I guess for gitweb, you do want to use --full-history in this case ;(
>
> It is now easy with patch 3/7 "Use @hist_opts as git-rev-list parameters in
> git_history" to remove '--full-history' from git-rev-list parameters in
> git_history subroutine.

Well, generating not-so-useful output fast is, eh, not-so-useful
anyway, so being able to add or not add to the set of options on
a whim is not so much of value.  The real value lies in deciding
if it is needed (and I think --full-history is needed for gitweb)
and if so coming up with a way to get the same result with
cheaper operations.
