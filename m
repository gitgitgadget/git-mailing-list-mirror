From: Nasser Grainawi <nasser@codeaurora.org>
Subject: [JGIT] Request for help
Date: Wed, 02 Sep 2009 17:28:49 -0600
Organization: Code Aurora Forum
Message-ID: <4A9EFFB1.9090501@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 01:28:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MizG6-0004uB-Of
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 01:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbZIBX2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 19:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753817AbZIBX2r
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 19:28:47 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:9462 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809AbZIBX2r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 19:28:47 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5728"; a="23035603"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 02 Sep 2009 16:28:50 -0700
Received: from [129.46.10.111] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id C204510004C9;
	Wed,  2 Sep 2009 16:30:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127633>

Hello all,

I'm looking to add 'git patch-id' to JGit and I could use a few 
pointers. I'm not very familiar with the JGit code base or Java, so 
please excuse any blatant oversights or unintelligent questions.

First off, is there a "hacking JGit" document anywhere? One of those 
would be great right now.

So far I'm just trying to define the inputs and outputs. On Shawn's 
suggestion I'm planning on making it part of the org.spearce.jgit.patch 
package. C Git patch-id very generically has an input of a 'patch', so 
I'm thinking this implementation should use the Patch object. Looking at 
that class it seems that has everything patch-id should need, so perhaps 
that's the only input.

As far as output, C Git patch-id has the special feature to output the 
commit-id along with the patch-id when it gets input in the format of 
git-diff-tree. Should JGit do the same or just return the patch-id? I 
don't know that this question even makes sense in the context of JGit 
(since the commit-id is almost certainly available elsewhere and someone 
calling 'getPatchId()' is likely only interested in the patch-id).

Should PatchId be a class on its own, or just a method within the Patch 
class?

Thanks,
Nasser
