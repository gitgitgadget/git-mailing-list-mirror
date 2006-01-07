From: Junio C Hamano <junkio@cox.net>
Subject: Re: needs merge
Date: Sat, 07 Jan 2006 00:41:34 -0800
Message-ID: <7v1wzko2f5.fsf@assigned-by-dhcp.cox.net>
References: <200601070332.36654.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 09:41:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev9dr-0007qC-UY
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 09:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWAGIlh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 03:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWAGIlh
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 03:41:37 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:55691 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030361AbWAGIlh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 03:41:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107084044.SOLW15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 03:40:44 -0500
To: Len Brown <len.brown@intel.com>
In-Reply-To: <200601070332.36654.len.brown@intel.com> (Len Brown's message of
	"Sat, 7 Jan 2006 03:32:36 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14244>

Len Brown <len.brown@intel.com> writes:

> $ git commit
> my-file needs merge
>
> how do i tell git that there is no merge to do and the (unchanged) working file is what
> i want to keep as the result of the merge?

Do you mean running

    $ git update-index my-file

to mark the path resolved?
