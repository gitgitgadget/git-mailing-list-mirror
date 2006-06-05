From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix typo in tutorial-2.txt
Date: Mon, 5 Jun 2006 16:58:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606051654390.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606051245470.5498@g5.osdl.org>
 <Pine.LNX.4.63.0606060111570.25344@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060605234441.GB14993@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 06 01:58:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnOy2-0000pR-Pt
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 01:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWFEX6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 19:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWFEX6k
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 19:58:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16579 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750932AbWFEX6j (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 19:58:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k55NwU2g019252
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Jun 2006 16:58:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k55NwT2b029359;
	Mon, 5 Jun 2006 16:58:30 -0700
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060605234441.GB14993@fieldses.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21356>



On Mon, 5 Jun 2006, J. Bruce Fields wrote:
> 
> But don't commit SHA1's, e.g., depend on times, authors, etc., that we
> can't count on being the same?

You can set all these by hand with the

	GIT_{AUTHOR,COMMITTER}_{NAME,EMAIL,DATE}

variables. In fact, the test script library already does that for authors 
(although not for dates, I think) to get consistent answers.

			Linus
