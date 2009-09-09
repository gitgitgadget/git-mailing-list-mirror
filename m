From: Henrik Tidefelt <tidefelt@isy.liu.se>
Subject: Problem with "dashless options"
Date: Wed, 9 Sep 2009 15:21:30 +0200
Message-ID: <D69FA890-4249-4DC9-B8AE-C9F105F1AD3B@isy.liu.se>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 15:52:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlNav-0002NW-Dt
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 15:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbZIINwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 09:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753178AbZIINwD
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 09:52:03 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:57220 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbZIINwC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 09:52:02 -0400
X-Greylist: delayed 1819 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Sep 2009 09:52:02 EDT
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 968AC25A9F
	for <git@vger.kernel.org>; Wed,  9 Sep 2009 15:21:44 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 24569-10 for <git@vger.kernel.org>;
 Sun, 31 Dec 1967 01:00:03 +0100 (MET)
Received: from [130.236.59.50] (59-50.isylogon.isy.liu.se [130.236.59.50])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id F29CD2577B
	for <git@vger.kernel.org>; Wed,  9 Sep 2009 15:21:26 +0200 (MEST)
X-Mailer: Apple Mail (2.753.1)
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128066>

Hi,

Yesterday I installed a fresh git (1.6.4.2) on my system using  
MacPorts.  Some of the git sub-commands work fine (for instance,  
checkout, status, remote), while push gives an error as follows:

$ git push isy next
fatal: BUG: dashless options don't support arguments

The same thing happens when I do

$ git push --repo=isy next

Since this seems to be a rather severe problem, I suppose it is that  
it is related to the old and perhaps unusual platform I am using.  It  
is a PowerPC machine running Mac OS 10.4, with GCC powerpc-apple- 
darwin8-gcc-4.0.1 and MacPorts 1.8.0.

I'll be happy to provide additional information that might help.


Best regards,

Henrik Tidefelt
