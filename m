From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: git rebase likes to fail miserably on Mac OS X Lion
Date: Thu, 26 Jan 2012 22:25:23 -0700
Message-ID: <4F223543.3080903@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 27 06:32:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqePu-0000cb-Rh
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 06:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab2A0FcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 00:32:01 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:36854 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab2A0FcA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 00:32:00 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jan 2012 00:32:00 EST
Received: (qmail 15947 invoked by uid 399); 26 Jan 2012 22:25:18 -0700
Received: from unknown (HELO SlamDunk) (jjensen@workspacewhiz.com@67.182.221.164)
  by hsmail.qwknetllc.com with ESMTPAM; 26 Jan 2012 22:25:18 -0700
X-Originating-IP: 67.182.221.164
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
X-Antivirus: avast! (VPS 120126-2, 01/26/2012), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189192>

On 4 different Mac OS X Lion machines, rebasing my commits (I currently 
have 14 of them) yields either of the following _consistently_ across 
varied repositories:

     fatal: Unable to create 
'/Users/joshua/src/project/.git/index.lock': File exists.

or:

     error: Your local changes to the following files would be 
overwritten by merge:

^^^ There are no local changes when the rebase begins.  This is caused 
by the rebase.

I have tried both Git v1.7.5.4 and 1.7.8.4.

I use msysGit for the majority of my Git usage, and I do not run into 
this problem there.

Is there anything to be done?  Right now, the only workaround I can 
think of is to cherry pick changes one at a time as a fake rebase.  Ick.

Thanks.

Josh
