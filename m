From: Christopher Jefferson <caj@cs.st-andrews.ac.uk>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 14:30:10 +0100
Message-ID: <submission.1M9JCt-00047m-4a@mail.cs.st-andrews.ac.uk>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk> <4A1D2614.5060303@op5.se> <43d8ce650905270628o2eb4ed3cqf6b78e00933198af@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 15:30:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9JD2-0001i6-Up
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 15:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761611AbZE0NaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 09:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761763AbZE0NaK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 09:30:10 -0400
Received: from mail.cs.st-andrews.ac.uk ([138.251.206.35]:59944 "EHLO
	mail.cs.st-andrews.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761574AbZE0NaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 09:30:09 -0400
Received: by mail.cs.st-andrews.ac.uk with esmtpsa (authid caj) (TLSv1:AES128-SHA:128)
	(Exim 4.43)
	id 1M9JCt-00047m-4a; Wed, 27 May 2009 14:30:11 +0100
In-Reply-To: <43d8ce650905270628o2eb4ed3cqf6b78e00933198af@mail.gmail.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120062>


On 27 May 2009, at 14:28, John Tapsell wrote:

> 2009/5/27 Andreas Ericsson <ae@op5.se>:
>> Christopher Jefferson wrote:
>>> If the requirement that all files can be mmapped cannot be easily  
>>> removed,
>>> would be it perhaps be acceptable to impose a (soft?) 1GB(ish)  
>>> file size
>>> limit?
>>
>> Most definitely not. Why should we limit a cross-platform system for
>> the benefit of one particular developer's lacking hardware?
>
> Perhaps a simple warning would suffice  "Warning: Files larger than
> 2GB may cause problems when trying to checkout on Windows."
>

Something like that, except that limit seems to be only 1.3GB on Mac  
OS X

Chris
