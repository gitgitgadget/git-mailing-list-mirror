From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] 1st pass at git-annotate (not-quite functional, however)
Date: Mon, 23 Jan 2006 00:24:32 -0800
Message-ID: <7vslrfz70f.fsf@assigned-by-dhcp.cox.net>
References: <20060123080532.GD19212@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 09:24:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0x08-0005Bv-JY
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 09:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWAWIYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jan 2006 03:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWAWIYe
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jan 2006 03:24:34 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:7399 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751427AbWAWIYd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2006 03:24:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060123082228.BZHK17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 Jan 2006 03:22:28 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060123080532.GD19212@mythryan2.michonline.com> (Ryan
	Anderson's message of "Mon, 23 Jan 2006 03:05:33 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15081>

Ryan Anderson <ryan@michonline.com> writes:

> I haven't figured out exactly how I want to handle annotating across
> merges,...

You might want to take a look at the "passing blames around"
algorithm I did for "git blame" loooooooooooooooong time ago.

    http://article.gmane.org/gmane.comp.version-control.git/5483
