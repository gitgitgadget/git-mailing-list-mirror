From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: git-fetch--tool and contrib/examples/git-fetch.sh
Date: Thu, 15 Nov 2007 14:12:08 +0100
Message-ID: <473C45A8.7020903@lu.unisi.ch>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 15:12:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsfSI-0004bZ-Ea
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 15:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbXKOOMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 09:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbXKOOML
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 09:12:11 -0500
Received: from posta.ti-edu.ch ([195.176.176.171]:49607 "EHLO ti-edu.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750854AbXKOOMK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 09:12:10 -0500
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Nov 2007 09:12:10 EST
X-Virus-Scanned: by cgpav
Received: from mail.lu.unisi.ch ([195.176.178.40] verified)
  by ti-edu.ch (CommuniGate Pro SMTP 5.1.12)
  with ESMTP id 22997881 for git@vger.kernel.org; Thu, 15 Nov 2007 14:12:05 +0100
Received: from scientist-2.mobile.usilu.net ([192.168.76.126]) by mail.lu.unisi.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Nov 2007 14:12:05 +0100
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
X-OriginalArrivalTime: 15 Nov 2007 13:12:05.0143 (UTC) FILETIME=[1E3DD270:01C82789]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65122>

When git-fetch was builtin-ized the previous script was moved to 
contrib/examples.  Now, it is the sole remaining user for most of 
git-parse-remote (except for get_remote_url) and for git-fetch--tool.

Would it make sense to remove git-fetch--tool, the dead parts of 
git-parse-remote, and contrib/examples/git-fetch.sh?  Anyway, the script 
is very involuted unlike the other scripts in contrib/examples.

Paolo
