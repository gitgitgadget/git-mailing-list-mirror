From: Paul Gardiner <osronline@glidos.net>
Subject: All I wanted was git-fast-export
Date: Sat, 09 Feb 2008 17:27:17 +0000
Message-ID: <47ADE275.3060109@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 18:28:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNtUz-0001oP-3Z
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 18:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034AbYBIR12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 12:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756364AbYBIR12
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 12:27:28 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:22327
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756034AbYBIR1Z (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 12:27:25 -0500
X-Trace: 37410299/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.162.32
X-SBRS: None
X-RemoteIP: 62.241.162.32
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAKtxrUc+8aIg/2dsb2JhbACoNQ
X-IP-Direction: IN
Received: from ranger.systems.pipex.net ([62.241.162.32])
  by smtp.pipex.tiscali.co.uk with ESMTP; 09 Feb 2008 17:27:21 +0000
Received: from [10.0.0.24] (80-42-19-184.dynamic.dsl.as9105.com [80.42.19.184])
	by ranger.systems.pipex.net (Postfix) with ESMTP id A1871E00008C
	for <git@vger.kernel.org>; Sat,  9 Feb 2008 17:27:19 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73246>

With your kind help, I've been able to convert a cvs repository
to git, but the last several years commits start with a line
saying "Summary;" :-(  I thought it might not be hard to put
a filter between git-fast-export and git-fast-import to sort
it out. Turns out though SuSE 10.3 has an old version of git
with git-fast-export missing.

I thought I'd try building git-1.5.4-1.src.rpm. Resolved most
of the dependencies, but I'm stuck with expat-devel and
perl(Error).

I installed Error-0.17012, but that seems to be the wrong
perl(Error). Anybody know where I can find the correct one?

SuSE 10.3 seems to have expat, but not expat-devel. I've
found expat-devel-2.0.1-4.i386.rpm, but that needs
expat-2.0.1-4, and SuSE 10.3 has expat-2.0.1-24. I can't
find expat-devel-2.0.1.24 anywhere.

I could, I guess, replace my current expat-2.0.1-24 with
expat-2.0.1-4, but I don't know how to check my systems
dependencies up front to see if that would be safe.

Any ideas, anyone?

P.
