From: Andreas Ericsson <ae@op5.se>
Subject: Re: Better value for chunk_size when threaded
Date: Fri, 07 Dec 2007 09:57:18 +0100
Message-ID: <47590AEE.2080705@op5.se>
References: <9e4733910712061558k19fbc864ia1fb7a3431fd2603@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 09:57:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Z1l-00083T-Ob
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 09:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbXLGI5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 03:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbXLGI5W
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 03:57:22 -0500
Received: from mail.op5.se ([193.201.96.20]:60924 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbXLGI5V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 03:57:21 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7D9D11F08017;
	Fri,  7 Dec 2007 09:57:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vXBa4DGiTBBV; Fri,  7 Dec 2007 09:57:19 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 6EA5A1F08016;
	Fri,  7 Dec 2007 09:57:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <9e4733910712061558k19fbc864ia1fb7a3431fd2603@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67401>

Jon Smirl wrote:
> I tried some various ideas out for chunk_size and the best strategy I
> found was to simply set it to a constant. How does 20,000 work on
> other CPUs?
> 
> I'd turn on default threaded support with this change. With threads=1
> versus non-threaded there is no appreciable difference in the time.
> 
> Is there an API to ask how many CPUs are in the system? It would be
> nice to default the number of threads equal to the number of CPUs and
> only use pack.threads=X to override.
> 

I posted a patch to implement that just yesterday. It might need some
polishing, but it hasn't received any comments so far.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
