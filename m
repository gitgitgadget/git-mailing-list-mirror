From: Junio C Hamano <junkio@cox.net>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 14:43:35 -0800
Message-ID: <7vodzsq12g.fsf@assigned-by-dhcp.cox.net>
References: <20060326014946.GB18185@pasky.or.cz>
	<Pine.LNX.4.64.0603251919170.15714@g5.osdl.org>
	<44264426.8010608@michonline.com> <20060326014946.GB18185@pasky.or.cz>
	<Pine.LNX.4.64.0603251919170.15714@g5.osdl.org>
	<20060326100717.GD18185@pasky.or.cz>
	<Pine.LNX.4.64.0603260829550.15714@g5.osdl.org>
	<20060326191445.GQ18185@pasky.or.cz>
	<Pine.LNX.4.64.0603261415390.15714@g5.osdl.org>
	<20060326223154.GU18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Mar 27 00:43:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNdxU-0005zZ-Hk
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 00:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWCZWni (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 17:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWCZWni
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 17:43:38 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:56195 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932155AbWCZWnh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Mar 2006 17:43:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060326224336.SLJY3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Mar 2006 17:43:36 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060326223154.GU18185@pasky.or.cz> (Petr Baudis's message of
	"Mon, 27 Mar 2006 00:31:54 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18064>

Petr Baudis <pasky@suse.cz> writes:

>> No, it's the expected output just because you expected merges to always 
>> show up. Merges get ignored if any of the parents have the same content 
>> already.
>
> Eek. Can I avoid that? What was the reason for choosing this behavior?

Perhaps rev-list --sparse?
