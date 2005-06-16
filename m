From: Paul Mackerras <paulus@samba.org>
Subject: Re: reducing line crossings in gitk
Date: Thu, 16 Jun 2005 22:26:35 +1000
Message-ID: <17073.28667.819809.89026@cargo.ozlabs.ibm.com>
References: <17066.53047.660907.453399@cargo.ozlabs.ibm.com>
	<7v8y1gvjfz.fsf@assigned-by-dhcp.cox.net>
	<17072.3723.242985.824999@cargo.ozlabs.ibm.com>
	<2cfc40320506150534380bb5f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 14:35:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dita2-0006rJ-VG
	for gcvg-git@gmane.org; Thu, 16 Jun 2005 14:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVFPMjy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Jun 2005 08:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVFPMjy
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jun 2005 08:39:54 -0400
Received: from ozlabs.org ([203.10.76.45]:19900 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261667AbVFPMju (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2005 08:39:50 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8B5CA67B8F; Thu, 16 Jun 2005 22:39:48 +1000 (EST)
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc40320506150534380bb5f8@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jon Seymour writes:

> Another feature that would be handy is the ability to be able to
> create tags by pointing to an item and selecting a "create-tag"
> action. The effect would be to write the SHA1 id into
> GIT_DIR/refs/tags in the expected way.

Hmmm, that would create a "direct" tag, not a normal tag, which is
an object of type "tag" that contains a reference to a commit along
with some other stuff.

In general I'd like to keep gitk as purely a viewer.  Ultimately I'll
probably do a graphical tool for checking stuff in and other
operations that modify the repository as well, but I think that should
be a separate tool.

Regards,
Paul.
