From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] A more sensible error message why 'git rebase --continue' 
 failed
Date: Mon, 20 Aug 2007 11:35:28 +0200
Organization: eudaptics software gmbh
Message-ID: <46C96060.7AC79FAD@eudaptics.com>
References: <11875724181583-git-send-email-evan@fallingsnow.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 11:42:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN3m7-0003RV-IE
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 11:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbXHTJmP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 05:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753207AbXHTJmP
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 05:42:15 -0400
Received: from main.gmane.org ([80.91.229.2]:41593 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759107AbXHTJmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 05:42:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IN3iy-0002OP-JH
	for git@vger.kernel.org; Mon, 20 Aug 2007 11:39:04 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 11:39:04 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 11:39:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56202>

Evan Phoenix wrote:
> 
> The current message is a bit cryptic, indicating that only changes which contained
> merge conflicts should be added to the index, but in fact, all outstanding
> changes must be.

I don't think that all files must be added if rebase -m was used: in
this case, non-conflicting changes are already in the index.

-- Hannes
