From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix problematic ']'
Date: Mon, 23 Jul 2007 19:01:11 -0700
Message-ID: <7vvecak1aw.fsf@assigned-by-dhcp.cox.net>
References: <200707232236.21389.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jul 24 04:01:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID9i9-00078t-Bw
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 04:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbXGXCBO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 22:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752839AbXGXCBN
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 22:01:13 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37140 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbXGXCBN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 22:01:13 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070724020111.JRUK1349.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 23 Jul 2007 22:01:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TE1B1X00R1kojtg0000000; Mon, 23 Jul 2007 22:01:12 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53520>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Not all shells grok a closing ']' of the shell '[' command without
> surrounding space.
>
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
>
> I didn't go the long way to change all `[ ... ]` into `test ...`

Maybe that would have been a better idea.
