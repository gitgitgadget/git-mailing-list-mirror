From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] daemon whitelist handling (Re: git pull aborts in 50% of cases)
Date: Sat, 03 Dec 2005 13:28:07 -0800
Message-ID: <7vmzjhvpjs.fsf@assigned-by-dhcp.cox.net>
References: <20051202190412.GA10757@mipter.zuzino.mipt.ru>
	<43909963.60901@zytor.com>
	<20051202211250.GA11384@mipter.zuzino.mipt.ru>
	<4390B64E.20601@zytor.com>
	<Pine.LNX.4.63.0512030316520.19086@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vu0dq29wg.fsf@assigned-by-dhcp.cox.net> <43911D9E.5030803@zytor.com>
	<7vpsoezf6y.fsf@assigned-by-dhcp.cox.net>
	<7vzmnivuz8.fsf_-_@assigned-by-dhcp.cox.net>
	<4391F4DD.2060002@zytor.com>
	<Pine.LNX.4.64.0512031156070.3099@g5.osdl.org>
	<7vslt9vpxo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 03 22:29:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eievb-000366-Im
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 22:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVLCV2N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 16:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVLCV2N
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 16:28:13 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:20664 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750947AbVLCV2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2005 16:28:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051203212633.RLPB20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Dec 2005 16:26:33 -0500
To: git@vger.kernel.org
In-Reply-To: <7vslt9vpxo.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 03 Dec 2005 13:19:47 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13169>

Junio C Hamano <junkio@cox.net> writes:

Trivial typo.

>    - If a whitelist entry "/pub/scm" was matched against a
>      request "/pub/scm/git/git.git", it checks /pub/scm/git and
>      /pub/scm/git.git

Obviously "/pub/scm/git" and "/pub/scm/git/git.git" are the ones
that are checked here.  Whitelist "/pub/scm" means "/pub/scm
and under, and the administrator knows /pub or /pub/scm may be
symlinks pointing at places he wants them to, so do not check
and complain where they point at".
