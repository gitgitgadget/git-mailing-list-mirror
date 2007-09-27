From: Adam Roben <aroben@apple.com>
Subject: Equivalent of `svn switch` for git-svn?
Date: Wed, 26 Sep 2007 23:41:10 -0700
Message-ID: <46FB5086.7070408@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 08:41:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ian3m-0000QC-Fb
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 08:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbXI0GlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 02:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447AbXI0GlL
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 02:41:11 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:54795 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbXI0GlK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 02:41:10 -0400
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out3.apple.com (Postfix) with ESMTP id 4D44D12B5100
	for <git@vger.kernel.org>; Wed, 26 Sep 2007 23:41:10 -0700 (PDT)
Received: from relay11.apple.com (unknown [127.0.0.1])
	by relay11.apple.com (Symantec Mail Security) with ESMTP id 2E9A028059
	for <git@vger.kernel.org>; Wed, 26 Sep 2007 23:41:10 -0700 (PDT)
X-AuditID: 11807130-a2bc0bb000004daf-65-46fb508671d1
Received: from [17.219.200.50] (Vpn0priv-50.apple.com [17.219.200.50])
	by relay11.apple.com (Apple SCV relay) with ESMTP id 0804D2804E
	for <git@vger.kernel.org>; Wed, 26 Sep 2007 23:41:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59271>

Hi all-
   I've recently been informed that the Subversion server I and several 
others have been tracking with git-svn will be switching from using the 
svn+ssh scheme to the http scheme. To handle this, users of svn will be 
running `svn switch` to move their working copies to the new repository 
URL. Is there some way to do the same for git-svn? I suspect the biggest 
complication will come from the git-svn-id: lines in the commit logs, 
since changing that line would require changing the commit hash as well.

   Thanks for any advice!

-Adam
