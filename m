From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: Scripted clone generating an incomplete, unusable .git/config
Date: Thu, 11 Nov 2010 09:00:43 +0100
Organization: ATLAS Elektronik GmbH
Message-ID: <4CDBA2AB.1020207@atlas-elektronik.com>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com> <4CDBA15A.6090301@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 09:00:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGS5I-0006Fi-Db
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 09:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757856Ab0KKIAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 03:00:23 -0500
Received: from lxsrv96.atlas.de ([194.156.172.86]:53822 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757852Ab0KKIAW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 03:00:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id C64D810088;
	Thu, 11 Nov 2010 09:00:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j5LZeWiP3fsg; Thu, 11 Nov 2010 09:00:21 +0100 (CET)
Received: from mgsrv01.atlas.de (unknown [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu, 11 Nov 2010 09:00:21 +0100 (CET)
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 6B79F2716A;
	Thu, 11 Nov 2010 09:00:21 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <4CDBA15A.6090301@atlas-elektronik.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161214>

On 11/11/2010 8:55 AM, Stefan Naewe wrote:
> On 11/11/2010 12:21 AM, Dun Peal wrote:
>>
>> Here's a bash log fully demonstrating the issue:
>>
>>   $ python -c "import os; os.popen('git clone
>> git@git.domain.com:repos/repo.git')"
>>   [...]
>> What's causing this?  Is it a bug?
> 
> Same for me with git version 1.7.3.2 on Debian Etch.

Make that 'Debian Lenny (5.0.6)' FWIW...

> Seems to be a problem with the popen() returning too early or
> the interpreter dying too early.

I forgot to say:

...because it works if I do it interactivley in the python shell.
 
> This works though:
> 
> $ python -c "import subprocess; subprocess.call(['git', 'clone', 'git://host/repoo.git'])"
 
Regards,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: I is knot dain bramaged!
