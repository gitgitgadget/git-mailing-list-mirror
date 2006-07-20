From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
Subject: git-rerere during git-rebase
Date: Thu, 20 Jul 2006 17:14:25 +0300 (EEST)
Message-ID: <Pine.LNX.4.58.0607201702010.3746@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 20 16:15:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3ZIN-00053P-S3
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 16:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWGTOO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 10:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWGTOO2
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 10:14:28 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:54763 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030325AbWGTOO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jul 2006 10:14:27 -0400
Received: from kivilampi-30.cs.helsinki.fi (kivilampi-30.cs.helsinki.fi [128.214.9.42])
  (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Thu, 20 Jul 2006 17:14:26 +0300
  id 00087DB0.44BF8FC2.00001B31
Received: by kivilampi-30.cs.helsinki.fi (Postfix, from userid 50795)
	id A02D4EAFF1; Thu, 20 Jul 2006 17:14:25 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by kivilampi-30.cs.helsinki.fi (Postfix) with ESMTP id 93B93EAFE5
	for <git@vger.kernel.org>; Thu, 20 Jul 2006 17:14:25 +0300 (EEST)
X-X-Sender: ijjarvin@kivilampi-30.cs.helsinki.fi
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24030>

Hi,

I discovered that "git-am --resolved --3way" (in 1.3.1) and "git-rebase 
--continue" (in 1.4.2.rc1.ge7a0) do not correctly capture hand resolved 
files into .git/rr-cache. In worst case I got (with 1.3.1), afaict, the 
postimage was incorrect including also all patches successfully applied 
after the git-am --resolved --3way up to until the point where next 
conflict occurred. To circumvent this, I can use git-rerere directly but I 
remember that its manpage states that one should never have to do so. I'm 
I missing something or is this a problem in git-rebase (or possibly in 
git-am)?


-- 
 i.

ps. I'm not subscribed, so please cc me.
