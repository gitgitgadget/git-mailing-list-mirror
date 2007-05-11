From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [TRIVIAL] Change default man page path to /usr/share/man
Date: Fri, 11 May 2007 12:44:06 -0700
Message-ID: <7vwszf9md5.fsf@assigned-by-dhcp.cox.net>
References: <200705081349.34964.ismail@pardus.org.tr>
	<200705112025.58095.ismail@pardus.org.tr>
	<7v646zb1p4.fsf@assigned-by-dhcp.cox.net>
	<200705112242.44618.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Fri May 11 21:44:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmb2Y-00039Y-3o
	for gcvg-git@gmane.org; Fri, 11 May 2007 21:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763536AbXEKToN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 11 May 2007 15:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763584AbXEKToM
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 15:44:12 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:40200 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763536AbXEKToJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 May 2007 15:44:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511194408.HYAO22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 15:44:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xvk81W00M1kojtg0000000; Fri, 11 May 2007 15:44:09 -0400
In-Reply-To: <200705112242.44618.ismail@pardus.org.tr> (Ismail =?utf-8?Q?D?=
 =?utf-8?Q?=C3=B6nmez's?=
	message of "Fri, 11 May 2007 22:42:44 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46975>

Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:

> Most(All?) distros /usr/share/man in MANPATH so I believe this
> patch shouldn't break anything but well you have the final
> say. I am ok with doing make mandir=3D/usr/share/man install-doc

My preference is to do this early after 1.5.2.  I do not want to
touch builds with trivial changes before the final.
