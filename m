From: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] Cleaned up git-daemon virtual hosting support.
Date: Tue, 26 Sep 2006 08:37:36 -0500
Message-ID: <E1GSD7w-0004dP-1g@jdl.com>
References: <E1GRhhk-0004O6-GP@jdl.com>  <7vd59jw9lb.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 15:39:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSD8G-0006SA-JS
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 15:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWIZNhi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 09:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWIZNhi
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 09:37:38 -0400
Received: from mail.jdl.com ([66.118.10.122]:28563 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1751420AbWIZNhh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 09:37:37 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1GSD7w-0004dP-1g; Tue, 26 Sep 2006 08:37:36 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Your message of "Mon, 25 Sep 2006 21:11:28 PDT."
             <7vd59jw9lb.fsf@assigned-by-dhcp.cox.net> 
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27792>

So, like, the other day Junio C Hamano mumbled:
> > Added --host=host_or_ipaddr option suport.
> 
> I wonder if --listen= might be more appropriate name:

Hmmm...   I had asked it you wanted to incorporate a ":<port>"
notion into the listen address.  Turns out that is a bad idea
since the <host_or_ipaddr> part can also be a IPv6 address
just riddled with colon characters.

I'll just leave it "--listen=<host_or_ipaddr>" and "--port=<n>".

jdl
