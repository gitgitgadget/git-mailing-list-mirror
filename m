From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: git diff-tree against the root commit
Date: Fri, 29 Oct 2010 00:13:55 -0600
Message-ID: <4CCA6623.8090705@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:13:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBiDt-0001iG-2Y
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619Ab0J2GNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 02:13:52 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:35221 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab0J2GNv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:13:51 -0400
Received: (qmail 6028 invoked by uid 399); 29 Oct 2010 00:13:50 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 29 Oct 2010 00:13:50 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.11) Gecko/20101013 Lightning/1.0b3pre Thunderbird/3.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160267>

I am mirroring a Git repository into another SCM.  I am using 'git 
diff-tree' to tell me what changes I need to make to the other SCM.

Today, I attempted to mirror a new submodule.  'git diff-tree' reported 
two SHAs... 0000000000000000000000000000000000000000 and the revision 
the submodule currently resides at.  I attempted to run a 'git 
diff-tree' within the submodule for the all zero SHA and the revision 
specified, but apparently, 0000000000000000000000000000000000000000 does 
not really represent the root commit and does not work.  I then 
discovered the --root option, but that doesn't seem to give me the 
complete file list either.

'git diff-tree' has been working great for everything else, but I really 
need a root commit diff-tree listing for proper automation.

What are my options?

Thanks!

Josh
