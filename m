From: Andreas Ericsson <ae@op5.se>
Subject: Re: please consider remove those tags named master, which is ambigous
 with master branch
Date: Wed, 24 Sep 2008 20:56:54 +0200
Message-ID: <48DA8D76.1070207@op5.se>
References: <91b13c310808310948r5e9e825as27bcdf381137e179@mail.gmail.com>	 <91b13c310809230746o1c2cb694taebc814bea57c8c5@mail.gmail.com> <81b0412b0809240844y42218bedqe0e1eb22c067fcc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rae l <crquan@gmail.com>, Matthias Urlichs <smurf@smurf.noris.de>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 20:58:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiZYy-0004yr-R1
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 20:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbYIXS46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 14:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752402AbYIXS46
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 14:56:58 -0400
Received: from mail.op5.se ([193.201.96.20]:36607 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926AbYIXS45 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 14:56:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2C56E24B0042;
	Wed, 24 Sep 2008 20:47:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.109
X-Spam-Level: 
X-Spam-Status: No, score=-3.109 tagged_above=-10 required=6.6
	tests=[AWL=-0.610, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KCi1g6xmniue; Wed, 24 Sep 2008 20:47:35 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.18])
	by mail.op5.se (Postfix) with ESMTP id 83E891B80048;
	Wed, 24 Sep 2008 20:47:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <81b0412b0809240844y42218bedqe0e1eb22c067fcc3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96680>

Alex Riesen wrote:
> 2008/9/23 rae l <crquan@gmail.com>:
>> To Git developers:
>>  I found that different git subcommand have inconsitent processing
>> about ambiguous refname,
>>
>> git show will take "master" tag first,
>> while git tag -v will take "master" branch first,
>>
>> So what's your suggestion to fix this? Just simple remove ambiguous refnames?
> 
> You can use "refs/tags/master" and "refs/heads/master"...

Apart from that..

"git tag -v" taking a branch *at all* is not something we want to
happen, as it's supposed to verify the pgp signature of a signed
tag. Are you absolutely 100% certain that "git tag -v" tries to
verify refs/heads/master as a tag object?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
