From: Andreas Ericsson <ae@op5.se>
Subject: Re: git pull on Linux/ACPI release tree
Date: Wed, 11 Jan 2006 01:26:55 +0100
Message-ID: <43C450CF.8070102@op5.se>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>	 <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org>	 <20060108230611.GP3774@stusta.de>	 <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org>	 <20060110201909.GB3911@stusta.de> <46a038f90601101233h5def4840k315be9520796b5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 11 01:27:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwTpP-0006gc-IC
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 01:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWAKA05 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 19:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWAKA05
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 19:26:57 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:17045 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932367AbWAKA04
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 19:26:56 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 779086BD03
	for <git@vger.kernel.org>; Wed, 11 Jan 2006 01:26:55 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <46a038f90601101233h5def4840k315be9520796b5e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14468>

Martin Langhoff wrote:
> On 1/11/06, Adrian Bunk <bunk@stusta.de> wrote:
> 
>>I am using the workaround of carrying the patches in a mail folder,
>>applying them in a batch, and not pulling from your tree between
>>applying a batch of patches and you pulling from my tree.
> 
> 
> In that case, there's a mostly automated way of doing that if you read
> the last couple lines of git-rebase, using something along the lines
> of
> 
>       git-format-patch <yours> <linus> | git-am -3 -k
> 

Isn't this rebase in a nutshell ?

> 
>>I'd say the main problem is that git with several other projects like
>>cogito and stg on top of it allow many different workflows. But finding
>>the one that suits one's needs without doing something in a wrong way
>>is non-trivial.
> 
> 
> You are right about that, but much of the space (of what workflows are
> interesting) is still being explored, and git and the porcelains
> reacting to people's interests. So it's still a moving target. A fast
> moving target.
> 

Good thing there are competent people around to snipe those targets in 
mid-stride. :)

I for one was amazed at how much easier git was to work with than any of 
the other scm's I've tried (quite a few, I never really liked any of 
them), and I really like the fact that it's flexible enough to suit 
(almost) all our needs. The only thing I haven't really found it to be 
satisfactory for is our collection of RPM spec-files and their 
respective patches, where we not so much change files as continuously 
replace them completely. Perhaps that's changed now that most 
git-commands can be run from subdirs.

So, kudos to Linus for inventing it, Junio for nursing it, and the other 
129 developers that have so far contributed to the current release.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
