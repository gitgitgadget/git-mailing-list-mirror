From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk strangeness..
Date: Mon, 27 Mar 2006 21:38:47 -0800
Message-ID: <7vmzfbm8m0.fsf@assigned-by-dhcp.cox.net>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603271802030.15714@g5.osdl.org>
	<17448.40941.256361.866229@cargo.ozlabs.ibm.com>
	<7vr74nmg7e.fsf@assigned-by-dhcp.cox.net>
	<17448.48143.764989.649462@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 07:38:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO6uu-0008OS-6v
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 07:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWC1Fiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 00:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWC1Fiu
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 00:38:50 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:56275 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751344AbWC1Fit (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 00:38:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060328053848.WDET20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Mar 2006 00:38:48 -0500
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17448.48143.764989.649462@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Tue, 28 Mar 2006 15:31:11 +1100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18109>

Paul Mackerras <paulus@samba.org> writes:

> Would it be possible to put the '-' in only for the last child that
> has that parent?

Not trivially.  We do not keep track of who are children of a
commit.
