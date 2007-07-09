From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Mon, 09 Jul 2007 11:01:34 +0200
Organization: eudaptics software gmbh
Message-ID: <4691F96E.D869DF97@eudaptics.com>
References: <11839118073186-git-send-email-skimo@liacs.nl>
	 <1183911808787-git-send-email-skimo@liacs.nl>
	 <Pine.LNX.4.64.0707081729040.4248@racer.site> <46912726.5080807@midwinter.com>
	 <Pine.LNX.4.64.0707081920410.4248@racer.site> <20070708211034.GO1528MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 11:01:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7p77-0007vD-UJ
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 11:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbXGIJA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 05:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbXGIJA7
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 05:00:59 -0400
Received: from main.gmane.org ([80.91.229.2]:50330 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbXGIJA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 05:00:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I7p72-0007Lz-BO
	for git@vger.kernel.org; Mon, 09 Jul 2007 11:00:56 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 11:00:56 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 11:00:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51973>

Sven Verdoolaege wrote:
> I guess the major thing that is missing is --subdirectory-filter.
> Anything else?

Yes, how about this:

  $ git rewrite-commits --index-map '
         testresult=$($HOME/bin/expensive-test);
         [ $testresult = t ] && $HOME/bin/tweak-index ' \
     --commit-map '
         [ $testresult = t ] && $HOME/bin/tweak-commit '

:-P

-- Hannes
