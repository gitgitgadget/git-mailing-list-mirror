From: "Chris Smith" <smitty1elkml@gmail.com>
Subject: git fetch of 2.6.18-rc5-mm1
Date: Mon, 4 Sep 2006 17:42:37 -0400
Message-ID: <9b53a56d0609041442i2f9e56bao2e4b9f27a86f4d4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 04 23:42:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKMDK-0001RE-Iy
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 23:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWIDVmk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 17:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWIDVmj
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 17:42:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:6720 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964997AbWIDVmj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 17:42:39 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1104294nfa
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 14:42:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=b2KuTPwa318sPKkHwwZAvjE7efQd287Vt+budipwXYEk7sWdgaHkEmm/XtVlz5B6DPeg6OlZhG54lOMMlx6YlH3qsITmJnBgCk2X2wllTdff4OTq09ZrRHCTDpAlqnOqHpKBbDg+EuPhUYHp0yQV4IdLjwoeITwoRVcGyNImhKU=
Received: by 10.48.48.15 with SMTP id v15mr7133720nfv;
        Mon, 04 Sep 2006 14:42:37 -0700 (PDT)
Received: by 10.49.39.10 with HTTP; Mon, 4 Sep 2006 14:42:37 -0700 (PDT)
To: git@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26436>

n00b here.
Per Andrew Morton's release announcement boilerplate, which is:
git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git
v2.6.16-rc2-mm1

I tried:
git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git
v2.6.18-rc5-mm1
When I dropped in my .config and did
#make menuconfig
the tree showed its version as v2.6.16-rc2-mm1 still.

I can get a clean clone of the Linus tree, but not the -mm tree.
Additionally, navigating to
http://kernel.org/git/?o=age
and searching on "smurf" reveals this information:
linux/kernel/git/smurf/linux-trees.git  Tree imports. The main branch
...     Matthias Urlichs        6 months ago    summary | shortlog | log


Request someone help me understand where I'm off track.
-- 
Christopher Smith
Pursuer of knowledge
