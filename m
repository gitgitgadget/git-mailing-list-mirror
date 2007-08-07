From: Matthias Kleine <matthias_kleine@gmx.de>
Subject: git-svn: Finding the svn-URL of the current branch in git
Date: Tue, 07 Aug 2007 20:29:23 +0200
Message-ID: <46B8BA03.1030809@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 20:29:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIToD-0008DD-Is
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 20:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbXHGS33 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 14:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbXHGS33
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 14:29:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:45288 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752203AbXHGS32 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 14:29:28 -0400
Received: (qmail invoked by alias); 07 Aug 2007 18:29:26 -0000
Received: from e178070063.adsl.alicedsl.de (EHLO [192.168.10.2]) [85.178.70.63]
  by mail.gmx.net (mp024) with SMTP; 07 Aug 2007 20:29:26 +0200
X-Authenticated: #2226356
X-Provags-ID: V01U2FsdGVkX18qTZU/HRYqJYYWS6PIHLesR6S5A7MjTTgeN7hEGo
	zubrPSAd+ASvDD
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55271>

Hi there,

when running "git-svn dcommit" git-svn tries to find the svn-URL of the 
current branch int git by looking for the most recent git log-entry 
corresponding to a commit in svn (see working_head_info in git-svn).  In 
case a merge just happended this might be the URL of another branch. 
Would using "log --first-parent" instead of a plain "log" take care of 
this problem or would it have other undesirable consequences?

Regards,
Matthias Kleine
