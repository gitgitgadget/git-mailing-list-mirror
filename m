From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Speed of conversion from Subversion repository to Git
Date: Tue, 02 Feb 2010 12:20:35 +0100
Message-ID: <4B680A83.80200@web.de>
References: <4B6717DF.8020004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 12:20:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcGoE-0007VF-QY
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 12:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231Ab0BBLUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 06:20:37 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:36252 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626Ab0BBLUg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 06:20:36 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id DB8D213CF67A8
	for <git@vger.kernel.org>; Tue,  2 Feb 2010 12:20:35 +0100 (CET)
Received: from [78.49.150.133] (helo=[192.168.1.202])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NcGo7-00008M-00
	for git@vger.kernel.org; Tue, 02 Feb 2010 12:20:35 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <4B6717DF.8020004@web.de>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1/Gdy4xfPFSkq/BTP7iB9az87FpcFR3TCk/NDA/
	JKPim72NqngmnDZR2bm7WhOq9zgIGQvvjme0sfC7nbWrnfK8dI
	kGkjy12QQVEsbg1uVC9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138712>

Hello,

The execution of the command "svn2git http://svn.opensuse.org/svn/yast/" was finished today somewhere during the night. I used the version 1.3.1 together with Git 1.6.6.1 on my openSUSE 11.2 system. Now I hope that my conversion try was really successful.

elfring@Sonne:~/Projekte/YaST/lokal> du -hs .git . && git branch
518M    .git
653M    .
  Moblin
  REFACTORING-10_3
  SuSE-Code-11-Branch
  SuSE-Code-11-SP1-Branch
  SuSE-Linux-10_0-Branch
  SuSE-Linux-10_1-Branch
  SuSE-Linux-10_1-Branch@30668
  SuSE-Linux-10_2-Branch
  SuSE-Linux-10_3-Branch
  SuSE-Linux-11_0-Branch
  SuSE-Linux-11_2-Branch
  SuSE-Linux-9_3-Branch
  SuSE-SLE-10-Branch
  SuSE-SLE-10-SP1-Branch
  SuSE-SLE-10-SP1-Features-Branch
  SuSE-SLE-10-SP2-Branch
  SuSE-SLE-10-SP3-Branch
  YaST2-X11-2-13-SuSE-10-1
  YaST2-X11-2-13-SuSE-10-1@29086
  YaST2-X11-2-14-SuSE-10-2
  YaST2-X11-2-14-SuSE-10-2@34577
* master
  moblin
  research
  selection_widgets_cleanup-core
  selection_widgets_cleanup-core@22138
  selection_widgets_cleanup-qt
  selection_widgets_cleanup-qt@22138
  tmp
  unsupported

The network activity was mostly low during this lengthy process. Are more software developers interested to speed this procedure up?
Do know ways to improve the processor utilisation so that such a data import will be completed faster?

Regards,
Markus
