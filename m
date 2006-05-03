From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem using GIT CVS-server
Date: Wed, 03 May 2006 14:21:22 -0700
Message-ID: <7vmzdyby99.fsf@assigned-by-dhcp.cox.net>
References: <445865A5.5030700@lumumba.uhasselt.be>
	<46a038f90605030311s4e05de2dr90277f97a3a5c223@mail.gmail.com>
	<46a038f90605030411o29af1d1bra3276353347516f6@mail.gmail.com>
	<7v1wvaevno.fsf@assigned-by-dhcp.cox.net>
	<46a038f90605031412s363b4a79p548c75956b00adbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 23:21:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbOml-0005v1-BK
	for gcvg-git@gmane.org; Wed, 03 May 2006 23:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWECVVY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 17:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWECVVY
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 17:21:24 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:46506 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751355AbWECVVY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 17:21:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060503212123.DLDG19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 May 2006 17:21:23 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605031412s363b4a79p548c75956b00adbf@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 4 May 2006 09:12:39 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19521>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

>> Could you see if the attached patch helps?
>
> Will try it in a moment. Having thought about it, git-log is always
> going to be tweaked for human consumption, so I should use something
> geared for porcelains instead. git-rev-list does honour --parent, so
> perhaps I should switch to using that instead?

I think that reasoning is prudent, but at the same time I think
the patch by Linus is also right, so I think we should do both
for this particular case.

Sorry about the breakage.
