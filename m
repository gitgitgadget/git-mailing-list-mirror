From: Tom Lanyon <tom@netspot.com.au>
Subject: Git config not expanding user home directories
Date: Tue, 30 Sep 2008 20:16:06 +0930
Message-ID: <F90667E7-6B06-4B34-B655-3C42ED236D9A@netspot.com.au>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 12:47:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkclF-00045L-L3
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 12:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbYI3KqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 06:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbYI3KqJ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 06:46:09 -0400
Received: from kuat-e0.netspot.com.au ([203.30.161.145]:52004 "EHLO
	kuat.netspot.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbYI3KqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 06:46:09 -0400
Received: by kuat.netspot.com.au (Postfix, from userid 1004)
	id 8818F2800DD65; Tue, 30 Sep 2008 20:16:06 +0930 (CST)
X-Spam-Checker-Version: SpamAssassin 3.1.8-gr1 (2007-02-13) on
	kuat.netspot.com.au
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.1.8-gr1
Received: from [192.168.13.59] (ppp121-45-78-218.lns10.adl6.internode.on.net [121.45.78.218])
	(Authenticated sender: tom)
	by kuat.netspot.com.au (Postfix) with ESMTP id 5C2A8280030D4
	for <git@vger.kernel.org>; Tue, 30 Sep 2008 20:16:06 +0930 (CST)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97093>

Hi all,

Is it normal behavior that git (well at least git-svn) won't expand  
~user from .gitconfig?

I was trying to set the svn.authorsfile config key to  
~tom/.gitauthors; I received an error until changing it to read /home/ 
tom/.gitauthors.

Regards,
Tom
