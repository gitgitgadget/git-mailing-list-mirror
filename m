From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC] git-gui window layout
Date: Fri, 12 Oct 2007 12:00:54 +0200
Message-ID: <470F45D6.6050106@viscovery.net>
References: <470F3516.7020606@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Piatyszek <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 12 12:02:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgHKo-0001Ba-EB
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 12:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759452AbXJLKA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 06:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759145AbXJLKA6
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 06:00:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:44558 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759174AbXJLKA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 06:00:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IgHK2-0006cT-65; Fri, 12 Oct 2007 12:00:46 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4B0BD4E4; Fri, 12 Oct 2007 12:00:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <470F3516.7020606@users.sourceforge.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60668>

Adam Piatyszek schrieb:
> Dear Giters,
> 
> I would like you to comment on my idea to change, or at least add a
> possibility to change, the current layout of git-gui window.
> [...]
> 
> +-------------+----------------------------+---+
> |             |                            |###|
> |             |       commit log           |###|
> |   staged    +----------------------------+---+
> |             |                                |
> |             |                                |
> +----- 1 -----+                                |
> |             |       diff output              |
> |             2                                |
> |  unstaged   |                                |
> |             |                                |
> |             |                                |
> +-------------+--------------------------------+

May I point you to
http://repo.or.cz/w/git-gui.git?a=commitdiff;h=a0592d3f5746b41c60fee71dd8d2d27b5c813907
which was committed 5 hours ago.

Except that it has Unstaged above Staged and Diff above Commit, which IMHO 
is much more natural.

-- Hannes
