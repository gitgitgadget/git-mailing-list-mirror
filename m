From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/2] gitk: Fix the geometry when restoring from zoomed state
Date: Thu, 17 Sep 2009 22:15:51 +1000
Message-ID: <19122.10359.725107.949551@cargo.ozlabs.ibm.com>
References: <1252437756-81986-1-git-send-email-snaury@gmail.com>
	<8763bkcsxb.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alexy Borzenkov <snaury@gmail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 14:16:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoFu4-0004oo-1v
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 14:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757594AbZIQMPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 08:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757387AbZIQMPu
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 08:15:50 -0400
Received: from ozlabs.org ([203.10.76.45]:48256 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757358AbZIQMPu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 08:15:50 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2DCFDB7B77; Thu, 17 Sep 2009 22:15:53 +1000 (EST)
In-Reply-To: <8763bkcsxb.fsf@users.sourceforge.net>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128746>

Pat Thoyts writes:

> The patch to handle the geometry of a restored gitk by Alexy Borzenkov
> causes the position of the columns to creep each time the application
> is restarted.  This patch addresses this by remembering the application
> geometry for the normal state and saving that regardless of the actual
> state when the application is closed.

So this patch replaces Alexey's patch, then?  The context in your patch
doesn't match the changes made in Alexey's patch AFAICS.

Paul.
