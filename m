From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: What are the ways CRLF files can make it into the repository?
Date: Fri, 21 Sep 2012 13:02:11 -0600
Message-ID: <505CB9B3.5010307@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 21:02:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF8Ub-0007x3-Bg
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 21:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933098Ab2IUTCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 15:02:16 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:46624 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933071Ab2IUTCP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 15:02:15 -0400
Received: (qmail 24008 invoked by uid 399); 21 Sep 2012 13:01:42 -0600
Received: from unknown (HELO SlamDunk) (jjensen@workspacewhiz.com@204.238.46.101)
  by hsmail.qwknetllc.com with ESMTPAM; 21 Sep 2012 13:01:42 -0600
X-Originating-IP: 204.238.46.101
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
X-Antivirus: avast! (VPS 120921-0, 09/21/2012), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206150>

Hi.

We've been running with core.autocrlf = input (some people with 
core.autocrlf = true).  However, there are some text files in the 
repository that are CRLF, and I am at a loss to explain how they go here.

We understand that if core.autocrlf=false, this could happen.  While I 
admit there is a remote possibility this did occur, I'm not convinced 
our people were smart enough with Git 1.5 years ago to make this 
configuration change.

There are no .gitattributes settings for these source code files.

Are there other ways CRLF files could sneak into the repository?

Thanks.

Josh
