From: Luke Lu <git@vicaya.com>
Subject: git-svn questions: how to clone/init non-standard layout branches/tags?
Date: Sat, 3 Nov 2007 01:19:13 -0700
Message-ID: <756D5EE2-FB2C-48DB-8242-14E154E34A9C@vicaya.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 09:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoEEs-0004Xy-Pc
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 09:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756969AbXKCIUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 04:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756937AbXKCIT7
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 04:19:59 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:43710 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756897AbXKCIT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 04:19:58 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1003791rvb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 01:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer:sender;
        bh=rHoQtoS6Bn1OMMJpYP0pUvhAfXgDp2fQtMw+C66r94I=;
        b=E7cX4zvmVeKnivwdIWgKMPpXgVYn5JuKvcsCU0ogpo2QA3dt2wCKOxm6wsbB+4JjuLHW4oQc3qcxmRGn4GpCwX9C5qFwU/1WsgefVmzQrbnDaoZ+eEK+dqtUC+t58Sp2tzqwQlvXPf7LswhPReC3qD9kUMcP3Rbyb6YGb+jJE4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer:sender;
        b=XcMJLKbl/KeZFnP9b18NRVGrPZLv4fy8fa1JvxUIe5GKxcX0RM0QctObDrckcDKF7ae+j49+ORmGptJd3Dxmqv0zm1f6sFRr38piR4UtebrCu50v2/8qpt+8gNcbcbxGyaXEW9h1MSL/HjXgA0spuzrLYTR9xDM7ilmGRyeYfxc=
Received: by 10.140.132.8 with SMTP id f8mr1328025rvd.1194077998363;
        Sat, 03 Nov 2007 01:19:58 -0700 (PDT)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id g39sm8412203rvb.2007.11.03.01.19.50
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Nov 2007 01:19:55 -0700 (PDT)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63217>

There are a few svn repositories that use non-standard layout like this:

<path_to_project>/trunk
<path_to_project>/production
<path_to_project>/some_branch

production and some_branch are indeed branched from trunk.

1. How do you init/clone svn repositories like that?
2. Is there a way to add a new svn branch like that (say production  
or some_branch) to an existing git-svn repository that has trunk cloned?

Thanks!

__Luke
