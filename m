From: Christoph Haas <email@christoph-haas.de>
Subject: Re: Strange merge failure (would be overwritten by merge / cannot
   merge)
Date: Sat, 05 Sep 2009 15:07:32 +0200
Message-ID: <h7tnqm$hv6$1@ger.gmane.org>
References: <4AA17874.7090905@debian.org> <20090904234552.GA43797@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 15:11:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjv2g-0001Ke-S6
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 15:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbZIENKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 09:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbZIENKF
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 09:10:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:48020 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbZIENKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 09:10:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mjv1o-000172-Ic
	for git@vger.kernel.org; Sat, 05 Sep 2009 15:10:04 +0200
Received: from fry.workaround.org ([212.12.58.138])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Sep 2009 15:10:04 +0200
Received: from email by fry.workaround.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Sep 2009 15:10:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: fry.workaround.org
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20090904234552.GA43797@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127813>

David Aguilar schrieb:
> On Fri, Sep 04, 2009 at 10:28:36PM +0200, Christoph Haas wrote:
>> Now I imported a new upstream version into the upstream branch. And then
>> tried to merge the 'upstream' branch into the 'master' branch to work on
>> it. And suddenly I get this error:
>>
>>    error: Entry 'cream-abbr-eng.vim' would be overwritten by merge.
>>    Cannot merge.
>>
>> To reproduce my problem:
>>
>>   $> git clone git://git.workaround.org/cream
>>   $> cd cream
>>   $> git merge origin/upstream
>>   error: Entry 'cream-abbr-eng.vim' would be overwritten by merge.
>>   Cannot merge.
>>   fatal: merging of trees 70008c82f82a7985531aa2d039c03fdf944ea267 and
>>   78d3a35e300434d6369424dd873bb587beacfaa4 failed
> 
> Very odd indeed!
> 
> $ git version
> git version 1.6.4.2.264.g79b4f
> 
> I was able to workaround it:
> 
> $ rm *
> $ git add -u
> $ git merge origin/upstream

Thank you. I had to "rm -r addons", too, but the general hint helped me
a lot.

> I've never run into this before.
> I think it has to do with all the renamed files.
> It looks like you're running into ain unfortunate edge case.

Actually I'm not aware of any renames. But I don't claim that I always
know what I'm doing. :)

> Does anyone else on the list have any insights?

I'd be curious, too.

Kindly
 Christoph
