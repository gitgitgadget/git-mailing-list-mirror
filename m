From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git branching & pulling
Date: Fri, 18 May 2007 23:00:51 -0700
Message-ID: <7v8xblz71o.fsf@assigned-by-dhcp.cox.net>
References: <d4cf37a60705182240s414243a6wae69d26f70f64dd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Wink Saville" <wink@saville.com>
X-From: git-owner@vger.kernel.org Sat May 19 08:01:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpHzu-0001pd-Ou
	for gcvg-git@gmane.org; Sat, 19 May 2007 08:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbXESGAx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 02:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755345AbXESGAx
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 02:00:53 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:36386 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbXESGAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 02:00:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519060052.GAWP15717.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 02:00:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0u0r1X00D1kojtg0000000; Sat, 19 May 2007 02:00:52 -0400
In-Reply-To: <d4cf37a60705182240s414243a6wae69d26f70f64dd5@mail.gmail.com>
	(Wink Saville's message of "Fri, 18 May 2007 22:40:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47720>

"Wink Saville" <wink@saville.com> writes:

> Could someone give me some insight or point me at a url or doc
> that could shed some light on what is happening and why git-pull
> doesn't work on kvm.git.

DEFAULT BEHAVIOUR section of

    http://www.kernel.org/pub/software/scm/git/docs/git-pull.html 

would be the place to start.  Recent git-clone (post 1.5.0, I think)
prepares the following configuration variables for you by default:

        remote.origin.url
        remote.origin.fetch
	branch.master.remote
        branch.master.merge

but repositories created by older git-clone didn't.
