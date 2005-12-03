From: Junio C Hamano <junkio@cox.net>
Subject: Re: How can I specify a non-standard TCP port for a git+ssh connection?
Date: Sat, 03 Dec 2005 11:09:46 -0800
Message-ID: <7vwtimxait.fsf@assigned-by-dhcp.cox.net>
References: <20051202193101.29853.qmail@science.horizon.com>
	<20051203080620.GA22032@andaco.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 20:10:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eicld-0002Mm-BV
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 20:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVLCTJs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 14:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVLCTJs
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 14:09:48 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:42672 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932157AbVLCTJs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2005 14:09:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051203190821.FSNI17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Dec 2005 14:08:21 -0500
To: Andreas Jochens <aj@andaco.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13158>

Andreas Jochens <aj@andaco.de> writes:

> This is a nice feature, of course. But I still have to edit a separate 
> config file. In some cases (e.g. scripts using ad hoc port forwarding) it 
> would be much easier if the non-standard port and maybe some other
> options could be specified directly on the git command line or 

Having something on the command line to make it easy to override
one-shot you might be able to talk me into, but not in a config
file for git; there is a standard place to hold ssh
configuration already.
