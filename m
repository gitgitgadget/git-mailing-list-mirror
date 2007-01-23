From: Andreas Ericsson <ae@op5.se>
Subject: Re: Deleting remote branches with git-branch and reflog questions
Date: Tue, 23 Jan 2007 14:02:39 +0100
Message-ID: <45B6076F.5060503@op5.se>
References: <200701231259.27719.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 14:03:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9LIw-0001mV-NH
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 14:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbXAWNDJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 08:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbXAWNDJ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 08:03:09 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:37350 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964976AbXAWNDI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 08:03:08 -0500
Received: from [172.27.78.30] (unknown [172.27.76.254])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 40F566BCC1; Tue, 23 Jan 2007 14:03:06 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701231259.27719.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37508>

Andy Parkins wrote:
> 
> reflogs
> -------
> 
> Why does the reflog directory .git/logs need to store the refs/ directory?  
> Aren't /all/ the refs under "refs/" these days?
> 

No. HEAD isn't, nor is ORIG_HEAD, and possibly others.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
