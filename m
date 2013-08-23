From: =?UTF-8?B?0K/QvdGH0LDRgNGD0Log0JDQu9C10LrRgdCw0L3QtNGA?= 
	<alex@itvault.info>
Subject: How to set tab size for hunks in =?UTF-8?B?4oCcZ2l0IGFkZCAtcOKAnQ==?=
 =?UTF-8?B?Pw==?=
Date: Fri, 23 Aug 2013 21:28:11 +0400
Message-ID: <52179BAB.3040505@itvault.info>
Reply-To: alex@itvault.info
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 23 19:28:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCv9m-0006ju-DQ
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 19:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755679Ab3HWR2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 13:28:14 -0400
Received: from host-46-137.data-centre.net ([213.248.46.137]:35458 "EHLO
	itvault.info" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754654Ab3HWR2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 13:28:14 -0400
Received: from localhost (localhost.itvault.info [127.0.0.1])
	by itvault.info (Postfix) with ESMTP id 223C71DBCDF
	for <git@vger.kernel.org>; Fri, 23 Aug 2013 21:28:13 +0400 (MSK)
X-Virus-Scanned: amavisd-new at itvault.info
Received: from itvault.info ([127.0.0.1])
	by localhost (xhost.itvault.info [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uobZkd7gXV93 for <git@vger.kernel.org>;
	Fri, 23 Aug 2013 21:28:11 +0400 (MSK)
Received: from [192.168.1.2] (ppp91-76-236-87.pppoe.mtu-net.ru [91.76.236.87])
	by itvault.info (Postfix) with ESMTPSA id D50F71DBCDB
	for <git@vger.kernel.org>; Fri, 23 Aug 2013 21:28:11 +0400 (MSK)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130704 Icedove/17.0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232815>

Hi!

I used the solution from here 
<http://stackoverflow.com/questions/15132325/how-to-set-tab-size-for-pager-used-in-git-diff> 
to change tab size in |git diff||| output. That works fine with git diff.

I have these settings in my *.gitconfig*:

    |[core]
    whitespace = tabsize=4,indent-with-non-tab
    pager = less -FSRX -x4
    |

But those settings seems does not affect on |git add -p|. How to set tab 
size for hunks in *git add -p* command?

Thanks in advance!

-- 
Best regards,
Alexander Yancharuk
alex@itvault.info <mailto:alex@itvault.info>
