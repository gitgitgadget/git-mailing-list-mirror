From: Junio C Hamano <junkio@cox.net>
Subject: Re: diff-tree and does not respect grafts
Date: Mon, 21 Nov 2005 14:12:31 -0800
Message-ID: <7v4q65odkg.fsf@assigned-by-dhcp.cox.net>
References: <87lkzi1aio.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 23:17:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeJuT-0006Yj-9N
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 23:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVKUWMg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 Nov 2005 17:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVKUWMf
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 17:12:35 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:47868 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751126AbVKUWMe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 17:12:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121221234.KQJI25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 17:12:34 -0500
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <87lkzi1aio.fsf@gmail.com> (Santi =?iso-8859-1?Q?B=E9jar's?=
 message of "Mon, 21
	Nov 2005 12:54:39 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12496>

Santi B=E9jar <sbejar@gmail.com> writes:

>         diff-tree decode directly the commit, so it does not take int=
o
>         account the graft file. Is this the expected behaviour?

Expected?  Yes, only because I happen to know diff-tree was
written way before grafts are invented and nobody bothered to
change that behaviour.  Desireable?  Probably not.
