From: Lea Wiemann <lewiemann@gmail.com>
Subject: git rebase --continue error message
Date: Sun, 22 Jun 2008 05:21:53 +0200
Message-ID: <485DC551.9020807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 22 05:23:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAGAj-0005Pm-Jl
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 05:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbYFVDWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 23:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbYFVDWE
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 23:22:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:55524 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbYFVDV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 23:21:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so907618fgg.17
        for <git@vger.kernel.org>; Sat, 21 Jun 2008 20:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding:from;
        bh=13Pikd4QR2n4VFrVrWuK09n5YebJJsQgaGBhBbRe884=;
        b=khpT7TER7yNBLcOqABrsBL35sGQejFIvDN5SyGbiF8Yw5eSH57Wy/K8m+HfvMJTbcv
         d4INqe3opT4k1Hpq7C+szTRiO9V9ijxOW70fRljt3cVjYGbOpmfmFgYOOhme5OdpzQjs
         w7y79eEvL39aE8zMkT0UA3ITVikb937EAXnwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding:from;
        b=do9VY83H/J1peHzqW7by7D1VUC+hg2WMOQUaIUqWktV6lHKa6ZhSt+/Y9U957AXcfW
         Gu7nDC/7karzS8Q96J6/+xAeqyntUwo0+Wrmk/XLxV/VNVimEPOa1DnXHz2O55IXR/PT
         5ZEJTF2FkrTm+vr5haEBNpDx0t6/Bf5yhVEJk=
Received: by 10.86.68.20 with SMTP id q20mr6385448fga.2.1214104917144;
        Sat, 21 Jun 2008 20:21:57 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.251.200])
        by mx.google.com with ESMTPS id e11sm6970847fga.4.2008.06.21.20.21.54
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 21 Jun 2008 20:21:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85745>

The error message for git rebase --continue is misleading if no rebase 
is in progress:

$ git rebase --abort
No rebase in progress?
$ git rebase --continue
You must edit all merge conflicts and then
mark them as resolved using git add

Anyone care to fix it?
