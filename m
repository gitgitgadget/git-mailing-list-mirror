From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: git checkout under 1.7.6 does not properly list untracked files and
 aborts
Date: Fri, 09 Sep 2011 14:04:55 -0600
Message-ID: <4E6A7167.6070408@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 09 22:11:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R27Pu-0004Za-Ha
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 22:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932985Ab1IIUKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 16:10:52 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:58020 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759650Ab1IIUKw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 16:10:52 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Sep 2011 16:10:51 EDT
Received: (qmail 18873 invoked by uid 399); 9 Sep 2011 14:04:06 -0600
Received: from unknown (HELO ?192.168.1.101?) (jjensen@workspacewhiz.com@71.199.50.180)
  by hsmail.qwknetllc.com with ESMTPAM; 9 Sep 2011 14:04:06 -0600
X-Originating-IP: 71.199.50.180
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181117>

This may be an msysGit 1.7.6 issue, as that is what I am using.  It also 
occurs in msysGit 1.7.5, but I am almost certain it did not happen in 
msysGit 1.7.2.

Given an untracked file in the working directory that has been added to 
an alternate branch, when switching to that alternate branch, 'git 
checkout' exits with an error code but does not print anything to the 
console.  It should print an untracked file error.

I have been trying to track this down in code.  The point where the 
error messages are printed, display_error_msgs, is never hit.

I don't have a debugger to trace this on Windows, so I've just been 
adding lots of debug output.  So far, I have not found the catalyst.

I am out on vacation now for the next week and a half.  However, I 
thought I would send this along to see if someone else can confirm the 
the problem.  I'll continue investigation when I'm back.

Thanks.

Josh
