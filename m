From: Brian Ericson <bme@visi.com>
Subject: teach git diff -v/--invert-match?
Date: Fri, 22 Aug 2008 09:51:16 -0500
Message-ID: <48AED264.60600@visi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 17:08:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWYEU-0007SJ-A2
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 17:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbYHVPGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 11:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbYHVPGS
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 11:06:18 -0400
Received: from mailfront1.g2host.com ([208.42.176.212]:34882 "EHLO g2host.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751722AbYHVPGR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 11:06:17 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Aug 2008 11:06:17 EDT
Received: from [209.98.56.25] (account bme@visi.com [209.98.56.25] verified)
  by mailfront1.g2host.com (CommuniGate Pro SMTP 5.1.16)
  with ESMTPA id 63692444 for git@vger.kernel.org; Fri, 22 Aug 2008 09:51:16 -0500
User-Agent: Thunderbird 2.0.0.16 (X11/20080805)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93308>

I'm wondering what it would take to teach git diff to invert the -S 
string (like git grep).

I'm finding git diff -S<string> [--pickaxe-regex] to be really useful, 
but find I have cases where I want to ignore differences.  For example, 
I might not care if the only changes to a Java file, for example, are 
related to import statements.  I'd like to be able to do something like 
"git diff -S'^import' --pickaxe-regex -v".  I'll admit I can get by with 
something like "git diff -S'^[^i]' --pickaxe-regex", but am pining for 
-v/--invert-match.
