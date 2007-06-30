From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: don't convert - delimiter to .'s
Date: Sat, 30 Jun 2007 10:19:31 -0700
Message-ID: <7vved5e4ws.fsf@assigned-by-dhcp.cox.net>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 30 19:19:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4gbm-0005lz-Mf
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 19:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757089AbXF3RTf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 13:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756845AbXF3RTe
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 13:19:34 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:38767 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422AbXF3RTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 13:19:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630171931.XHKI17683.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 13:19:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HtKY1X0011kojtg0000000; Sat, 30 Jun 2007 13:19:32 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51225>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> Otherwise, a custom "v1.5.2.42.gb1ff" is considered newer than a
> "v1.5.2.1.69.gcafe"

Does this solve anything, I wonder?  v1.5.2-this and
v1.5.2.1-that are not really comparable to begin with.
