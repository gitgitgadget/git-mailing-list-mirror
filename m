From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Following history of a copied file from another indirect branch
Date: Thu, 21 Oct 2010 12:47:01 -0600
Message-ID: <4CC08AA5.8070502@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 21 20:47:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P90AP-0000kf-Or
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 20:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757316Ab0JUSrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 14:47:04 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:50295 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab0JUSrD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 14:47:03 -0400
Received: (qmail 12918 invoked by uid 399); 21 Oct 2010 12:47:00 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@69.98.137.222)
  by hsmail.qwknetllc.com with ESMTPAM; 21 Oct 2010 12:47:00 -0600
X-Originating-IP: 69.98.137.222
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.11) Gecko/20101013 Lightning/1.0b3pre Thunderbird/3.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159535>

It has become a necessity to copy a file from one long-lived branch to 
another.  It is not possible to merge the branches at this time.

I would like to have 'git gui blame' follow the copy back through its 
original history, but I don't believe Git has metadata for storing 
this.  Something along the lines of a 'followparent' in the commit 
object, for instance, would allow the revision walking code to wander 
the history down an alternate line.

By comparison, integrates work at a file level in Perforce.  That means 
I can integrate a file from one branch to another, and parentage is 
stored such that I can follow the file back through its history.

Are there any facilities to do this now?

Thanks!

Josh
