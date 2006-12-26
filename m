From: Junio C Hamano <junkio@cox.net>
Subject: Re: private file add/checkout
Date: Mon, 25 Dec 2006 18:16:20 -0800
Message-ID: <7vk60fieq3.fsf@assigned-by-dhcp.cox.net>
References: <4590822C.3070206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 03:16:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gz1ro-0006Ox-0u
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 03:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWLZCQW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 21:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWLZCQW
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 21:16:22 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:50486 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbWLZCQV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 21:16:21 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061226021621.PNJG25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Mon, 25 Dec 2006 21:16:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3EGa1W00o1kojtg0000000; Mon, 25 Dec 2006 21:16:35 -0500
To: SungHyun Nam <goweol@gmail.com>
In-Reply-To: <4590822C.3070206@gmail.com> (SungHyun Nam's message of "Tue, 26
	Dec 2006 11:00:12 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35405>

SungHyun Nam <goweol@gmail.com> writes:

> Though I set 'shared=false' or umask=0077,
> I cannot add a file with mode=0600.
> GIT always added it as mode=0644.
> How I can add/checkout a file with mode=0600?
> Is it impossible?

Git is about source code control and uses file mode only for
executable bits.
