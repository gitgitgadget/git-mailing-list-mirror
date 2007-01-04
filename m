From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Skip excessive blank lines before commit body
Date: Thu, 04 Jan 2007 16:50:54 +0100
Message-ID: <459D225E.4010208@op5.se>
References: <11678312532251-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 04 16:51:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2Urz-0003dm-O5
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 16:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbXADPu5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 10:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbXADPu5
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 10:50:57 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:55059 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932374AbXADPu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 10:50:56 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 2E3F06BCC2; Thu,  4 Jan 2007 16:50:55 +0100 (CET)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Lars Hjemli <hjemli@gmail.com>
In-Reply-To: <11678312532251-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35936>

Lars Hjemli wrote:
> This modifies pretty_print_commit() to make the output of git-rev-list and
> friends a bit more predictable.
> 
> A commit body starting with blank lines might be unheard-of, but still possible
> to create using git-commit-tree (so is bound to appear somewhere, sometime).
> 

Lovely. I was just looking in to doing the exact same thing myself.

For reference, there is a tool somewhere that creates CVS commit 
messages with an empty title-line. When imported to git, those empty 
lines remain and fuzz up gitk and qgit viewing ad nauseum. I'm guessing 
(and hoping) this patch would take care of it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
