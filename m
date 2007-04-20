From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Do not show progress meter while checking files out.
Date: Fri, 20 Apr 2007 11:37:32 +0200
Organization: eudaptics software gmbh
Message-ID: <462889DC.44F4569@eudaptics.com>
References: <11770585393395-git-send-email-junkio@cox.net> <1177058540390-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 11:38:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HepZI-0005qv-Ul
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 11:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766639AbXDTJhu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 05:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766578AbXDTJht
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 05:37:49 -0400
Received: from main.gmane.org ([80.91.229.2]:42044 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1766639AbXDTJht (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 05:37:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HepYg-0001IZ-SV
	for git@vger.kernel.org; Fri, 20 Apr 2007 11:37:38 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Apr 2007 11:37:38 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Apr 2007 11:37:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45078>

Junio C Hamano wrote:
> 
> Originally I thought it would take too long to check out many
> files and to prevent people from getting bored, I added progress
> meter.  But it feels a bit too noisy; let's disable it.

Hm. The only place where I've seen this particular progress meter is
after a clone. Which is quite noisy anyway.

Here on my windows box, this progress meter *is* entertaining. My
project has ~2400 files, and it takes its time. If you really want to
get rid of it, then please leave the message "Checking out files...",
which together with a thrashing disk should give "progress" enough for
people who do their first clone.

-- Hannes
