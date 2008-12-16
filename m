From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: git-svn and empty directories
Date: Tue, 16 Dec 2008 13:53:43 +0100
Organization: Intra2net AG
Message-ID: <200812161353.49796.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>,
	Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Tue Dec 16 13:55:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCZST-0004iE-EO
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 13:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbYLPMyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 07:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbYLPMyA
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 07:54:00 -0500
Received: from rs02.intra2net.com ([81.169.173.116]:51578 "EHLO
	rs02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbYLPMx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 07:53:59 -0500
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rs02.intra2net.com (Postfix) with ESMTP id E45844DA4;
	Tue, 16 Dec 2008 13:53:57 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id 735BB2AC4B;
	Tue, 16 Dec 2008 13:53:57 +0100 (CET)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id BDEA22AC4A;
	Tue, 16 Dec 2008 13:53:55 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-41.fc9.i686; KDE/4.1.3; i686; ; )
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-16_09)
X-Spam-Status: hits=-2.5 tests=[ALL_TRUSTED=-1.8,BAYES_20=-0.74]
X-Spam-Level: 975
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103278>

Hello Eric and Deskin,

I'm currently looking into preserving empty directories from a SVN repository 
by automatically creating empty .gitignore files for them.

The control flow of the git-svn code is still a jungle to me,
maybe you have a hint how to implement a proof-of-concept code?

I don't think I can just touch a .gitignore file in get_untracked()
and those files will magically turn up in git's index...

Thanks,
Thomas
