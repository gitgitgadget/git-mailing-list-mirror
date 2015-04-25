From: Chris <chrisb.duck@gmail.com>
Subject: bug report : 2.3.5  ssh repo not found
Date: Sat, 25 Apr 2015 06:57:28 +0100
Message-ID: <553B2CC8.9020204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 07:52:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylt0g-0003vD-Ew
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 07:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbbDYFvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 01:51:24 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35272 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbbDYFvX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 01:51:23 -0400
Received: by widdi4 with SMTP id di4so43839558wid.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 22:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=jmfGoyK0pxOoH15P2VuJ6DyNOJ2rXtlJNmf9LugIDZk=;
        b=0uy//9g50hb/n825+tCxiDBb/B8pQvWIKxsN7UnrjJHpkqZkUmGBuLUdCpl9O+pypa
         If66i/CtYk5Vbqp6vbVpcpXF2g5Oo0kK9sM4ue2fg845hTolrH8G7TsItuQLUqX47l3e
         sSpB8J4b+pwSNce0Eo87Z65SUuoTte306V2f9yYWKNb15Ut+wxtRG7gpo3d7/Rve5CZZ
         Lobt1mZj9ly8Z5AlcNMdxTG9EBHnsync750w6JB0XMjioqnvM+SF2hHVblDyxZOuZ/WB
         Np4D2rglto4wJKWzmm9KMaVCNd+4gkAcs90kbGw7rvF+fjb7pzx4jTR3kEBcET6klmgY
         CnQg==
X-Received: by 10.180.104.197 with SMTP id gg5mr2676940wib.27.1429941082187;
        Fri, 24 Apr 2015 22:51:22 -0700 (PDT)
Received: from [192.168.1.68] (host86-133-246-60.range86-133.btcentralplus.com. [86.133.246.60])
        by mx.google.com with ESMTPSA id ub1sm19676583wjc.43.2015.04.24.22.51.21
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2015 22:51:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267775>

Hello,

Using git version 2.3.5 with kernel 3.19.3-3-ARCH #1 SMP PREEMPT x86_64 
I see the following error message when pulling or cloning a repo over ssh:

"""
git clone ssh://user@mydomain:/home/user/path/to/project.git
Cloning into 'project'...
ssh: Could not resolve hostname mydomain:: Name or service not known
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
"""

Obviously I changed the url to hide credential info

After ensuring DNS was OK and being able to ssh to that instance 
directly I tried downgrading git to my distro's last installed version 
of git version 2.2.2 and now I can clone / pull / push to/from that repo 
without issue.

Is this a bug?

Best,
Chris
