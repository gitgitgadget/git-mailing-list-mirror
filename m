From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: git rev-parse broken on Git for Windows
Date: Thu, 29 Jul 2010 23:25:52 -0600
Message-ID: <4C526260.6000104@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Jul 30 07:26:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oei6g-0005y8-9H
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 07:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655Ab0G3FZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 01:25:52 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:56033 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab0G3FZv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 01:25:51 -0400
Received: (qmail 18505 invoked by uid 399); 29 Jul 2010 23:25:50 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 29 Jul 2010 23:25:50 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.7) Gecko/20100713 Lightning/1.0b2 Thunderbird/3.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152219>

  9c7304e3e39ed397b3cc6566573333e2698a52b4 (print the usage string on 
stdout instead of stderr) and then 
47e9cd28f8a404a0d6293935252ddca5fc243931 (parseopt: wrap rev-parse 
--parseopt usage for eval consumption) break the following line from the 
manual and 'git subtree' on msysGit:

eval $(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)

Running 'git revert' on both changelists causes the 'git rev-parse 
--parseopt' to work again.

What was 9c7304e trying to solve?

Thanks.

Josh
