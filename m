From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Default "tar" umask..
Date: Sun, 07 Jan 2007 16:20:36 +0100
Message-ID: <m3irfizwvv.fsf@defiant.localdomain>
References: <Pine.LNX.4.64.0612301037570.4473@woody.osdl.org>
	<7vfyaxjiaj.fsf@assigned-by-dhcp.cox.net>
	<459EB78B.60000@lsrfire.ath.cx>
	<7vzm8xdw3t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701051336000.3661@woody.osdl.org>
	<7vmz4xdssh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 16:20:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3ZpC-0005k0-My
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 16:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbXAGPUj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 10:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbXAGPUi
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 10:20:38 -0500
Received: from khc.piap.pl ([195.187.100.11]:48032 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932574AbXAGPUi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 10:20:38 -0500
X-Greylist: delayed 823 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 10:20:38 EST
Received: by khc.piap.pl (Postfix, from userid 500)
	id 87FA9CA83; Sun,  7 Jan 2007 16:20:36 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz4xdssh.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Fri, 05 Jan 2007 14:15:26 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36173>

Junio C Hamano <junkio@cox.net> writes:

> If the archive is made with 022, that would
> break expectation of users whose umask is 002 (a sane value in
> modern "own" group setups).

What exactly do they expect from 002? That root group will be able
to write to the files?

002 umasks and per-user groups were created, IIRC, purely as as ACL
substitute. I wonder how many people really need anything like
that, especially human people (not news.news things and root.uucp
/dev/ttyS*). I guess not very many.
-- 
Krzysztof Halasa
