From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Automatically exclude hunks from the commit
Date: Mon, 19 Jul 2010 21:02:32 -0600
Message-ID: <4C4511C8.8090405@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 20 05:02:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob36J-0006Ld-94
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 05:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758105Ab0GTDC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 23:02:29 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:33728 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757941Ab0GTDC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 23:02:29 -0400
Received: (qmail 28333 invoked by uid 399); 19 Jul 2010 21:02:28 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 19 Jul 2010 21:02:28 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.4) Gecko/20100608 Lightning/1.0b2 Thunderbird/3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151295>

  I have some files I update frequently where I have some normally 
commented out debug code purposely uncommented during development.  
Git's hunk-level staging saves the day.  I can stage everything but the 
debug code without issue.

This got me to thinking.  Is there a better way?  Is there a facility in 
Git where I could mark a hunk as 'permanently frozen unstaged'?  
Anything marked as such would never be staged for commit.  I could rest 
assured I would never accidentally commit my debug code, be it extra 
printfs or a development server or a password or so on.

Thanks for the help.

Josh
