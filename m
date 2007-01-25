From: alan <alan@clueserver.org>
Subject: Re: Git Subversion problem
Date: Thu, 25 Jan 2007 08:54:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701250853400.14091@blackbox.fnordora.org>
References: <Pine.LNX.4.64.0701240935330.3282@blackbox.fnordora.org>
 <20070125095430.GA24742@localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jan 25 17:54:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA7rr-000525-Nt
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 17:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbXAYQy2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 11:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbXAYQy2
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 11:54:28 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:40230 "EHLO
	clueserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030342AbXAYQy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 11:54:27 -0500
Received: by clueserver.org (Postfix, from userid 500)
	id B0420F50C92; Thu, 25 Jan 2007 08:54:26 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id AB692F509AF;
	Thu, 25 Jan 2007 08:54:26 -0800 (PST)
X-X-Sender: alan@blackbox.fnordora.org
In-Reply-To: <20070125095430.GA24742@localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37740>

On Thu, 25 Jan 2007, Eric Wong wrote:

> alan <alan@clueserver.org> wrote:
>> I think I tracked down where my problem with using Git to pull subversion
>> repositories came from.
>>
>> It seems that if the repository has a file larger than what will fit in
>> memory, it does not react well.  (Yes, I know that you should not check in
>> huge data files into a repository, but accidents happen and Subversion
>> does not make it easy to remove them.)
>>
>> I can work around the problem at the moment, but it may be something that
>> the person who maintains that chunk of git may want to look at.
>
> Which version of git-svn are you using?

1.4.4.2 from FC6.

> Can you try git-svn from
> version 1.4.4.4 of git and see if that problem can be reproduced?  The
> new delta fetching code in the latest git.git master may try to store
> the entire file in memory when receiving it over the network.

I will give it a try and see if it chokes.

-- 
"Invoking the supernatural can explain anything, and hence explains nothing."
                   - University of Utah bioengineering professor Gregory Clark
