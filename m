From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Add git-filter-branch
Date: Mon, 04 Jun 2007 09:59:40 +0200
Organization: eudaptics software gmbh
Message-ID: <4663C66C.3C5603B7@eudaptics.com>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <4663BCDA.F1BADDD8@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 09:59:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv7Sx-0001Qr-5h
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 09:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbXFDH6z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 03:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbXFDH6z
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 03:58:55 -0400
Received: from main.gmane.org ([80.91.229.2]:47321 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241AbXFDH6z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 03:58:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hv7Si-0002eM-HM
	for git@vger.kernel.org; Mon, 04 Jun 2007 09:58:48 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 09:58:48 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 09:58:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49079>

Johannes Sixt wrote:
> ... this, means that any simple command like
> 
>   git filter-branch -k orgin/master origin/next new-next

Make this:

   git filter-branch -k orgin/master -s origin/next new-next

-- Hannes
