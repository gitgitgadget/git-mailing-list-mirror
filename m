From: Junio C Hamano <junkio@cox.net>
Subject: Re: how to display file history?
Date: Sun, 14 May 2006 23:42:28 -0700
Message-ID: <7v64k7wzzf.fsf@assigned-by-dhcp.cox.net>
References: <CFF307C98FEABE47A452B27C06B85BB670F4FD@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 08:42:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfWmm-0001r7-LM
	for gcvg-git@gmane.org; Mon, 15 May 2006 08:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWEOGma (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 02:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWEOGma
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 02:42:30 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:1158 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932318AbWEOGm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 02:42:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515064228.TKTR27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 02:42:28 -0400
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB670F4FD@hdsmsx411.amr.corp.intel.com>
	(Len Brown's message of "Mon, 15 May 2006 02:13:30 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20029>

"Brown, Len" <len.brown@intel.com> writes:

>  
>>	git whatchanged A
>
> thanks.  I've used this on entire repos before, but
> for some reason didn't think of this command name
> when looking for individual file history.

Probably with recent enough git, one of

	git log --stat -- A
	git log -p -- A
	git log -p --full-diff -- A

might be more pleasant, depending on what you are trying to look
for.

"A" can be a single file, more than one files, a directory,...
