From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Feature request: thin checkout
Date: Fri, 15 Jun 2007 12:44:47 +0200
Organization: eudaptics software gmbh
Message-ID: <46726D9F.C4801AA@eudaptics.com>
References: <20070615085346.8027.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 12:45:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz9Iq-0005pU-R5
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 12:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbXFOKpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 06:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbXFOKpJ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 06:45:09 -0400
Received: from main.gmane.org ([80.91.229.2]:60304 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229AbXFOKpH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 06:45:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hz9Id-0003Kr-T6
	for git@vger.kernel.org; Fri, 15 Jun 2007 12:45:03 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Jun 2007 12:45:03 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Jun 2007 12:45:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50258>

linux@horizon.com wrote:
> Wouldn't it be nice if there were a way to tell git-update-index and
> git-checkout index that certain directories are not in the working
> directory, but don't worry.  Just pretend they exist and match the index.
> 
> Then I could mark much of arch/* as "don't bother" and save a pile of
> disk space per working directory.

Currently, directories are not registered in the index. For this reason,
empty directories cannot be versioned. One day, will want to support
this, and for this purpose, directories must also be registered in the
index. Once this infrastructure is in place, the "don't bother" flag
will be a no-brainer, methinks.

-- Hannes
