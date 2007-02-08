From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] qgit4: Add a header and set the font family appropriately to the log message
Date: Thu, 08 Feb 2007 15:58:44 -0800
Message-ID: <7vk5ysw6a3.fsf@assigned-by-dhcp.cox.net>
References: <200702082158.56463.andyparkins@gmail.com>
	<200702082331.13095.andyparkins@gmail.com>
	<20070208234153.GB1556@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 09 00:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFJA9-0007vT-Kh
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945937AbXBHX6q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945938AbXBHX6q
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:58:46 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:36288 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945937AbXBHX6p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:58:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070208235844.DFRU21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Feb 2007 18:58:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MByk1W00b1kojtg0000000; Thu, 08 Feb 2007 18:58:45 -0500
In-Reply-To: <20070208234153.GB1556@spearce.org> (Shawn O. Pearce's message of
	"Thu, 8 Feb 2007 18:41:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39132>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> In case you did not already know, --numbered is a wonderful option
> to git-format-patch.  It automatically numbers the commits by placing
> a sequence into the subject header (e.g. [PATCH 1/3]), making it
> easier for everyone to know how many patches are in your series.

This came up before, but when you have more than 9 in your
series, we _could_ do [PATCH 01/12] ... [PATCH 12/12] to line
them up in e-mail client of the recipients better.  Currently I
think we do [PATCH 1/12] ... [PATCH 12/12].
