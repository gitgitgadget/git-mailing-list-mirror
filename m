From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/9] Fix processing of a patch file which modifies the same file in git-apply.
Date: Sun, 28 Aug 2005 14:06:33 -0700
Message-ID: <7v64tplqjq.fsf@assigned-by-dhcp.cox.net>
References: <1125242667404-git-send-email-robfitz@273k.net>
	<11252426681254-git-send-email-robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 23:07:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9UMR-000298-I2
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 23:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVH1VGg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 17:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVH1VGg
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 17:06:36 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:34805 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750805AbVH1VGf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 17:06:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050828210635.QYUT12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 Aug 2005 17:06:35 -0400
To: Robert Fitzsimons <robfitz@273k.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7886>

Robert Fitzsimons <robfitz@273k.net> writes:

> A patch file (or stdin) which modifies the same file more then once
> will fail to apply the patch correctly.  In the worst case it will
> apply some of the patch and leave an invalid output file(s).

I am not sure if this is solving the right problem.  A patch
that touches the same file more than once is hard to review and
I think we should be discouraging the users to do so.  The same
comment goes for [PATCH 4/9].
