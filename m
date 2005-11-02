From: Ben Lau <benlau@ust.hk>
Subject: Clone a repository with only the objects needed for a single tag
Date: Wed, 02 Nov 2005 10:02:47 +0800
Message-ID: <43681E47.4010203@ust.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 02 03:03:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX7y5-0001VH-J9
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 03:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVKBCCx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 21:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVKBCCx
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 21:02:53 -0500
Received: from mx4.ust.hk ([143.89.13.26]:59400 "EHLO mx4.ust.hk")
	by vger.kernel.org with ESMTP id S932177AbVKBCCw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 21:02:52 -0500
Received: from [143.89.135.159] (atz113.rd.ust.hk [143.89.135.159])
	by mx4.ust.hk (8.12.11/8.12.11) with ESMTP id jA222hPl011734
	for <git@vger.kernel.org>; Wed, 2 Nov 2005 10:02:44 +0800 (HKT)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10989>

Hi,

   Is there any method to clone/copy a repository with only the objects 
needed
for a single tag in order to save disk space?

   For example, if I want to start a new project based on a specific 
version of kernel
like v2.6.14. I would run `git-clone` and then checkout a new branch 
based on the tag.
However, one of the development host is a notebook computer which has 
only 2GB space
leave. Therefore I hope the space occupied by the respository could be 
mininiumized
while it keeps to be able to fetch/update from my master repository.

  Thanks for any advise.
