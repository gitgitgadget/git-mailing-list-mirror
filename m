From: =?UTF-8?B?SmFudXN6IEJpYcWCb2JyemV3c2tp?= 
	<Janusz.Bialobrzewski@biu.pl>
Subject: Combined diff with name-only option
Date: Fri, 10 Jul 2015 12:39:43 +0200
Message-ID: <559FA0EF.2000409@biu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 12:49:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDVro-0000H7-Tv
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 12:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683AbbGJKtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 06:49:12 -0400
Received: from deimos.limes.com.pl ([193.110.228.48]:53314 "EHLO
	deimos.limes.com.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbbGJKtK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 06:49:10 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jul 2015 06:49:10 EDT
Received: from localhost (localhost [127.0.0.1])
	by deimos.limes.com.pl (Postfix) with ESMTP id 3A6652512098
	for <git@vger.kernel.org>; Fri, 10 Jul 2015 12:39:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at deimos.limes.com.pl
X-Spam-Flag: NO
X-Spam-Score: -2.739
X-Spam-Level: 
X-Spam-Status: No, score=-2.739 tagged_above=-9999 required=6.11
	tests=[ALL_TRUSTED=-1, AWL=0.161, BAYES_00=-1.9] autolearn=ham
Received: from deimos.limes.com.pl ([127.0.0.1])
	by localhost (deimos.limes.com.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4CYo5NpJ8Rx4 for <git@vger.kernel.org>;
	Fri, 10 Jul 2015 12:39:35 +0200 (CEST)
Received: from [192.168.11.123] (host43-89-206-14.limes.com.pl [89.206.14.43])
	by deimos.limes.com.pl (Postfix) with ESMTPA id AC924251206D
	for <git@vger.kernel.org>; Fri, 10 Jul 2015 12:39:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273813>

Hello,

When I run:

git diff-tree --cc 511f273b99af4529f6eb30069bb9070dc73fbbb4

As expected, I get the diff for the files that are changed in both parents.

When I run:

git diff-tree --cc --name-only 511f273b99af4529f6eb30069bb9070dc73fbbb4

I get all the files listed including ones that are changed only in one 
parent.
I would expect to see only names of the files changed in both parents 
like in the case when --name-only parameter was not present.
Is it a bug or is it done by design?

BR,
Janusz.
