From: saurabh@stockal.com
Subject: Whether Git supports directory level access or
 =?UTF-8?Q?not=3F?=
Date: Tue, 07 Jul 2015 06:40:25 +0000
Message-ID: <705bdbdc6a8195d59203bcb1f3027714@stockal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 08:40:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCMYc-0001jT-0R
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 08:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbbGGGki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 02:40:38 -0400
Received: from md-43.webhostbox.net ([208.91.198.42]:48805 "EHLO
	md-43.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbbGGGkg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 02:40:36 -0400
X-Greylist: delayed 1011 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jul 2015 02:40:36 EDT
Received: from localhost ([127.0.0.1]:36968 helo=webmail.stockal.com)
	by md-43.webhostbox.net with esmtpa (Exim 4.85)
	(envelope-from <saurabh@stockal.com>)
	id 1ZCMYL-0037Hf-73
	for git@vger.kernel.org; Tue, 07 Jul 2015 06:40:25 +0000
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273479>

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
