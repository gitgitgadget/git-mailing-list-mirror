From: Andreas Ericsson <ae@op5.se>
Subject: Re: publish since current state?
Date: Mon, 17 Nov 2008 08:21:28 +0100
Message-ID: <49211B78.50204@op5.se>
References: <96ed5eac0811161242o4c800e37u7c96872a9a4351ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gennady Kushnir <genkush@rujel.net>
X-From: git-owner@vger.kernel.org Mon Nov 17 08:23:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1yRw-0007dS-8v
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 08:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689AbYKQHVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 02:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755595AbYKQHVg
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 02:21:36 -0500
Received: from mail.op5.se ([193.201.96.20]:37725 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779AbYKQHVe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 02:21:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E3E2A1B80FB3;
	Mon, 17 Nov 2008 08:16:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kcyU1oR-UG9G; Mon, 17 Nov 2008 08:16:16 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id 38F591B80FB1;
	Mon, 17 Nov 2008 08:16:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <96ed5eac0811161242o4c800e37u7c96872a9a4351ef@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101197>

Gennady Kushnir wrote:
> Hello list.
> I'm going to publish my work into online public repository.
> I have several months of previous history in my local git repo. And I
> don't want to make it all public.
> Is it possible to publish just a shallow copy of my repository storing
> my current tree?

Yes. Look for 'grafts' in the documentation. You'll have to create a
new repository containing only the most recent code first, and then
create the grafts-file in that repository and copy the object database
from the old repository into the new one.

> I'd also like to keep my local history private but push new commits
> from it into that online repo.
> 

The grafts solution will work like that, assuming you don't publish
your grafts-file.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
