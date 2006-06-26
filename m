From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH] cast pid_t to long for printing
Date: Mon, 26 Jun 2006 14:13:25 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060626121325.GA19314@informatik.uni-freiburg.de>
References: <20060626080912.GA3646@informatik.uni-freiburg.de> <20060626082606.GC3646@informatik.uni-freiburg.de> <7vr71ci7yt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 14:13:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fupy8-0006Dq-0z
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 14:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWFZMN1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 08:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWFZMN1
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 08:13:27 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:2792 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751043AbWFZMN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 08:13:27 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1Fupy1-0006ff-JR; Mon, 26 Jun 2006 14:13:25 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k5QCDPD19953;
	Mon, 26 Jun 2006 14:13:25 +0200 (MEST)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vr71ci7yt.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22673>

Junio C Hamano wrote:
> Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:
> 
> > While fixing daemon.c, I saw that there is a call to syslog using %d for
> > pid_t, too.  I fixed that in the same way without further testing and
> > manual reading. I assume that's OK.
> 
> Is anybody using pid_t that is wider than int?  IOW, I wonder if
> it would make more sense to use "%d" with casting to int.
See types(3HEAD) e.g. on 

	http://docs.sun.com/app/docs/doc/816-5173/6mbb8ae36?a=view

So it's always as long as int, but it is defined as long...

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=gravity+on+earth%3D
