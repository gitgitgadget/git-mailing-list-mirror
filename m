From: Vitali <vit.der.kapa@gmx.com>
Subject: blame moving&coping detection
Date: Fri, 10 Dec 2010 19:11:44 +0300
Message-ID: <4D025140.2090901@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 17:11:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR5ZY-0004La-4Z
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 17:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383Ab0LJQLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 11:11:47 -0500
Received: from mailout-eu.gmx.com ([213.165.64.42]:44001 "HELO
	mailout-eu.gmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756087Ab0LJQLq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 11:11:46 -0500
Received: (qmail invoked by alias); 10 Dec 2010 16:11:43 -0000
Received: from unknown (EHLO [46.147.39.201]) [46.147.39.201]
  by mail.gmx.com (mp-eu005) with SMTP; 10 Dec 2010 17:11:43 +0100
X-Authenticated: #66357070
X-Provags-ID: V01U2FsdGVkX18UNXpHat0U+frkiXugLAggPhsjy0depK947X/1Y9
	pIXE76FOBG8fiC
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; ru; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163420>

Blame with option -C can detect lines moved or copied from other files.
Any files that were modified in the same commit.

How can I tell git to look for moved or copied lines only in file from
which blamed file was created (copied or renamed)? Is it possible?
