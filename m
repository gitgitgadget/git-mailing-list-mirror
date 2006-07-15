From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: disable the compile-flags-changed check
Date: Sat, 15 Jul 2006 21:51:12 +0200
Message-ID: <E1G1qAS-0005gv-P7@moooo.ath.cx>
References: <E1G1GVy-00007o-PM@moooo.ath.cx> <7v7j2gsotv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 15 21:52:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1qBN-0001yC-Qn
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 21:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWGOTvS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Jul 2006 15:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWGOTvR
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Jul 2006 15:51:17 -0400
Received: from moooo.ath.cx ([85.116.203.178]:31619 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1030258AbWGOTvR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Jul 2006 15:51:17 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7j2gsotv.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23937>

Junio C Hamano <junkio@cox.net> wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> 
> > Is there any way to disable the "the compile flags have changed,
> > recompile everything" check?  I want to built with another prefix than
> > installing to create a tarball I copy to other machines.  Is there any
> > way to do this?
> 
> Perhaps
> 
> 	DESTDIR=/var/tmp/ make prefix=/usr install
> 
> is what you are looking for?
Thanks, this works.
