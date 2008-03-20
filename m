From: Bo Yang <techrazy.yang@gmail.com>
Subject: Make git-merge and helpers Builtins
Date: Thu, 20 Mar 2008 20:31:33 +0800
Message-ID: <47E25925.4050703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 13:33:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcJwv-0001Qy-Nc
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 13:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbYCTMcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 08:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753115AbYCTMcI
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 08:32:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:50014 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbYCTMcH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 08:32:07 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1016244wah.23
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 05:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=huF/Urff8VWsu2ir0xpUK9U3HN6aws/hTTkwnJGLBf4=;
        b=GiUxyleYR5ACtUHDxdyrgdRDiVAEu2+nTOEghEbjKuqnagE/fRh7CRrpDI1WnMrcJcrMEHWm5FxKITncZe0nH4nolxY1ZkD9hndfvDgEyqc8kSKsNHfG2KBaqkb84G19fUCGri8tNx1zOr9s4/G6RpTEGHvMf/LxyJTDJWzLAaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=dJw4dvqNNshPiBN+5cob31b0nS+WYI3Z8U/IS2EcWKeyV47lTHJbUgxPDwtJsOW163REQaehCqOPhRW/dTMh2rFoIX3Nbsqw8mfrB+y61z8gmhQRuxdYDZiEf9KS0QHQVWILpiNVpQaUz7BHMChMr9pcTtHKKr23H8ypWvc6nMc=
Received: by 10.114.151.13 with SMTP id y13mr3351051wad.145.1206016302768;
        Thu, 20 Mar 2008 05:31:42 -0700 (PDT)
Received: from ?192.168.1.163? ( [123.57.148.160])
        by mx.google.com with ESMTPS id m28sm2653560poh.7.2008.03.20.05.31.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Mar 2008 05:31:41 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77653>

Hi,
   I have used Git for one year, and I join into this list for 3 or 4 
monthes. Sometime, I post some questions here and followed some 
disscusions. I have noticed that, there is a potential project in this 
GSoC "make git-merge and helplers builtins". I think I am one of the 
suitable students for this project because I am familiar with shell 
script programming and c language. And I post this message here to hope 
I can discuss more with the community about this project. 
    I have git clone the Git's source code for some days. And with some 
insight into the code, I found that some of the merge related code is 
located in sh script:  git-merge-octopus.sh  git-merge-one-file.sh 
git-merge-resovle.sh git-merge.sh git-mergetool.sh . And others are 
located in c source code: builtin-merge-base.c builtin-merge-file.c 
builtin-merge-ours.c builtin-merge-recrusive.c and merge-file.c 
merge-tree.c merge-index.c merge-recursive.h for two simple declarations.
   And git-mergetool.sh is itself an interactive shell process, I think 
there is no need to deal with it. So, the main work for this project is 
to change the other four scripts into c format. For deatails, instead of 
call the git merge-base in the shell, we make the final corresponding c 
code to call the functions in the builtin-merge-base.c. Could you please 
tell more about the work if I miss something?
  
   Finally, I have some questions about the merge code. I found there 
are many merge related code and I can't understand them at a short time. 
So, pleaes help me if you can.

   1. git-merge-file is used to merge one file, but what are 
merge-octopus and merge-resovle?
   2. I see in builtin-merge-file.c and merge-file.c, there are both 
functions used to merge file. And finally, they both call the xdl_merge 
. Could you please tell me how differenct of these to methods? I ask 
this question because I think there are some redundant code in the git 
source. Forgive me if I am wrong, I have no hostility but want to know 
why things are like that.

Thank you!

Regards!
Bo
