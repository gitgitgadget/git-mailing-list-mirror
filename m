From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-clean fails on files beginning with a dash
Date: Tue, 30 May 2006 01:49:41 -0700
Message-ID: <7vd5dv3niy.fsf@assigned-by-dhcp.cox.net>
References: <20060529150632.G6794bab6@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 10:49:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkzv8-0004f5-UK
	for gcvg-git@gmane.org; Tue, 30 May 2006 10:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWE3Itn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 04:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWE3Itn
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 04:49:43 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:18414 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932184AbWE3Itm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 04:49:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060530084942.PYKF5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 May 2006 04:49:42 -0400
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060529150632.G6794bab6@leonov.stosberg.net> (Dennis Stosberg's
	message of "Mon, 29 May 2006 17:06:32 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21023>

Dennis Stosberg <dennis@stosberg.net> writes:

> Reproducible with:
>
> $ git init-db
> $ echo "some text" >-file
> $ git clean
> Removing -file
> rm: invalid option -- l
> Try `rm --help' for more information.

Thanks.
