From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 2/5] git-svn: memoize conversion of SVN merge ticket
 info to git commit ranges
Date: Sun, 20 Dec 2009 05:37:38 +1300
Message-ID: <1261240658.20752.5.camel@denix>
References: <1261240435-8948-1-git-send-email-sam@vilain.net>
	 <1261240435-8948-2-git-send-email-sam@vilain.net>
	 <1261240435-8948-3-git-send-email-sam@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Andrew Myrick <amyrick@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 17:38:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM2Jq-0002Vl-Fy
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 17:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbZLSQiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 11:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbZLSQiK
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 11:38:10 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:52608 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684AbZLSQiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 11:38:09 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id A5E4221C475; Sun, 20 Dec 2009 05:38:06 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.234] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 33CE021C366;
	Sun, 20 Dec 2009 05:37:37 +1300 (NZDT)
In-Reply-To: <1261240435-8948-3-git-send-email-sam@vilain.net>
X-Mailer: Evolution 2.28.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135492>

On Sun, 2009-12-20 at 05:33 +1300, Sam Vilain wrote:
> Each time the svn mergeinfo ticket changes, we look it up in the rev_map;
> when there are a lot of merged branches, this will result in many repeated
> lookups of the same information for subsequent commits.  Arrange the slow
> part of the function so that it may be memoized, and memoize it.  The more
> expensive revision walking operation can be memoized separately.

Sorry, that text was an old revision.  Read as:

Each time the svn mergeinfo ticket changes, we look it up in the
rev_map; when there are a lot of merged branches, this will result in
many repeated lookups of the same information for subsequent commits.
Arrange that part of the function so that it may be memoized, and
memoize it.

Sam
