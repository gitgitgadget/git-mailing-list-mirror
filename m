From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: Imports without Tariffs
Date: Sat, 13 Oct 2007 00:39:22 -0400
Message-ID: <8FCAF2B7-00A1-4AD1-A14E-CA88B5A84B89@mit.edu>
References: <30817A88-4313-4D38-95B0-FEC47C651CB0@mit.edu> <20071013040712.GA27227@coredump.intra.peff.net> <1240801C-F4CC-4290-8C3D-2038F1957DF3@MIT.EDU>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 06:39:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgYmm-0007nF-Fo
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 06:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbXJMEj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 00:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbXJMEj0
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 00:39:26 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:48807 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750984AbXJMEjZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Oct 2007 00:39:25 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9D4dOUS018299
	for <git@vger.kernel.org>; Sat, 13 Oct 2007 00:39:24 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9D4dNw3013246
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sat, 13 Oct 2007 00:39:23 -0400 (EDT)
In-Reply-To: <1240801C-F4CC-4290-8C3D-2038F1957DF3@MIT.EDU>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60722>

I apologize if you receive this twice.
I have now changed my email client to
use plain text by default.

On 13 Oct 2007, at 12:07:12 AM, Jeff King wrote:

> except that git-rebase is smart enough to realize that C == C' and  
> skip
> it (so it's a "safe" way of moving forward).

This is good to know! The documentation should mention this case!

>> However, this will not preserve more complicated history such as  
>> merges
>> from another git repository.
>
> Correct. Rebasing doesn't really handle merges, but I assumed you were
> just making simple commits on top of a cvs master.

Yes, you are quite correct. Your solution will work for me.
However, I think a general solution should be sought out.

Basically, the imported cvs history should be treated like
a remote that's being tracked. It seems like the solution
I proposed kind of does this and would work for other SCM
imports too.

>> Basically, I want to treat my git repository as the official
>> repository; the CVS repo is just their for the old farts to get the
>> latest stuff ;-P
>
> Then my suggestion doesn't really work. You might consider using  
> git as
> the official server and letting the old farts use git-cvsserver.

Unfortunately, they are the ones running the servers; I have to do my
git work behind the scenes.

Thanks,
Michael
