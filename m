From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: avoid error on reload
Date: Mon, 19 May 2008 09:51:58 +1000
Message-ID: <18480.49438.10215.276463@cargo.ozlabs.ibm.com>
References: <200805172255.52828.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Mon May 19 01:53:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxsh7-00022Z-SY
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 01:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbYERXwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 19:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752747AbYERXwM
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 19:52:12 -0400
Received: from ozlabs.org ([203.10.76.45]:56855 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688AbYERXwL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 19:52:11 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3302EDDED1; Mon, 19 May 2008 09:52:10 +1000 (EST)
In-Reply-To: <200805172255.52828.barra_cuda@katamail.com>
X-Mailer: VM 7.19 under Emacs 22.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82401>

Michele Ballabio writes:

> I don't know if this patch is the right fix, so here is a script
> that triggers this error:

Many thanks for finding a way to trigger this bug reliably.  I have
been chasing it for a while but haven't been able to trigger it
repeatably before this.  The actual bug was that I wasn't unsetting
line[hnd]tag when clearing the canvases.  I have checked in a fix.

Paul.
