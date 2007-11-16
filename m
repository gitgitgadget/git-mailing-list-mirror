From: Andreas Ericsson <ae@op5.se>
Subject: Re: preserving mtime
Date: Fri, 16 Nov 2007 11:15:34 +0100
Message-ID: <473D6DC6.8040804@op5.se>
References: <473D63F9.4010201@inrim.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Fabrizio Pollastri <f.pollastri@inrim.it>
X-From: git-owner@vger.kernel.org Fri Nov 16 11:15:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsyEs-00072T-DQ
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 11:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520AbXKPKPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 05:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755157AbXKPKPi
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 05:15:38 -0500
Received: from mail.op5.se ([193.201.96.20]:33417 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbXKPKPh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 05:15:37 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 49BA61F08720;
	Fri, 16 Nov 2007 11:15:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sPgCtg3spCFf; Fri, 16 Nov 2007 11:15:35 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 2AEEB1F08716;
	Fri, 16 Nov 2007 11:15:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <473D63F9.4010201@inrim.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65210>

Fabrizio Pollastri wrote:
> Hi all,
> is it possible to tell git to preserve the file modification time in a 
> checked out copy? It is useful when managing web files, where mtime is 
> tested by spiders for download decisions.

No. Doing so would seriously break build-systems. If you want you can
have a post-checkout hook that sets the mtime on all the files though.
You should be able to parse the time the commit being checked out was
made from HEAD.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
