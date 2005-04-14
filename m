From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Date handling.
Date: Thu, 14 Apr 2005 14:01:55 -0700
Message-ID: <425EDA43.3040404@zytor.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03457AE6@scsmsx401.amr.corp.intel.com> <1113512078.12012.227.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Luck, Tony" <tony.luck@intel.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 23:01:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMBQe-0005Le-Ni
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 22:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVDNVCa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 17:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVDNVCa
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 17:02:30 -0400
Received: from terminus.zytor.com ([209.128.68.124]:52628 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261595AbVDNVCS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 17:02:18 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3EL20CH012745
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Apr 2005 14:02:00 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113512078.12012.227.camel@baythorne.infradead.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Woodhouse wrote:
> On Thu, 2005-04-14 at 12:42 -0700, Luck, Tony wrote:
> 
>>This is a very good point ... but this still has problems with the
>>"git is a filesystem, not a SCM" mantra.  Timezone comments don't
>>belong in the git inode.
> 
> Yeah, but really I'd want to see other serious users of it before I'd
> accept that the timezone information _really_ needs to be stored
> separately. After all, the committer and author information really
> wouldn't be considered part of the _filesystem_ either.
> 

Both of these are metadata; they may not be directly relevant to the 
filesystem, but are attributes relevant to the client thereof; 
effectively an xattr.  It's not really any different than the fact that 
RFC 2822-style messages frequently contain headers rarely used by either 
MTAs or MUAs; they're metadata provided along the standard format for 
metadata in that system.  In fact, the ability for RFC (2)822 to 
accommodate this type of data has shown to be a major strength of the 
system, as opposed to the uncountably many attempts at binary email formats.

	-hpa
