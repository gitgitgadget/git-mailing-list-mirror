From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 2/2] gitk: add --no-replace-objects option
Date: Thu, 19 Nov 2009 20:01:25 +1100
Message-ID: <19205.2405.220888.736317@cargo.ozlabs.ibm.com>
References: <20091118065100.4206.48820.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Nov 19 10:02:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB2uA-0004jv-0o
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 10:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756410AbZKSJB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 04:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755251AbZKSJB0
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 04:01:26 -0500
Received: from ozlabs.org ([203.10.76.45]:46629 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757523AbZKSJBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 04:01:25 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id C73B71007D4; Thu, 19 Nov 2009 20:01:30 +1100 (EST)
In-Reply-To: <20091118065100.4206.48820.chriscool@tuxfamily.org>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133217>

Christian Couder writes:

> This option simply sets the GIT_NO_REPLACE_OBJECTS environment
> variable, and that is enough to make gitk ignore replace refs.

For the commit message, could you add a couple of lines telling us
what replace refs are and why you might want gitk to ignore them?

Paul.
