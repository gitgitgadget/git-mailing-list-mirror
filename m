From: Charles Duffy <cduffy@spamcop.net>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 20:58:09 -0500
Message-ID: <4536DBB1.6050701@spamcop.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> <45355CBB.80108@utoronto.ca> <BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE> <eh64tk$rug$2@sea.gmane.org> <BAYC1-PASMTP069C473B2E79389E5BFC92AE0F0@CEZ.ICE> <eh6dgr$pu8$1@sea.gmane.org> <Pine.LNX.4.63.0610190144450.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Thu Oct 19 04:00:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaNCW-0001qK-J4
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 04:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945982AbWJSB77 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 21:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945983AbWJSB76
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 21:59:58 -0400
Received: from main.gmane.org ([80.91.229.2]:24210 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1945982AbWJSB75 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 21:59:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GaNBP-0001eV-Qu
	for git@vger.kernel.org; Thu, 19 Oct 2006 03:58:59 +0200
Received: from user-12lmn28.cable.mindspring.com ([69.91.92.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 03:58:55 +0200
Received: from cduffy by user-12lmn28.cable.mindspring.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 03:58:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: user-12lmn28.cable.mindspring.com
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
In-Reply-To: <Pine.LNX.4.63.0610190144450.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29313>

Johannes Schindelin wrote:
> So, the wonderful upside of plugins you described here are actually the 
> reason I will never, _never_ use bzr with plugins.
> 

I presume that for this reason you will also never, _never_ use a 
non-mainline branch of git -- even if its actual code only touches UI 
enhancements or something similarly non-core -- because third-party 
branches have the ability, in theory, to make changes to the core of the 
revision control system. And that you will never, _never_ use 
third-party wrappers because they might play LD_PRELOAD tricks. Or run 
any software with root privileges you haven't personally written. Or...

Sean's point that plugins are a comparatively minor win made inexpensive 
on account of bzr's use of Python is reasonable (though we may choose to 
differ on what level of value we attach to the utility). The claim that 
an extensibility mechanism should be rejected wholesale on account of 
being excessively powerful, on the other hand, is just silly.



(If you couldn't write a plugin that *didn't* touch the core, this would 
be a different story. This is, however, very much not the case).
