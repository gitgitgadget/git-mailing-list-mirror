From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Fw: [PATCH 31/49] PCI: PCI/Cardbus cards hidden, needs pci=assign-busses to fix
Date: Fri, 24 Mar 2006 12:23:26 -0500
Message-ID: <20060324172326.GM26071@mythryan2.michonline.com>
References: <20060323161521.28a874e6.akpm@osdl.org> <20060324002930.GA21184@kroah.com> <20060323163844.5fda7589.akpm@osdl.org> <20060324004654.GA19763@kroah.com> <7vbqvw3a62.fsf@assigned-by-dhcp.cox.net> <20060323175126.7ff71032.akpm@osdl.org> <7v3bh837cs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: greg@kroah.com, git@vger.kernel.org, Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Fri Mar 24 18:24:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMq1a-0007pl-Iv
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 18:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWCXRY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 12:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWCXRY2
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 12:24:28 -0500
Received: from mail.autoweb.net ([198.172.237.26]:40091 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S932387AbWCXRY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 12:24:27 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FMq1P-00055y-PL; Fri, 24 Mar 2006 12:24:25 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FMq1U-00054W-TN; Fri, 24 Mar 2006 12:24:28 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FMq0t-0001ZU-C2; Fri, 24 Mar 2006 12:23:51 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bh837cs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17928>

On Thu, Mar 23, 2006 at 06:27:15PM -0800, Junio C Hamano wrote:
> [PATCH] send-email: Identify author at the top when sending e-mail
> 
> git-send-email was not checking if the sender is the same as the
> patch author.  Follow the "From: at the beginning" convention to
> propagate the patch author correctly.

This looks fine.
My initial thought here was that it might be even simpler to just always
put the From: line in the body, with the patch author's name there, but
this is a bit cleaner, so ACK.

-- 

Ryan Anderson
  sometimes Pug Majere
