From: Alp Toker <alp@atoker.com>
Subject: Re: [PATCH] Install built-ins as symlinks
Date: Tue, 11 Jul 2006 15:58:28 +0100
Message-ID: <44B3BC94.3000204@atoker.com>
References: <11526131782190-git-send-email-alp@atoker.com> <11526131781900-git-send-email-alp@atoker.com> <1152613179634-git-send-email-alp@atoker.com> <11526131791902-git-send-email-alp@atoker.com> <11526131792773-git-send-email-alp@atoker.com> <11526131792377-git-send-email-alp@atoker.com> <Pine.LNX.4.63.0607111614550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 16:59:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Jh3-0001n8-1a
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 16:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWGKO6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 10:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWGKO6a
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 10:58:30 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:65294 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1750949AbWGKO63 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 10:58:29 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by ndesk.org (Postfix) with ESMTP id 796C91645A1;
	Tue, 11 Jul 2006 15:58:28 +0100 (BST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607111614550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23715>

Johannes Schindelin wrote:
>> Doing this now will save headache in the long run, avoiding mismatched
>> versions of installed utilities and dangling copies of removed or
>> renamed git commands that still appear to work. It also makes screwups
>> when packaging git or making system backups less likely.
> 
> Could we please fix things, which are broken? Not things which work?

There are maybe a dozen arguments for and against the use of symlinks 
here, some of which Andreas has helpfully explained in his reply. You, 
on the other hand, have managed not to mention a single one of them.

If you don't have the technical background to review a certain patch, 
please don't add to the noise.
