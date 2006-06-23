From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] patch-id: "diff-tree" => "commit"
Date: Fri, 23 Jun 2006 08:50:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606230849290.6483@g5.osdl.org>
References: <Pine.LNX.4.63.0606231731280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Jun 23 17:51:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftnvd-00055y-6u
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 17:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWFWPui (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 11:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWFWPui
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 11:50:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49858 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751480AbWFWPuh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 11:50:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5NFoTUT001654
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 23 Jun 2006 08:50:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5NFoSt4017551;
	Fri, 23 Jun 2006 08:50:28 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606231731280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22427>



On Fri, 23 Jun 2006, Johannes Schindelin wrote:
> 
> Some time ago we changed git-log in a massive way, and one consequence is
> that the keyword changed. Adjust patch-id for that.

Ahh. Yes. Except I think you should allow both, for historical reasons (ie 
not remove the old case).

		Linus
