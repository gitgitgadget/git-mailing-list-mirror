From: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] Cleaned up git-daemon virtual hosting support.
Date: Tue, 26 Sep 2006 08:12:54 -0500
Message-ID: <E1GSCk2-0004b4-4L@jdl.com>
References: <E1GRhhk-0004O6-GP@jdl.com>  <7vd59jw9lb.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 15:13:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSCk6-0000Io-QM
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 15:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWIZNM4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 09:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWIZNM4
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 09:12:56 -0400
Received: from colo.jdl.com ([66.118.10.122]:22931 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1751166AbWIZNMz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 09:12:55 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1GSCk2-0004b4-4L; Tue, 26 Sep 2006 08:12:54 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Your message of "Mon, 25 Sep 2006 21:11:28 PDT."
             <7vd59jw9lb.fsf@assigned-by-dhcp.cox.net> 
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27791>

So, like, the other day Junio C Hamano mumbled:
> > Added --host=host_or_ipaddr option suport.
> 
> I wonder if --listen= might be more appropriate name:
>         "Listen a.b.c.d:port" (Apache),

No problem.  I'll respin that to use

    --listen=<ip_or_host>

Do you want this?:

    --listen=[<ip_or_host>][:<port>]

And if you do, does --port= just go away, fade away, or remain?

Would you prefer patch-on-patch or respin?

jdl
