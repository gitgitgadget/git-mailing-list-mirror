From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk - dont warn when deleting synonym for current head
Date: Mon, 13 Aug 2007 13:52:44 +1000
Message-ID: <18111.54668.327095.685366@cargo.ozlabs.ibm.com>
References: <1186952583887-git-send-email-mdl123@verizon.net>
	<18111.39773.231609.306547@cargo.ozlabs.ibm.com>
	<46BFAF8E.1000508@verizon.net>
	<46BFB908.7050000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mdl123@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 05:53:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKQzM-0006pu-P3
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 05:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbXHMDwv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 23:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934337AbXHMDwv
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 23:52:51 -0400
Received: from ozlabs.org ([203.10.76.45]:42055 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764188AbXHMDwu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 23:52:50 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 14F07DDEDE; Mon, 13 Aug 2007 13:52:49 +1000 (EST)
In-Reply-To: <46BFB908.7050000@gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55742>

Mark Levedahl writes:

> By the way, I'm not sure how gitk can usefully do the implied check 
> without loading the full repository DAG.

It does load the full repository DAG - that's how it gets the
information for the Precedes:, Follows: and Branch(es): fields in the
commit display.  It's true that that can be turned off, though, and in
that case an "are you sure" dialog would be appropriate.

Paul.
