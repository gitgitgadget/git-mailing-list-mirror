From: Andreas Ericsson <ae@op5.se>
Subject: Re: git to libgit2 code relicensing
Date: Mon, 17 Nov 2008 08:24:09 +0100
Message-ID: <49211C19.5010409@op5.se>
References: <491DE6CC.6060201@op5.se> <200811151615.42345.chriscool@tuxfamily.org> <49200914.6090506@op5.se> <alpine.DEB.1.00.0811162159280.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 17 08:25:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1yUO-00086S-Dc
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 08:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757144AbYKQHYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 02:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757140AbYKQHYR
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 02:24:17 -0500
Received: from mail.op5.se ([193.201.96.20]:46472 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757127AbYKQHYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 02:24:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 1E2581B80C10;
	Mon, 17 Nov 2008 08:19:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uOzBCwKpBQi1; Mon, 17 Nov 2008 08:18:58 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id E170E1B80FB1;
	Mon, 17 Nov 2008 08:18:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <alpine.DEB.1.00.0811162159280.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101198>

Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 16 Nov 2008, Andreas Ericsson wrote:
> 
>> With the current list of ok's 73.09% of the code in git.git seems to be 
>> relicenseable for the purpose of libgit2. That will provide quite a 
>> kickstart.
> 
> I doubt it.  Most of that code was written with the execute-once 
> mentality.  And with the we-have-posix mentality.
> 

"Copy-rewrite", naturally. Being able to lift much of the data-munging code
is a great benefit. It's basically just the revision traversal (which is
heavy on state-dependant code) that I haven't quite figured out how to do
yet, but I believe Shawn's idea of using revision pools is most likely the
way to go. Each application has to make sure a pool isn't modified by more
than one thread, but each application can have as many pools as it likes.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
