From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: git rebase chokes on directory -> symlink -> directory
Date: Thu, 10 May 2007 09:55:53 +0200
Organization: eudaptics software gmbh
Message-ID: <4642D009.9CEA2F3C@eudaptics.com>
References: <463FCD7C.4020009@zytor.com> <20070508215009.GA2670@steel.home>
		<46413565.3090503@zytor.com>
		<81b0412b0705090050i644a18c2g12c74462ab88163a@mail.gmail.com>
		<4641FDAF.3090608@zytor.com> <20070509213902.GA2593@steel.home>
		<46424ECC.6030907@zytor.com> <7vmz0dmb2u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 09:56:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm3VN-00021d-C8
	for gcvg-git@gmane.org; Thu, 10 May 2007 09:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbXEJH4A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 03:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756305AbXEJH4A
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 03:56:00 -0400
Received: from main.gmane.org ([80.91.229.2]:58424 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674AbXEJHz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 03:55:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hm3V8-0002su-LF
	for git@vger.kernel.org; Thu, 10 May 2007 09:55:50 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 May 2007 09:55:50 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 May 2007 09:55:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46841>

Junio C Hamano wrote:
>  * git-rebase with -m is dog slow.  There were people who
>    advocated to make it the default, but they probably are
>    either working in a very small project, or working on a
>    filesystem that even git-apply is slow that the speed
>    difference does not matter to them.

Heh... you name it. But just yesterday rebase -m was a life saver for me
because of its rename detection.

-- Hannes
