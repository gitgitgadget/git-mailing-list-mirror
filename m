From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb: latest blob date (request)
Date: Mon, 16 Jan 2006 09:55:12 -0800
Message-ID: <7vbqyct5vj.fsf@assigned-by-dhcp.cox.net>
References: <20060115173100.1134256b.rdunlap@xenotime.net>
	<17355.10749.834774.642712@cargo.ozlabs.ibm.com>
	<20060115211011.17b18f60.rdunlap@xenotime.net>
	<20060116174444.GA13512@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 18:55:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyYZb-00042C-T4
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 18:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWAPRzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 12:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWAPRzP
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 12:55:15 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18827 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750770AbWAPRzO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 12:55:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060116175355.NTIX20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 Jan 2006 12:53:55 -0500
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20060116174444.GA13512@vrfy.org> (Kay Sievers's message of "Mon,
	16 Jan 2006 18:44:44 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14749>

Kay Sievers <kay.sievers@vrfy.org> writes:

> Hmm, where do I find this information? It is recorded in last commit,
> that changed the file, right? I'm not sure, if we can get this out of
> the git tools?

Yes we can.  But it is rather expensive.  You would do an
equivalent of "git whatchanged" for each and every path.

Of course commit chain is immutable so you could do this once
and cache the results.
