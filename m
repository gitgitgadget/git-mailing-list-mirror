From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merging on a dirty tree???
Date: Fri, 16 Mar 2007 03:53:29 -0700
Message-ID: <7vd539v4ra.fsf@assigned-by-dhcp.cox.net>
References: <200703152359.53543.dtor@insightbb.com> <87slc54gb2.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Torokhov <dtor@insightbb.com>,
	Git Mailing List <git@vger.kernel.org>
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 11:53:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSA4B-0003b9-N8
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 11:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbXCPKxc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 16 Mar 2007 06:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753481AbXCPKxc
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 06:53:32 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48324 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477AbXCPKxb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Mar 2007 06:53:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070316105331.SHLM24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Mar 2007 06:53:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bNtW1W00b1kojtg0000000; Fri, 16 Mar 2007 06:53:31 -0400
In-Reply-To: <87slc54gb2.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Fri, 16
	Mar 2007 11:46:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42347>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> From: "Santi B=C3=A9jar" <sbejar@gmail.com>
> Subject: [PATCH] git-merge: finish when git-read-tree fails
>
> The message formating (commit v1.5.0.3-28-gbe242d5) broke the && chai=
n.
>
> Noticed by Dmitry Torokhov.
>
> Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>

Gaah.  Thanks, well spotted.

That makes v1.5.0.4 a dud.
