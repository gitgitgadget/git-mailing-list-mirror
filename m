From: Grant Erickson <gerickson@nuovations.com>
Subject: Re: GIT and Cloning Remote Repositories into "Local Remote"
 Repositories
Date: Mon, 27 Sep 2010 08:29:03 -0700
Organization: Nuovation System Designs, LLC
Message-ID: <C8C6064F.1E675%gerickson@nuovations.com>
References: <20100927151807.GE31809@foucault.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Casey Dahlin <cdahlin@redhat.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 17:29:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Fdq-0005j6-Q3
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 17:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759600Ab0I0P3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 11:29:17 -0400
Received: from relay01.pair.com ([209.68.5.15]:4471 "HELO relay01.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759571Ab0I0P3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 11:29:16 -0400
Received: (qmail 87774 invoked by uid 0); 27 Sep 2010 15:29:14 -0000
Received: from 173.13.164.78 (HELO ?10.2.10.52?) (173.13.164.78)
  by relay01.pair.com with SMTP; 27 Sep 2010 15:29:14 -0000
X-pair-Authenticated: 173.13.164.78
User-Agent: Microsoft-Entourage/12.26.0.100708
Thread-Topic: GIT and Cloning Remote Repositories into "Local Remote"
 Repositories
Thread-Index: ActeWLb3IccXActpx0emEPkdGY+0QQ==
In-Reply-To: <20100927151807.GE31809@foucault.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157341>

On 9/27/10 8:18 AM, Casey Dahlin wrote:
> On Sun, Sep 26, 2010 at 06:17:45PM -0700, Grant Erickson wrote:
>> On 9/20/10 6:37 PM, Casey Dahlin wrote:
>>> On Mon, Sep 20, 2010 at 06:22:09PM -0700, Grant Erickson wrote:
>>>> Perhaps 'submodules' are what I am looking for?
>>> 
>>> Yup, exactly :) the manpage git submodule should get you going.
>> 
>> Casey:
>> 
>> Thanks for the prompt reply.
>> 
>> I spent some time over the weekend playing with the various submodule
>> tutorials and I wasn't left feeling convinced that it's the right solution,
>> particularly with the added complexity around commits and pushes (trailing
>> slashes, etc.) that I am sure my users are going to get wrong more often
>> than right.
>> 
> *snip*
>> 
>> And so on for the linux subtree as well. Any further tips or course
>> corrections you can offer, particularly relative to subtree merges?
>> 
> 
> Unfortunately I'm not an expert here. I know what submodules do but I haven't
> used them much (in fact I last looked at them just after they were introduced.
> They were even rougher back then).
> 
> I may have missed it but if you haven't I'd update the list on all of this
> again.

Casey:

Over the course of the weekend, I found a tool, braids, that does EXACTLY
what I need. While it'd be great if it were integrated into GIT, I'll take
it's external nature for now:

    http://github.com/evilchelu/braid

It would appear that in the background it uses the subtree merge strategy
and a repository-local metadata files (.braids) to accomplish what it does.

Best,

Grant
