From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Add support for per project git URLs
Date: Thu, 17 Aug 2006 11:31:23 +0200
Organization: At home
Message-ID: <ec1cvg$823$1@sea.gmane.org>
References: <200608152003.05693.jnareb@gmail.com> <200608152303.17994.jnareb@gmail.com> <200608161450.35118.jnareb@gmail.com> <7vveos2z3y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 17 11:30:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDeD7-0003NW-O3
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWHQJam (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWHQJam
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:30:42 -0400
Received: from main.gmane.org ([80.91.229.2]:58243 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964777AbWHQJal (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 05:30:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GDeCx-0003Lh-37
	for git@vger.kernel.org; Thu, 17 Aug 2006 11:30:35 +0200
Received: from host-81-190-24-196.torun.mm.pl ([81.190.24.196])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 11:30:35 +0200
Received: from jnareb by host-81-190-24-196.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 11:30:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-196.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25572>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> It is now possible for project to have individual clone/fetch URLs.
>> They are provided in new file 'cloneurl' added below project's
>> $GIT_DIR directory.
>>
>> If there is no cloneurl file, concatenation of git base URLs with
>> project name is used.
>>
>> This is merge of Jakub Narebski and David Rientjes
>>   gitweb: Show project's git URL on summary page
>> with Aneesh Kumar
>>   gitweb: Add support for cloneurl.
>>   gitweb: Support multiple clone urls
>> patches.
>>
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
> 
> I'll take this for now, but we might want to consider moving
> 'description' and 'cloneurl' information to the config file to
> prevent cluttering.
> 
>         gitweb.description
>         gitweb.giturl
> 
> The URL is not for cloning only, but also for fetch/pull, right?

As of now reading text file is faster than invoking git-repo-config...
although reimplementing _reading_ part of git-repo-config in Perl should be
easy...

cloneurl name is leftover from Aneesh Kumar patch. 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
