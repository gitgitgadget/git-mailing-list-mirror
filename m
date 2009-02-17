From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH] Use DIFF_XDL_SET/DIFF_OPT_SET instead of raw
 bit-masking
Date: Tue, 17 Feb 2009 09:33:42 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0902170918180.27811@kiwi.cs.ucla.edu>
References: <1234841209-3960-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0902171304130.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@madism.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:35:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZTqv-0007cg-KQ
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 18:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbZBQRd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 12:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbZBQRd6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 12:33:58 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:48816 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbZBQRd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 12:33:57 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n1HHXg6h028333;
	Tue, 17 Feb 2009 09:33:42 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n1HHXgep028330;
	Tue, 17 Feb 2009 09:33:42 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0902171304130.6185@intel-tinevez-2-302>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110420>

Dscho,

On Tue, 17 Feb 2009, Johannes Schindelin wrote:

> Rationale?
> If you are going to add something on top of that, I can understand that, but 
> this patch is not labeled [1/n].  And...

This patch is about consistency.  Yes I'd like to add something on top of it.  
But these improvements stand well on their own.  My work on the 
diff.defaultOptions patch highlighted the desirability of handling these bit 
manipulations consistently, via macros.

> ... this does not look good to me, without a compelling reason why we want to 
> have the patch nevertheless.

Is there something you dislike about the code style?  As always I'm happy to 
adjust it.
                                    -- Keith
