From: Asger Ottar Alstrup <asger@ottaralstrup.dk>
Subject: Re: Anyone running GIT on native Windows
Date: Tue, 08 May 2007 20:21:29 +0200
Message-ID: <f1qeuf$c5o$1@sea.gmane.org>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>		 <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>		 <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>		 <463ECEF4.625F3633@eudaptics.com> <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com> <463F14FF.F8DF11EB@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 23:00:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlWnF-0002sz-IF
	for gcvg-git@gmane.org; Tue, 08 May 2007 23:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967735AbXEHVAH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 17:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967753AbXEHVAH
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 17:00:07 -0400
Received: from main.gmane.org ([80.91.229.2]:39010 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967735AbXEHVAF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 17:00:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HlWmw-0004DG-E1
	for git@vger.kernel.org; Tue, 08 May 2007 23:00:02 +0200
Received: from x1-6-00-06-1b-ce-5f-2f.k253.webspeed.dk ([80.162.62.94])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 May 2007 23:00:02 +0200
Received: from asger by x1-6-00-06-1b-ce-5f-2f.k253.webspeed.dk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 May 2007 23:00:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: x1-6-00-06-1b-ce-5f-2f.k253.webspeed.dk
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <463F14FF.F8DF11EB@eudaptics.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46624>

Johannes Sixt wrote:
> The next big thing to think about is an installer. Does anyone have a
> suggestion for a free installer tool? I only know about Microsoft's WiX
> (wix.sf.net), but it requires .NET (for the developer, not the user).

The relevant choices are:

- WiX - http://wix.sourceforge.net/
- NSIS - http://nsis.sourceforge.net/
- Inno Setup - http://www.jrsoftware.org/isinfo.php

NSIS is very low level, and thus has a pretty steep learning curve. You 
are more or less programming machine code. However, if you invest the 
time and energy, the NSIS installers are best of class: fast, small and 
it can do anything you want.

WiX is based on .MSI technology, which is somewhat slow, but of course 
it works, since it's the "official" Microsoft installation format.

Inno Setup is worth a second look. I think this might be the best choice 
for you: relatively simple to approach, and the installers are good.

Regards,
Asger Ottar Alstrup
