From: Paul Mackerras <paulus@samba.org>
Subject: Re: invalid command name "listrefs"
Date: Mon, 12 Jun 2006 09:35:46 +1000
Message-ID: <17548.43218.342840.246792@cargo.ozlabs.ibm.com>
References: <7vu06rfxg8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 01:38:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpZVM-0007ap-Ro
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 01:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWFKXiA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 19:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWFKXiA
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 19:38:00 -0400
Received: from ozlabs.org ([203.10.76.45]:10728 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751131AbWFKXiA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 19:38:00 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1FA1567B73; Mon, 12 Jun 2006 09:37:59 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu06rfxg8.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21675>

Junio,

> Starting gitk, "File->Reread references" results in an error
> dialog.
> 
> This patch resurrects the procedure from an older version, and it
> seems to work for me, but with the updated code it might be that
> you wanted to use a different mechanism to implement rereadrefs
> procedure -- I dunno.

Thanks for pointing that out.  I had removed listrefs in the course of
doing some changes that I later dropped; not reinstating listrefs at
that point was just an oversight.

Paul.
