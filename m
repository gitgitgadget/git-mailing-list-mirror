From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-pack segfaulting on DebianPPC
Date: Wed, 19 Oct 2005 17:03:52 -0700
Message-ID: <7v8xwpxdef.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510190202n60101c5cgf27bd714dce00513@mail.gmail.com>
	<Pine.LNX.4.64.0510190724000.3369@g5.osdl.org>
	<46a038f90510191356w56b78413p6b9fe5b67fc9ee74@mail.gmail.com>
	<20051019223743.GQ30889@pasky.or.cz>
	<46a038f90510191623k4f1a7267m50d3bbbd6665a2a3@mail.gmail.com>
	<20051019235208.GR30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 02:05:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESNud-0000be-DP
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 02:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbVJTADy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 20:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbVJTADy
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 20:03:54 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:52118 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751647AbVJTADx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 20:03:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051020000341.CREN1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 20:03:41 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051019235208.GR30889@pasky.or.cz> (Petr Baudis's message of
	"Thu, 20 Oct 2005 01:52:08 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10326>

Petr Baudis <pasky@suse.cz> writes:

> Hmm, what bash version are you using? It's enclosed in
>
> 	for tag in *
>
> and perhaps your bash misunderstood.

It probably is your cat not quoting $tag, which you just fixed.
Martin's repo has a conversion from CVS, with bunch of tags
whose names are like "Foo **INVALID**" (that's whitespace and
asterisks).
