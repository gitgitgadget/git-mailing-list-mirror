From: Kurt Milligan <kurt@surfmerchants.com>
Subject: commit hooks on merge
Date: Thu, 25 Jun 2009 15:43:55 -0400
Message-ID: <4A43D37B.20203@surfmerchants.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 22:03:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJvAc-0002zH-VW
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 22:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbZFYUDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 16:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbZFYUDa
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 16:03:30 -0400
Received: from mail.quanetic.com ([71.248.185.19]:58858 "EHLO
	mail.quanetic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbZFYUD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 16:03:29 -0400
X-Greylist: delayed 1170 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jun 2009 16:03:29 EDT
Received: by mail.quanetic.com (Postfix, from userid 5001)
	id 5640F147F34; Thu, 25 Jun 2009 15:43:31 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on rook
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham
	version=3.2.5
Received: from [192.168.2.106] (static-71-248-185-21.bstnma.fios.verizon.net [71.248.185.21])
	by mail.quanetic.com (Postfix) with ESMTP id A97A0147F32
	for <git@vger.kernel.org>; Thu, 25 Jun 2009 15:43:26 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122241>

Hi

I asked this in #git, and did a quick Google search to no avail...

According to the docs, merge does an auto-commit, but it seems that the 
pre/post commit hooks are not run for this commit. Is that intentional? 
Is there a way I can make them run for the merge commit? I see there is 
a post-merge hook, but that doesn't really help me if I want to stop the 
merge...

Thanks in advance

-Kurt
