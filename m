From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use backticks instead of $(command) to maintain /bin/sh
 compatibility
Date: Sat, 07 May 2005 11:38:02 -0700
Message-ID: <7vy8aqanlh.fsf@assigned-by-dhcp.cox.net>
References: <20050507084549.GF23680@cip.informatik.uni-erlangen.de>
	<7v3bszbeoo.fsf@assigned-by-dhcp.cox.net>
	<20050507090543.GG23680@cip.informatik.uni-erlangen.de>
	<20050507100348.GA16461@outpost.ds9a.nl>
	<20050507101530.GH23680@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat May 07 20:32:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUU5B-0002Nh-6R
	for gcvg-git@gmane.org; Sat, 07 May 2005 20:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVEGSiG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 14:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbVEGSiG
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 14:38:06 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:19197 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262729AbVEGSiE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 14:38:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050507183803.SFG1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 May 2005 14:38:03 -0400
To: GIT <git@vger.kernel.org>
In-Reply-To: <20050507101530.GH23680@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Sat, 7 May 2005 12:15:30 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

TG> Hello,
>> You can nest $() which is valuable, unlike backtics.

TG> we're aware of this. But the specific script works perfectly fine
TG> without nested simple-command redirection. So what is your point?

If that is the case then I think the patch you posted to force
bash is backwards.  How about changing it to use backticks?

