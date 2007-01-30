From: Junio C Hamano <junkio@cox.net>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Tue, 30 Jan 2007 10:11:24 -0800
Message-ID: <7v8xfkz8oj.fsf@assigned-by-dhcp.cox.net>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Mike Coleman" <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 19:11:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBxSB-00033z-VH
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 19:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbXA3SLb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 13:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbXA3SLa
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 13:11:30 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:36472 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030194AbXA3SL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 13:11:29 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070130181128.ERVP20530.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Tue, 30 Jan 2007 13:11:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HWAR1W00G1kojtg0000000; Tue, 30 Jan 2007 13:10:25 -0500
In-Reply-To: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
	(Mike Coleman's message of "Tue, 30 Jan 2007 10:20:30 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38178>

"Mike Coleman" <tutufan@gmail.com> writes:

> Hi,

Hi, Mike.

I won't go into "comparison", and I know some people will fill
the details in other things

> 5.  I think I read that there'd been just one incompatible change over
> time in the git repo format.  What was it?

There actually were a few incompatible ones but they were only
during the first few weeks of life (the beginning of time is Apr
7th, 2005):

 - The tree object was originally a flat "manifest" but was
   converted to hierarchy of trees (Apr 10th, 2005)

 - The metainformation directory was originally called .dircache,
   but renamedto ".git" (Apr 11th, 2005)

 - The order of compression and hashing was swapped and older
   objects needed conversion (Apr 20, 2005)
