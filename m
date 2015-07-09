From: Stefan Tatschner <rumpelsepp@sevenbyte.org>
Subject: git svn timezone issue?
Date: Thu, 09 Jul 2015 15:28:14 +0200
Message-ID: <1436448494.1480.5.camel@sevenbyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 15:48:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDCBi-00067N-Sp
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 15:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbbGINs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 09:48:27 -0400
Received: from mail.sevenbyte.org ([5.9.90.188]:40828 "EHLO mail.sevenbyte.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbbGINsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 09:48:25 -0400
X-Greylist: delayed 1209 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jul 2015 09:48:25 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.sevenbyte.org (Postfix) with ESMTP id 51346126062E
	for <git@vger.kernel.org>; Thu,  9 Jul 2015 15:28:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at sevenbyte.org
Received: from mail.sevenbyte.org ([127.0.0.1])
	by localhost (mail.sevenbyte.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CMEZbV2QnlrQ for <git@vger.kernel.org>;
	Thu,  9 Jul 2015 15:28:15 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273754>

Hi,

at work we use svn, so I used "git svn" to import that stuff to git.
Now it seems that there are some timezone issues. "git log" shows +0000
as timezone, while "git svn log" shows the correct timezone +0200. 

$ git log -1
commit ceb8a8647e257d6caf2ad0ecc2298f8b269c9727
Author: John Doe <john@doe.com>
Date:   Thu Jul 9 12:05:22 2015 +0000

$ git svn log -1                                                       
-----------------------------------------------------------------------
r1967 | doe | 2015-07-09 14:05:22 +0200 (Do, 09 Jul 2015) | 2 lines

$ git --version
git version 2.4.5

$ git svn --version
git-svn version 2.4.5 (svn 1.8.13)

Any ideas?

Thanks,
Stefan
