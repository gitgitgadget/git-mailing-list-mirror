From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git pull is slow
Date: Thu, 10 Jul 2008 17:30:47 +0200
Message-ID: <48762B27.90004@viscovery.net>
References: <g5570s$d5m$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephan Hennig <mailing_list@arcor.de>
X-From: git-owner@vger.kernel.org Thu Jul 10 17:37:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGyCQ-0006Tc-7u
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 17:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758763AbYGJPav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 11:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760301AbYGJPau
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 11:30:50 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36602 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760293AbYGJPat (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 11:30:49 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KGy6a-0005YC-HG; Thu, 10 Jul 2008 17:30:48 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 235476D9; Thu, 10 Jul 2008 17:30:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <g5570s$d5m$1@ger.gmane.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87984>

Stephan Hennig schrieb:
> I am observing very large data transfers when pulling from the
> repository at <URL:http://repo.or.cz/w/wortliste.git>.  This repository
> contains one 13 MB text file that compressed is roughly 3 MB large.
> 
> While I'd expect pulling commits that change only a few lines of the
> large text file to result in a download of less than, say 10kB, git pull
> seems to transfer the complete, compressed file.  I have observed this
> several times for different commits.  On the other hand, pushing my own
> commits to the repository is fast (with git+ssh access method).  Any
> ideas what's going on and how to make pulling faster?

Do you by any chance use a http URL to pull? Don't do that. Use git protocol.

-- Hannes
