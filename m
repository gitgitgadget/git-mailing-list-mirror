From: dexen deVries <dexen.devries@gmail.com>
Subject: push from git gui goes to wrong branch
Date: Mon, 20 Dec 2010 15:09:22 +0100
Message-ID: <201012201509.22236.dexen.devries@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 20 15:09:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUgQW-0003Xl-Cu
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 15:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757768Ab0LTOJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 09:09:18 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:33995 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757724Ab0LTOJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 09:09:18 -0500
Received: by eyg5 with SMTP id 5so1443290eyg.2
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 06:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=f47fDwLgo9oCiqO0Kz5NL8pyTmscxnryilI/W3C7puk=;
        b=kffnK7UoQ65sHQB53eiNcYNZe6rgFnX985eAWndDRUe8sXxlZQWXPkS/7jF9sXrCPQ
         WvE7xgRFwb80wWtK1QMjqpMAeR/6kmMvhsBSlQcjh50yOD4V5743r9gNP+a372anXXnW
         cGnwgKb9aunnCkBI3ngnttwx1/Y8Iu+DfjMcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=cdjJw7uV1wIdvlV+Y9T5MmA5nbbiC+sgZ02dYiRxUR5yXtTBE+jF/HuWk+e4i+hhfv
         AY+/jp/kJyN+zCkFHZ4HKgZli423wfjmOxOZIk73z46YBBET3rExUzZlDQQYuS3jWKX6
         J1x60BSBDUr5URrddbWl9uKKy76s3NMJ45D/Q=
Received: by 10.213.15.144 with SMTP id k16mr4920708eba.77.1292854156409;
        Mon, 20 Dec 2010 06:09:16 -0800 (PST)
Received: from coil.localnet ([89.228.5.182])
        by mx.google.com with ESMTPS id q58sm2889149eeh.9.2010.12.20.06.09.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Dec 2010 06:09:15 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-18+; KDE/4.5.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163995>

Hello,


there's a behavior in git gui (v1.7.3.2 and previous) that I consider bugous. 
Failed to find any bugreporting system on git's website so I'm reporting it 
here; please correct me if that's wrong.

I have the following snippet in my .git/config:
[branch "article"]
	remote = baron
	merge = refs/heads/dexen-article

However, the `Push' button from git gui sends local branch `article' to remote 
branch `article', rather than to the indicated `dexen-article'.

For reference, with the CLI `git push', the local branch `article' is pushed 
to remote branch `dexen-article' as expected.


Regards,
-- 
dexen deVries


``You want to make your way in the CS field? Simple. Calculate rough time of 
amnesia (hell, 10 years is plenty, probably 10 months is plenty), go to the 
dusty archives, dig out something fun, and go for it.   It's worked for many 
people, and it can work for you.''  - Ron Minnich
