From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use =20 when rfc2047 encoding spaces.
Date: Sat, 02 Jun 2007 11:51:52 -0700
Message-ID: <7vd50eqjef.fsf@assigned-by-dhcp.cox.net>
References: <11807320922292-git-send-email-hoegsberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <hoegsberg@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 20:52:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuYhn-0000dO-Kb
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 20:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbXFBSvz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 2 Jun 2007 14:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756531AbXFBSvz
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 14:51:55 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:49801 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268AbXFBSvy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jun 2007 14:51:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070602185152.IHLP5800.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 2 Jun 2007 14:51:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6irt1X00C1kojtg0000000; Sat, 02 Jun 2007 14:51:54 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48946>

Kristian H=C3=B8gsberg <hoegsberg@gmail.com> writes:

> Encode ' ' using '=3D20' even though rfc2047 allows using '_' for
> readability..

Thanks.

Your message was marked as iso-8859-1 even though it was utf-8
(your signed-off-by line), so I'll fix it up with your From:
header.
