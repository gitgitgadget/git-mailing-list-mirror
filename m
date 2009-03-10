From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] winansi: support ESC [ K (erase in line)
Date: Tue, 10 Mar 2009 08:15:03 +0100
Message-ID: <49B61377.90103@viscovery.net>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 10 08:16:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgwCf-0005Fa-T5
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 08:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbZCJHPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 03:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbZCJHPM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 03:15:12 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:44379 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbZCJHPL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 03:15:11 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LgwB5-0000AR-SA; Tue, 10 Mar 2009 08:15:04 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 89AE74FB; Tue, 10 Mar 2009 08:15:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112786>

Johannes Schindelin schrieb:
> 	This fixes the last bit of msysGit issue 124 for me:
> 
> 		http://code.google.com/p/msysgit/issues/detail?id=124
> 
> 	which annoyed me one time to many today.
> 
> 	I had an earlier version which was smaller, but pretty hacky, in 
> 	that it checked if fprintf is #define'd in xwrite(), and had 
> 	special handling for that case.
> 
> 	This patch is only slightly hacky, in that it assumes that you do 
> 	not try to output something that ends in an incomplete ESC [
> 	sequence.

Good that I read mail before I start hacking. I was about to do something
about this in a moment. ;)

> To make use of it during a fetch, write() needs to be overridden, too.

No, that's not necessary with the patch that I'm about to send in a
moment. To replace write() for ANSI emulation really goes too far.

-- Hannes
