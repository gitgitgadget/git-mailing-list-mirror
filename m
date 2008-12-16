From: "Emily Ren" <lingyan.ren@gmail.com>
Subject: Can I use git protocol to push change to remote repo?
Date: Tue, 16 Dec 2008 15:22:17 +0800
Message-ID: <856bfe0e0812152322i3a7fa376h8a35466b7abf82a5@mail.gmail.com>
References: <856bfe0e0812152318h1375401fx944834ad6410835d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 08:23:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCUHQ-0005mP-IY
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 08:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbYLPHWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 02:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbYLPHWS
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 02:22:18 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:29490 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbYLPHWS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 02:22:18 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1283876yxm.1
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 23:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=oHgIftEbD+Eqw4DeKJPZVpyn0ATV/pnj/r+1L6lWWws=;
        b=CDM4d6OCsekj0YKjk70XMjvdz5W8J4yW6AHkDMr7mghpbcWTZoWx7slA0n7R23MEOm
         EzYwDMsOUzTUNIBAd4otCyH4XX3BIBoONNjVC9InJTawQIbaPMcP8neyD8a2RV1r0hOI
         LcJCb7evsB+TeFqffop8JS7TvFLlOsmuN4m68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=K+/X2oD+kekiLziGGFNU4RQ03LrkiuKyP7ZniaXd2veRCvzq6IfreaRzAIRmW/5kGX
         7GVd8GIoFTVU1ROq9tRGnEU5WL5z3Z7vVicdKdjLlFJmF+t/xhlEmuS6OmywKpE4ozoN
         1Kv105pGN6v5oZx66tVT5WmnYe3rV4w7taisw=
Received: by 10.150.226.15 with SMTP id y15mr14149005ybg.225.1229412137147;
        Mon, 15 Dec 2008 23:22:17 -0800 (PST)
Received: by 10.150.225.13 with HTTP; Mon, 15 Dec 2008 23:22:17 -0800 (PST)
In-Reply-To: <856bfe0e0812152318h1375401fx944834ad6410835d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103253>

Hello,

I can clone a remote repo with git protocol, but I can't push my
branch to origin repo with git protocol. If I use ssh protocol, I can
push sccuessfully. I'm confused, can someone give me a guide on this?
Can I use git protocol to push my branch to remote repo? If yes, how
can I do ? Thank you for your help in advance !

Error info is as below:
 $ git push git://host.xz/testgit check_push
fatal: The remote end hung up unexpectedly
error: failed to push to 'git://host.xz/testgit'

Successful info with ssh protocol:
$ git push ssh://host.xz/testgit check_push
user's password:
updating 'refs/heads/check_push'
  from 0000000000000000000000000000000000000000
  to   60719ede9ef5d5fdc042e7aebcebc04a93d3928a
Generating pack...
Done counting 3 objects.
Deltifying 3 objects...
 100% (3/3) done
Writing 3 objects...
 100% (3/3) done
Total 3 (delta 0), reused 0 (delta 0)

Thanks,
Emily
