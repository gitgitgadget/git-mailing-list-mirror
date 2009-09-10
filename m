From: james bardin <jbardin@bu.edu>
Subject: bash_completion outside repo
Date: Thu, 10 Sep 2009 11:13:13 -0400
Message-ID: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 17:13:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MllKq-0001UK-SO
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 17:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbZIJPNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 11:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbZIJPNL
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 11:13:11 -0400
Received: from mail-vw0-f195.google.com ([209.85.212.195]:48704 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbZIJPNK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 11:13:10 -0400
Received: by vws33 with SMTP id 33so131422vws.33
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=ajTBLXc86G3UbkcSDqtXfdYGALTimgVmCmPK4hJeEho=;
        b=H6/U6FfGb0sb6KIWVtfW/ynbfWz7+KQfnmR3hW60XJ2KHCtOSsfHHpCsOaykujGLCk
         TDhwIvR6vhLVff25nGLvit1gW4zT6svhoIjMDT4madVvCu7Cr4Ji0RTF1+cwEtxPmT8o
         IigYVxU+5qp0n9u4iYUkZyi3KC7JTVSwkKP1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=Wndyh9JRV5yB3VIp6WFeqPquwmK7p2iHJWoJYvUl6v1Q6v427LVip3jxLgcBxBn0mx
         jiIuZGKY8jzfDJxeBlg965FGJe99L+y4I2VPqLCFBxNzt3s5EFRBRgBXzj0veJJeFXF7
         Ay9Iuv2f535hnlLdqgRgHTVsfT2FP40eqG38U=
Received: by 10.220.88.220 with SMTP id b28mr1645463vcm.35.1252595593405; Thu, 
	10 Sep 2009 08:13:13 -0700 (PDT)
X-Google-Sender-Auth: 0198dc697019a036
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128118>

Hi,

I'm making a git rpm for our site, and I'm getting an error with
bash_completion on RHEL/CentOS 5.

When outside a repo, any completion causes git to spit out
  fatal: error processing config file(s)

This is 1.6.4.2 using the contrib bash completion file

Thanks
-jim
