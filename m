From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk highlight feature
Date: Wed, 3 May 2006 10:17:01 +1000
Message-ID: <17495.63101.163740.649150@cargo.ozlabs.ibm.com>
References: <17495.61142.677439.171773@cargo.ozlabs.ibm.com>
	<7vejzcj8da.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 02:17:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb53I-0001PM-Fg
	for gcvg-git@gmane.org; Wed, 03 May 2006 02:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWECARI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 20:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWECARI
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 20:17:08 -0400
Received: from ozlabs.org ([203.10.76.45]:7114 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965051AbWECARH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 20:17:07 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id BE00267B82; Wed,  3 May 2006 10:17:06 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejzcj8da.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19448>

Junio C Hamano writes:

> Eh, the string entered by me is quoted by the program, or do I
> have to quote it myself?  I suspect it should not be so bad to
> code, even if you have to do it with tcl ;-).

It's split up into arguments at whitespace unless the whitespace is
quoted, just like the shell does.  I wrote tcl code to do the
splitting and quoting according to the shell rules.  So you can, for
example, put:

	--unpacked --since='2 days ago'

in there and it will pass two arguments to git-rev-list, the second
containing the embedded spaces (but without the single-quotes).

Paul.
