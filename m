From: Bill Yoder <byoder@cs.utexas.edu>
Subject: 1.3.2 git-clone segfaults
Date: Wed, 17 May 2006 13:32:39 -0500
Message-ID: <879BAFDD-87DB-4041-8753-5D63630076B5@cs.utexas.edu>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wolfgang Denk <wd@denx.de>
X-From: git-owner@vger.kernel.org Wed May 17 20:33:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgQpD-0000Z5-6C
	for gcvg-git@gmane.org; Wed, 17 May 2006 20:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWEQSco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 14:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWEQScn
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 14:32:43 -0400
Received: from smtpauth04.mail.atl.earthlink.net ([209.86.89.64]:63212 "EHLO
	smtpauth04.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1750878AbWEQScn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 14:32:43 -0400
Received: from [128.83.122.182] (helo=[128.83.122.182])
	by smtpauth04.mail.atl.earthlink.net with asmtp (Exim 4.34)
	id 1FgQp7-0000lV-Nf; Wed, 17 May 2006 14:32:41 -0400
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.750)
X-ELNK-Trace: 9592836211a6d0db1058e01f90253df340683398e744b8a4c379ccdaff32a659381b8bef45b073ec350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 128.83.122.182
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20218>

Dear Git maintainers:

I have twice downloaded git-1.3.2, most recently the git-1.3.2.tar.gz  
source package from http://www.t2-project.org/packages/git.html.   
Both the prebuilt version and the source version, built with gcc  
3.2.3 on x86/Linux, run into trouble when executing this command:

% git --exec-path=/usr/local/downloads/git-1.3.2 clone http:// 
www.denx.de/git/linux-2.6-denx.git linux-2.6-denx

Both git operations proceed with some 18,000+ lines of output,  
culminating in this message:

got 243a15f54002445f5b8b4938981ec90430b73ec6
got 03914b7e41b17871aea961f6522ec4ce26a4f8ed
got a305ae2e44b6dde305d3afe241768e32c47d8907
got 33a653913d942fa35c263edf1d019f36f4e0f5b1
got f13f49afe198cc0d59e998fe3a6e721d70fca6b4
error: The requested URL returned error: 405 (curl_result = 22,  
http_code = 405, sha1 = b323ff5779672c77b6adfba1c1bdc87f4981f85c)
error: Unable to find b323ff5779672c77b6adfba1c1bdc87f4981f85c under  
http://www.denx.de/git/linux-2.6-denx.git/
Cannot obtain needed blob b323ff5779672c77b6adfba1c1bdc87f4981f85c
while processing commit ea989b3245993f95e58e6c0320bf6165a949b072.
Waiting for http://www.denx.de/git/linux-2.6-denx.git/objects/ 
31/548303ee3767095f86efb47696ce433662450e
/usr/local/downloads/git-1.3.2/git-clone: line 323: 25972  
Segmentation fault      git-http-fetch -v -a -w "$tname" "$name" "$1/"

I have also tested git-1.2.3 built from source, and it works dandily.

Please let me know if I can supply more information or if I'm  
misusing the command.

Thanks,

Bill Yoder
Git Newbie
