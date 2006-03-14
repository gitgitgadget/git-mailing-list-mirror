From: Junio C Hamano <junkio@cox.net>
Subject: Re: What should I use instead of git show?
Date: Mon, 13 Mar 2006 19:09:48 -0800
Message-ID: <7vr755oh6r.fsf@assigned-by-dhcp.cox.net>
References: <20060313144747.GA81092@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 14 04:10:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIzv0-00065G-Mo
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 04:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWCNDJu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 22:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWCNDJu
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 22:09:50 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:17108 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932477AbWCNDJu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 22:09:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060314030810.COSJ20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Mar 2006 22:08:10 -0500
To: Olivier Galibert <galibert@pobox.com>
In-Reply-To: <20060313144747.GA81092@dspnet.fr.eu.org> (Olivier Galibert's
	message of "Mon, 13 Mar 2006 15:47:48 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17584>

Olivier Galibert <galibert@pobox.com> writes:

> Up until now, when I wanted to send a patch to someone with the
> associated changelog, I just did a git log to find the changelog sha1
> then a git show to get the goods.  How am I supposed to do that now?

"git show" is fine and it is still there, but there is a command
designed specifically for that purpose: format-patch.
