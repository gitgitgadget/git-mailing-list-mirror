From: saurabh@stockal.com
Subject: Want know whether Git support directory love
 =?UTF-8?Q?access=3F?=
Date: Tue, 07 Jul 2015 06:23:39 +0000
Message-ID: <6bdfcddf8d3031446b8ddbb0bbdf4f8a@stockal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 09:16:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCN76-0004Q9-18
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 09:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbbGGHQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 03:16:16 -0400
Received: from md-43.webhostbox.net ([208.91.198.42]:59046 "EHLO
	md-43.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbbGGHQP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 03:16:15 -0400
Received: from localhost ([127.0.0.1]:59309 helo=webmail.stockal.com)
	by md-43.webhostbox.net with esmtpa (Exim 4.85)
	(envelope-from <saurabh@stockal.com>)
	id 1ZCMI7-00321C-2E
	for git@vger.kernel.org; Tue, 07 Jul 2015 06:23:39 +0000
X-Priority: 2 (High)
X-Sender: saurabh@stockal.com
User-Agent: Roundcube Webmail/1.0.5
X-Authenticated_sender: saurabh@stockal.com
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-43.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - stockal.com
X-Get-Message-Sender-Via: md-43.webhostbox.net: authenticated_id: saurabh@stockal.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273483>

Hi,

Please let me know whether Git supports directory level access or not.

For example :- Consider the structure with one repository consisting of 
sub directories for each product.
main_repo:
    dir1 dir
    dir2 dir
    shared-dir dir
    private dir
One group(user) of developers has access to dir1 and shared-dir while 
the other group(user) has access to dir2 and shared-resources.
Just for context, both dir1 and dir2 require shared-dir to be checked 
out for building the products.

And private dir is only accessible by admin(repo owner).

Regards
Saurabh gaur
