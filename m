From: Paul Mackerras <paulus@samba.org>
Subject: Re: New git commit tool
Date: Tue, 5 Sep 2006 07:51:34 +1000
Message-ID: <17660.40934.605502.248266@cargo.ozlabs.ibm.com>
References: <17660.4995.977221.767112@cargo.ozlabs.ibm.com>
	<20060904195736.GB2752@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Sep 04 23:51:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKMM3-0003Oe-MG
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 23:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWIDVvk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 17:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWIDVvj
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 17:51:39 -0400
Received: from ozlabs.org ([203.10.76.45]:6374 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965003AbWIDVvj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 17:51:39 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3C7D167BE7; Tue,  5 Sep 2006 07:51:38 +1000 (EST)
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060904195736.GB2752@diku.dk>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26437>

Jonas Fonseca writes:

>     I am a Cogito user, so I am no used to running git-update-index and
>     this seems to be a problem in this case:
> 
> 	can't unset "indexpending(gitool)": no such element in array

Hmmm, I didn't think that could happen. :) It can only happen if some
file gets listed twice in the output from "git-diff-index HEAD".
Could you send me the output of "git-diff-index HEAD" and
"git-diff-index --cached HEAD" in that repository?

And no, you don't need to run git-update-index, gitool does that for
you.

Paul.
