From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-pull - strange (copy/rename) messages ?!
Date: Tue, 01 Nov 2005 15:24:32 -0800
Message-ID: <7vu0ew6jf3.fsf@assigned-by-dhcp.cox.net>
References: <43678C73.1080601@excelsior-online.org>
	<Pine.LNX.4.64.0511010801370.27915@g5.osdl.org>
	<7vbr149sbs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511011646070.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 00:25:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX5Un-0002hR-Tg
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 00:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbVKAXYi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 18:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbVKAXYh
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 18:24:37 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:52393 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751429AbVKAXYg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 18:24:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051101232342.DWQO2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Nov 2005 18:23:42 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511011646070.25300@iabervon.org> (Daniel
	Barkalow's message of "Tue, 1 Nov 2005 17:03:26 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10968>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I think it's more confusing for the system to report Z differently from 
> other things, because there's nothing special about what it found, except 
> that Z happens to be last.

What would we get for a simple "mv A B and nothing else" case if
we follow your proposal and Pasky's?  What about "cp A B and
nothing else" case?
