From: Rustom Mody <rustompmody@gmail.com>
Subject: advisability of CIFS/SMBFS
Date: Mon, 13 Jul 2009 15:57:10 +0530
Message-ID: <f46c52560907130327n1fedcd9ch34a2a73a03b9af5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 12:27:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQIkh-0000un-BI
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 12:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318AbZGMK1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 06:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755301AbZGMK1L
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 06:27:11 -0400
Received: from mail-pz0-f197.google.com ([209.85.222.197]:65197 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944AbZGMK1K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 06:27:10 -0400
Received: by pzk35 with SMTP id 35so775879pzk.33
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 03:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=0019qTycw+X/QMI2P3d4Rbk7go1yEduO0014b2aNCTg=;
        b=EleOe9HwCPfLjj0dRmGv+zyfQ7RaJwCtIRG474ExJjXkYq6pWdbpt4phK3Y7sTNa1F
         XrAsYrgz1Mt0DsyBd/5D0uKn1DQFzuPB2LjG3sqf/AuvmWiPRSnuk+kb6Ws1DjPZcex0
         dfE6udnuytqgpwYIg67zAkjHDZ612Wk2b5sRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=rg+DrYoRA3Xuq4EOOz3821Qmns7pbV4W32H4D12KKKdMsv5e6+rfkU/FKwJHyqhhcU
         wAP0oM79kq7pVmFvIEN05rqVazZRaia5NZuO4NrK/iY4Hi4uqG7Su8gwbpengsnIcdf5
         fXaQBGx+bBDyxfHj3f7FVU8O9/9m9VBhxY9NQ=
Received: by 10.115.90.1 with SMTP id s1mr5641334wal.39.1247480830065; Mon, 13 
	Jul 2009 03:27:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123182>

I see a mention of CIFS/SMBFS on the faq and some mails but no clear
position on whether its ok or not.

My question is in the following context:

- Our team (5-6 programmers) use windows and linux for development
- We are on a windows 'network neighborhood' type system (I guess this is CIFS?)
- there is a linux box for an (internal) server and some dual boots

If I can make a repo smbmounted on one of the linux partitions then we
can push/pull from each others' repos almost like between local repos
ie without ssh etc.  Of course this assumes the directories are made
suitably shareable by the team members.

Of course one could say: Whats the point of using the best distributed
vcs without using the distributed features.

Well our reasons for git are:
- efficient branching and sophisticated merge, branch surgery with
rebase, cherry-pick
- mailing patches (sometimes people work from home)
- other goodies like interactive add, stash etc

So is smbmounting git repos ok or is plain ol' ssh safer/preferable?
