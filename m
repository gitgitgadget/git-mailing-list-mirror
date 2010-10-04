From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Useful tracking branches and auto merging
Date: Mon, 4 Oct 2010 23:44:24 +0300
Message-ID: <AANLkTimq0sKUavKiXepDOz+DvrymuRAVUyAyV+FzbCBD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 22:44:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2rtf-00086Y-NS
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 22:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757129Ab0JDUo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 16:44:26 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48091 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033Ab0JDUoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 16:44:25 -0400
Received: by bwz11 with SMTP id 11so3986284bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 13:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=WoTca7K4tRR6jeANEchlkmbn+sDw/U8jimHwifCiYYs=;
        b=QbgkgV3H+PuSpaHeAIMFqykMop1z2kydKKOIcY7f4pn5D8YGjBVpsA9z9yZdYcvNay
         xrfCU1s9MjCPksgs/pIc1joeYxCslJ017mODOim3o/jnYl2qM1clZHGfN/upRsls/ZeE
         g+/JXHx89KGYJhk9DzTAo4TQdCJLRqlW6xX3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=cnmDzaEo7V+Q+6IuWR7QDiGFZpOU9r2XDIJjZgdqIv+KN6pl2BWcxEIiRJYsSNJ6Ob
         CmkTbB8NM/rMoOTQhYIZ7ZFn1y1mtdWnFh0QUAfbc4r1GaSrI4iJh2br/+FeoZsnRJkY
         gVQQw0xFSbdxX5YhKAHlB1aq1ogdXUCBovatM=
Received: by 10.204.72.134 with SMTP id m6mr7484189bkj.163.1286225064309; Mon,
 04 Oct 2010 13:44:24 -0700 (PDT)
Received: by 10.204.152.142 with HTTP; Mon, 4 Oct 2010 13:44:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158111>

Hi,

For some time now I've stopped using 'git pull', and used 'git fetch',
and now 'git remote update', however, this is still not ideal.

 Your branch is behind 'origin/master' by 17 commits, and can be fast-forwarded.

This message doesn't tell me _how_ I can 'fast-forward', I do 'git
merge origin/master' but if git already knows 'master' is tracking
'origin/master' why should I specify that? Perhaps 'git merge
--tracking'.

But, while we are on that, why not automatically merge the tracking
branches? Perhaps 'git remote update --auto-merge', configurable so I
can make auto-merge the default, and perhaps make it the default in
1.8. Also, maybe some people would like them to be auto merged only
when they can be fast-forwarded.

I believe this would make remote tracking branches much more useful.
What do you think?

Cheers

-- 
Felipe Contreras
