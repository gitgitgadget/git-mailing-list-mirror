From: Junio C Hamano <junkio@cox.net>
Subject: Re: Last mile to 1.0?
Date: Sat, 16 Jul 2005 17:49:57 -0700
Message-ID: <7vy8869ryi.fsf@assigned-by-dhcp.cox.net>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
	<m18y06pphg.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 02:50:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtxMD-0005zL-Qg
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 02:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVGQAuA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 20:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVGQAuA
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 20:50:00 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:50389 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261193AbVGQAt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 20:49:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050717004957.PPJQ22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Jul 2005 20:49:57 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m18y06pphg.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's message of "Sat, 16 Jul 2005 12:36:43 -0600")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Junio C Hamano <junkio@cox.net> writes:
>>
>>    - Anonymous pull from packed archives on remote sites via
>>      non-rsync, non-ssh transport.  ...
>>      ... but we may also end up wanting something HTTP
>>      reachable.
>
> For this we need a cgi script that will generate an appropriate
> pack.

I agree that nothing would beat a pack customized for each
puller from the bandwidth point of view.  I like the general
idea of git-daemon Linus did and the cgi script you suggest, but
I wonder what the CPU/disk load implications for the server.
