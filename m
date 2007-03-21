From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] Added make options NO_GUI and WITH_P4IMPORT.
Date: Wed, 21 Mar 2007 15:38:53 +0100
Message-ID: <4601437D.1010700@gnu.org>
References: <20070320114525.GP96806@codelabs.ru> <etpuen$2uo$2@sea.gmane.org> <20070321051406.GW96806@codelabs.ru> <Pine.LNX.4.63.0703211213100.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070321115004.GB14837@codelabs.ru> <Pine.LNX.4.63.0703211522320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eygene Ryabinkin <rea-git@codelabs.ru>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 15:39:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU1yH-0008VU-UV
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 15:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbXCUOjW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 10:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbXCUOjW
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 10:39:22 -0400
Received: from main.gmane.org ([80.91.229.2]:34400 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905AbXCUOjV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 10:39:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HU1y0-0000Lh-4X
	for git@vger.kernel.org; Wed, 21 Mar 2007 15:39:08 +0100
Received: from usilu-ge.ti-edu.ch ([195.176.176.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 15:39:08 +0100
Received: from bonzini by usilu-ge.ti-edu.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 15:39:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: usilu-ge.ti-edu.ch
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <Pine.LNX.4.63.0703211522320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42790>


>> I am happening to develop on some machines on which I have no
>> X-Windows or any GUI providers at all, so I prefer not to have the
>> Tcl/Tk dependency at all.
> 
> If you don't do something, it is often interesting to state why: if you 
> don't install something to prevent a dependency you don't want to have, it 
> is different from saying that you do not want to have a GUI, _even if_ the 
> dependency is there already.

I read his message as "these are useless for me, so why introduce a
useless dependency?"  The "effect" is to have no Tcl dependence,
but the original reason is to have no GUI.

So, "If you don't do something, it is often interesting to state why".
Why no TCL (in git)?  Because no X11 (on the machine).

Paolo
