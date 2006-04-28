From: Geert Bosch <bosch@adacore.com>
Subject: Re: PATCH: New diff-delta.c implementation (updated)
Date: Thu, 27 Apr 2006 22:07:43 -0400
Message-ID: <E7746844-4275-4B9E-AC75-2B68CD056BAD@adacore.com>
References: <Pine.GSO.4.60.0604272132170.9650@nile.gnat.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Apr 28 04:07:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZIOZ-0002ex-0D
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 04:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWD1CHo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 22:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbWD1CHo
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 22:07:44 -0400
Received: from nile.gnat.com ([205.232.38.5]:61394 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S965171AbWD1CHn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 22:07:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 2617548CEFD
	for <git@vger.kernel.org>; Thu, 27 Apr 2006 22:07:43 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 05986-01-6 for <git@vger.kernel.org>;
 Thu, 27 Apr 2006 22:07:43 -0400 (EDT)
Received: from [172.16.1.2] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id E2DB348CE31
	for <git@vger.kernel.org>; Thu, 27 Apr 2006 22:07:42 -0400 (EDT)
In-Reply-To: <Pine.GSO.4.60.0604272132170.9650@nile.gnat.com>
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.749.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19263>


On Apr 27, 2006, at 21:59, Geert Bosch wrote:

> The result has been only a slight increase in delta size for
> very large test cases (but with better performance),

Just to clarify: this is compared to my initial implementation.
For very large test cases, both delta size and execution time
are much less than the current implementation.

   -Geert
