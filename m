From: Michael Witten <mfwitten@MIT.EDU>
Subject: (unknown)
Date: Sat, 13 Oct 2007 00:01:04 -0400
Message-ID: <30817A88-4313-4D38-95B0-FEC47C651CB0@mit.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 06:01:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgYBp-0003Yo-UH
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 06:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbXJMEBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 00:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbXJMEBP
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 00:01:15 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:44272 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750721AbXJMEBO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Oct 2007 00:01:14 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9D418uU002541;
	Sat, 13 Oct 2007 00:01:08 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9D415pb010170
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 13 Oct 2007 00:01:07 -0400 (EDT)
Subject: 
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60719>

I apologize if this is received twice.
I did add some comments, though!



On 12 Oct 2007, at 10:49:10 PM, Jeff King wrote:
> You are presumably doing a 'git-pull' on the cvsimport-ed commits. Try
> doing a git-rebase, which will filter out commits which make the same
> changes. Yes, it means throwing away your original commits, but the  
> new
> ones should be morally equivalent (and are now the "official" upstream
> of the CVS repository).

Now that you mention it, I think the best approach would be to:
	
	(1) cvsexportcommit
	(2) git reset --hard LAST_CVS_IMPORT_AND_MERGE
	(3) git cvsimport ..... # and merge

I think this is what you mean; it seems to me that rebasing isn't  
quite that.

However, this will not preserve more complicated history such as merges
from another git repository.

Basically, I want to treat my git repository as the official  
repository; the CVS
repo is just their for the old farts to get the latest stuff ;-P

Thanks!

Michael

PS
Please send me other opinions.
