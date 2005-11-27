From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Subject: Re: [PATCH 1/8] git-apply: work from subdirectory.
Date: Sun, 27 Nov 2005 22:13:27 +0100
Message-ID: <m3fyph7q14.fsf@quimbies.gnus.org>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy83cdu7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
	<7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net>
	<7viruf68bz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511260932080.13959@g5.osdl.org>
	<7v4q5yohta.fsf@assigned-by-dhcp.cox.net>
	<m364qef93a.fsf@quimbies.gnus.org>
	<7vy839dfzk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 22:17:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgTtL-00047v-9P
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 22:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVK0VQ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 16:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVK0VQ4
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 16:16:56 -0500
Received: from quimbies.gnus.org ([80.91.231.2]:63388 "EHLO quimbies.gnus.org")
	by vger.kernel.org with ESMTP id S1751149AbVK0VQz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 16:16:55 -0500
Received: from larsi by quimbies.gnus.org with local (Exim 3.36 #1 (Debian))
	id 1EgTpy-0000a0-00; Sun, 27 Nov 2005 22:13:30 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy839dfzk.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 27 Nov 2005 11:53:51 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.3.50 (gnu/linux)
X-Now-Playing: Retsin's _Salt Lick_: "Country Style Spoonin'"
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEU0Lzc6OUZTLzlZT1BZ
 O0OsSEnNwq7JnGKYePg7AAAACXBIWXMAAABIAAAASABGyWs+AAACM0lEQVQ4y12USZObQAyF1eDK
 ueV2KldGY9/pyMDVC665Ywhnl2vwPVOGvx91N2Ay7+BFn56WZgFQiFYDyqcx1tqsCQIFynJuVSCG
 2YcrAo15J0InxjHugMLHIEAcxuJkaHYkxZ3hJnE0x5LrS9s8hQgwDljpYC2Wm7pthkEcjTi4uLED
 Bo/lpWyefdc+mwrwJVOWpVTpO2cB1FMYE3LxZng8PZi1pu22adrhWXwDSKeTMwyFn0ovHKeLiw+D
 OCp3VKMiop2A/h4ci0pEvhIXw+NzAdZElQPMWPRLkPhK7aPv7j9lrhGAb+GIOzhznzZ3o2kP2ocD
 jwAUqhFIj7uATOZ1ILZ6nEpKXQVcGg+AhSlchz36vNtnbkHAVGCMG6CdA9x1+3M4q0O5MnGKJ3K1
 qjxvzGHnr2DGv/m8Ki87AdWOP+ntQ5KAOWuv9bk8SVYllmxP51/kwPnrWjyzrPY3jaANvcVEW+CW
 i4Kv7QwkaCJ6k1IpMwuSkchrdTJER7BCQDAnVAdQa1zDrBTSKAGgiLat3SgfARVIUMJ8QPdDv2Je
 6+wuT0WoonF0iYwp5BJOWWrO/9Ehjw7tHh09gbiTKRkngLNH7nDGL+tbg1KQzsVMbrWx3mGWM0He
 3aC4e7PREL/6/+kQouBQOk1R2xH0As6HsPH7nnleMv6bxJUOYPXBrx6SHUXznzSFw4ymsIaU/wOO
 JaFWLN/xEiSJ3zVl+C6tfGr0ioSN5GWkFyc7AkEJ4P4fnJmgR2GOvOsAAAAASUVORK5CYII=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12826>

Junio C Hamano <junkio@cox.net> writes:

> It may be that news.gmane.org doesn't chop, but somebody between
> vger.kernel.org mailing list manager and what comes out of the
> newsserver does. 

Egads!  It's all my fault -- there's some code in the mail-to-news
script that's truncating long header lines, and nobody's noticed up
'till now.  I've now twiddled it slightly; it should stop mangling
References headers now...

-- 
(domestic pets only, the antidote for overdose, milk.)
  larsi@gnus.org * Lars Magne Ingebrigtsen
