From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: repo.or.cz problem with blame/history/raw links
Date: Sat, 1 Dec 2007 17:04:43 +0100
Message-ID: <200712011704.43592.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 17:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyUqN-0007Gg-73
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 17:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbXLAQE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 11:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbXLAQE7
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 11:04:59 -0500
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:41654 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751627AbXLAQE6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Dec 2007 11:04:58 -0500
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id B16641E4FD3;
	Sat,  1 Dec 2007 17:04:56 +0100 (CET)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 87DFC2BEB7E;
	Sat,  1 Dec 2007 17:04:56 +0100 (CET)
Received: from fnoheim223.netpark.at (fnoheim223.netpark.at [83.68.151.223])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 58F8A19B337;
	Sat,  1 Dec 2007 17:04:56 +0100 (CET)
User-Agent: KMail/1.9.7
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.2/4968/Sat Dec  1 15:05:03 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66724>

Hi,

blame/history/raw links seems to be broken on repo.or.cz [1]
They have ARRAY(0x85bfb90) instead of the project name/path in the link

so the broken link looks like:
http://repo.or.cz/w/ARRAY(0x85bfb90)?a=blob_plain...

According to  Jakub Narebski this does not happen on unmodified gitweb.
Since i have little to no idea about gitweb maybe somebody else can have a 
look at it?

Greetings
Peter

[1]
for a example, follow the raw link on this page
http://repo.or.cz/w/stgit/kha.git?a=blob;f=stgit/commands/coalesce.py;h=e3e1629039e552dd8f1bd90cc3166c62a91adc5e;hb=c0a2dcbec69115469634c575dd3f281f08401ecf
