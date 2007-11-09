From: Andreas Ericsson <ae@op5.se>
Subject: Re: cogito remote branch
Date: Fri, 09 Nov 2007 14:20:05 +0100
Message-ID: <47345E85.8090702@op5.se>
References: <1IqTj5-24rt3I0@fwd33.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 14:20:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqTmc-0007p6-2I
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 14:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758489AbXKINUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 08:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758344AbXKINUL
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 08:20:11 -0500
Received: from mail.op5.se ([193.201.96.20]:36237 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758271AbXKINUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 08:20:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 4B85C1F0871E;
	Fri,  9 Nov 2007 14:20:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kARZrs8bm9-g; Fri,  9 Nov 2007 14:20:07 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 200A31F08715;
	Fri,  9 Nov 2007 14:20:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <1IqTj5-24rt3I0@fwd33.aul.t-online.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64175>

MichaelTiloDressel@t-online.de wrote:
> Hi,
> 
> I just saw the scripts cg-update, cg-push ..  scripts try to guess a
> branch name functioning as origin if no argument is given. These scripts
> seam to use a branch named <branchname>-origin if it exists and the
> current
> branch is named <branchname> and is not the branch named master.
> 
> I like that feature. Is it anywhere documented?
> 
> In case there is no branch named <branchname>-origin the scripts just
> use origin even if the current branch is not master. I would prefer the
> scripts to fail in this case and to print a message asking the user to
> specifically name a branch.
> 

Cogito is deprecated, and has been for quite some time. The "remote"
feature of core git (inspired by cogito) offers similar benefits.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
