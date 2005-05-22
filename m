From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-files -z output
Date: Sun, 22 May 2005 10:49:28 -0700
Message-ID: <7vwtprduc7.fsf@assigned-by-dhcp.cox.net>
References: <20050522170540.GO15178@cip.informatik.uni-erlangen.de>
	<7v3bsffadn.fsf@assigned-by-dhcp.cox.net>
	<20050522172737.GB17570@cip.informatik.uni-erlangen.de>
	<20050522173243.GA18500@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 19:52:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZuZ3-0004Hs-Gy
	for gcvg-git@gmane.org; Sun, 22 May 2005 19:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVEVRtv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 13:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVEVRtv
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 13:49:51 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:65007 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261556AbVEVRta (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 13:49:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050522174930.WHTJ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 May 2005 13:49:30 -0400
To: GIT <git@vger.kernel.org>
In-Reply-To: <20050522173243.GA18500@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Sun, 22 May 2005 19:32:43 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

I do not do Porcelain, but...

TG> this is better (it strips the colon from the first mode):

I think you are also stripping the colon at the beginning of the
filename if I am not mistaken.  Also posting only this part is
not very useful because I cannot tell what parameter this sub is
being fed.  I am presuming that you are either feeding a single
line from DIFF_FORMAT_HUMAN format output, or three lines
(unless dealing with 'U' entry in which case you have to do only
a single line) from DIFF_FORMAT_MACHINE format output.  When in
doubt, seeing what diff-helper does would help.

