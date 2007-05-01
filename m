From: Alexander Klink <ak-git@cynops.de>
Subject: Re: git-svn failure when symlink added in svn
Date: Tue, 1 May 2007 22:53:04 +0200
Message-ID: <20070501.8cc6c8feecd24d6cb7e7b7907dec9cb2@cynops.de>
References: <loom.20070428T144858-521@post.gmane.org> <7virbgjthr.fsf@assigned-by-dhcp.cox.net> <m2odl8fjv1.fsf@ziti.fhcrc.org> <7v7irwjql6.fsf@assigned-by-dhcp.cox.net> <m2k5vwfbf6.fsf@ziti.fhcrc.org> <7vwszwi0h2.fsf@assigned-by-dhcp.cox.net> <20070429183136.GE12375@untitled> <7vr6q2dhex.fsf@assigned-by-dhcp.cox.net> <20070429222136.GA1800@untitled> <7vmz0qcuut.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Seth Falcon <sethfalcon@gmail.com>,
	Alexander Klink <ak-git@cynops.de>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 22:54:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HizMU-0000PH-St
	for gcvg-git@gmane.org; Tue, 01 May 2007 22:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946021AbXEAUxl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 16:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946015AbXEAUxk
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 16:53:40 -0400
Received: from cynops.de ([82.149.225.69]:53417 "EHLO mail.cynops.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946010AbXEAUxj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 16:53:39 -0400
Received: from cy10loc.cynops.de (cy10loc [172.16.0.10])
	by mail.cynops.de (Postfix) with ESMTP id 3EBA86C89F;
	Tue,  1 May 2007 22:53:36 +0200 (CEST)
Received: from localhost (unknown [172.16.0.6])
	by cy10loc.cynops.de (Postfix) with ESMTP id BF5C4C8041;
	Tue,  1 May 2007 22:53:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vmz0qcuut.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45977>

On Sun, Apr 29, 2007 at 10:08:26PM -0700, Junio C Hamano wrote:
> -- >8 --
> [PATCH] Fix symlink handling in git-svn, related to PerlIO
> 
[...]
> This attempts to fix the issue by using lower level sysseek and
> sysread instead of seek and read to bypass the stdio buffer.
Works fine here, too. Thanks again for the quick response ...

Regards,
    Alex
