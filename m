From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: ! [rejected] master -> master (non-fast forward)
Date: Sun, 18 Nov 2007 10:12:10 -0500
Message-ID: <9e4733910711180712n6ee271fau774310e63ab08f6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 18 16:12:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itlp1-0005ac-FZ
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 16:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbXKRPMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 10:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752868AbXKRPMM
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 10:12:12 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:14915 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbXKRPML (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 10:12:11 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1674832wah
        for <git@vger.kernel.org>; Sun, 18 Nov 2007 07:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=vh/JjSg28dOYxSMKPYW5kNUcwsSH7yobsu7GZhUJXeo=;
        b=I5HafRj66SISsd9VROoTrFJFNgOJ+0Y80JZLvY5dEIHwsFvFBb5rbLnCHvLa1vAlpIunlZsld2ndeYqxlpP+O3e+heGm2VO7VdcNL80gJQbcRHVxznVYZ7LHLvdFZzi58YM57uAfyLKvF5NdS5IpMA934yhhMJsaF1fF11SQQqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YcYyHwW18g6wPxeqCpBap+tSCBXYvJKJArHEhuRetVC6897dL/S9b0TbGb68dqBjEhksfyC/bM9/EFJpkGE/hQyTlKTrMLOVcmX5Ftm55O/Otr0168pd7fAwfbuLbQIkDr5ab8jAoxw7mEdqL1pfDmixAgU0nzXRx6QBiHpg2Dk=
Received: by 10.114.184.7 with SMTP id h7mr401968waf.1195398730586;
        Sun, 18 Nov 2007 07:12:10 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Sun, 18 Nov 2007 07:12:10 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65371>

What's causing this? I'm using stgit on the master branch.
I'm fixing it each time on the remote server by deleting the ref to master.

jonsmirl@terra:~/ds$ git push digispeaker
To ssh://jonsmirl1@git.digispeaker.com/~/projects/digispeaker-kernel.git
 ! [rejected]        master -> master (non-fast forward)
error: failed to push to
'ssh://jonsmirl1@git.digispeaker.com/~/projects/digispeaker-kernel.git'
jonsmirl@terra:~/ds$

On the server I have:
[core]
        repositoryformatversion = 0
        filemode = true
        bare = true
        logallrefupdates = true

bare was set false, I just flipped it to true. The server repo was
originally created via a clone from kernel.org and then renamed to be
a bare repo. Why do we need a 'bare' attribute?

-- 
Jon Smirl
jonsmirl@gmail.com
