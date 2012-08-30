From: Thomas Ackermann <th.acker66@arcor.de>
Subject: git blame shows wrong "Not commited yet" entries
Date: Thu, 30 Aug 2012 10:26:54 +0200 (CEST)
Message-ID: <303882026.440710.1346315214352.JavaMail.ngmail@webmail08.arcor-online.net>
References: <1055159053.19198.1345536909730.JavaMail.ngmail@webmail24.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 10:27:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T705p-0008I2-1n
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 10:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab2H3I05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 04:26:57 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:37128 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752371Ab2H3I04 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Aug 2012 04:26:56 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id 69605263A5
	for <git@vger.kernel.org>; Thu, 30 Aug 2012 10:26:54 +0200 (CEST)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 6665E7FE3DE
	for <git@vger.kernel.org>; Thu, 30 Aug 2012 10:26:54 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id 5EDD21AB533
	for <git@vger.kernel.org>; Thu, 30 Aug 2012 10:26:54 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-15.arcor-online.net 5EDD21AB533
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1346315214; bh=QQH1LJvAKP3tnahd88OWmfXIUMyd7ezFNqnCrwGBB1I=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=Qag2ISjMUhHqDwzw5lqw/WKvMNvgo0EY05EiC2Nj49/K1QMjuwGMPtb/zS1dpL3Ii
	 NWa5HmE01EKLUpPRtmYA9fWXPfT3csVm17M3LzcYzdPMlmsLAMv5XQKdivqK9kbLQZ
	 /0sHxQTGPZ31y0gMyxVzVhGyoWY2pDymJtbmUYHc=
Received: from [178.2.244.115] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Thu, 30 Aug 2012 10:26:54 +0200 (CEST)
In-Reply-To: <1055159053.19198.1345536909730.JavaMail.ngmail@webmail24.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.2.244.115
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204526>

 
Hi,

I am using MsysGit 1.7.11 on WinXP 32 bit and experience the folllowing strange behaviour:
 
For a file like "File.txt" in the repo, "git blame file.txt" (note the lower case)
shows "Not commited yet" for every single line in the file. 
"git blame File.txt" (correct upper case spelling) gives the correct output.
"core.ignorecase" is "true" so this behaviour is not what I expected.

Is this a bug in MsysGit or some kind of intended behaviour (or bug) in Git?


---
Thomas
