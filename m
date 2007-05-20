From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] cvsserver: Don't send mixed messages to clients
Date: Sun, 20 May 2007 02:45:43 +0200
Message-ID: <20070520004543.GF4085@planck.djpig.de>
References: <1179078545517-git-send-email-frank@lichtenheld.de> <7vd514sg0g.fsf@assigned-by-dhcp.cox.net> <46a038f90705132338r12f70599m5845ffce31c945cf@mail.gmail.com> <20070514131528.GC5272@planck.djpig.de> <7vmz07m6wy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 02:45:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpZYY-0007rY-QW
	for gcvg-git@gmane.org; Sun, 20 May 2007 02:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504AbXETAps (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 20:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756622AbXETAps
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 20:45:48 -0400
Received: from planck.djpig.de ([85.10.192.180]:2128 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756504AbXETApr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 20:45:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 88B6588060;
	Sun, 20 May 2007 02:45:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GqdJg8SEBDJT; Sun, 20 May 2007 02:45:44 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 0952D88105; Sun, 20 May 2007 02:45:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vmz07m6wy.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47788>

On Mon, May 14, 2007 at 02:28:29PM -0700, Junio C Hamano wrote:
> Frank Lichtenheld <frank@lichtenheld.de> writes:
> > For the record, cvs (server side) does the following in this particular situation:
> > 	buf_output0 (buf_to_net, "I HATE YOU\n");
> >         buf_flush (buf_to_net, true);
> >
> >         /* Don't worry about server_cleanup, server_active isn't set
> >            yet.  */
> >         exit (EXIT_FAILURE);
> 
> Ok, I stand corrected.  If there is a pattern to emulate, that
> should be found in the real cvs server.

Will you correct the patch then back to my version? master still has
your version of it AFAICT.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
