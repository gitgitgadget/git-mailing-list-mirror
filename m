From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/6] Gitweb caching changes v2
Date: Fri, 11 Dec 2009 19:01:34 +0100
Message-ID: <200912111901.35781.jnareb@gmail.com>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> <m3hbrxcxuu.fsf@localhost.localdomain> <4B226D56.7000004@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: "J.H." <warthog9@kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 19:00:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ9mt-0006hQ-P2
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 19:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973AbZLKSAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 13:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754127AbZLKSAH
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 13:00:07 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:4720 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbZLKSAG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 13:00:06 -0500
Received: by fg-out-1718.google.com with SMTP id 19so614452fgg.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 10:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jFcoXCNJe+WG3b6ejqNYdeU8anIlZuXLBTxy/KOgVtM=;
        b=E4KLzqItcGXIsQyJMRfZNVfaXxLctlsNvKJnWCCJVUui4N2YiXy+tM+P3mBodPzvgK
         O+yDqNGyuHn+F53ZwoGEmGJTFKnd56YxtTMOz3muT8iJqrMXtnHNXkKdGzIeaWkviVsu
         fx/FWfLazus9IYizJGbnfQtWaLu/dMC97dhmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=H1Ky2pwDAIwwg7C0bPwmx8Wi+L/gQItCbEpaZwBo3RMnoPo7w0ip1H0PpbRYdUTCqa
         3gC/v2F4GTPsiHes9R3l/Vbc1ewZ2jHcqvqLi2u4YH7FJ1Q+/brOhK3dQc8o2PCux4Zn
         iYVLLjGxBokFyr1Q0yjBwfg0SHEucwJ1TAIUk=
Received: by 10.86.108.18 with SMTP id g18mr2114173fgc.64.1260554411826;
        Fri, 11 Dec 2009 10:00:11 -0800 (PST)
Received: from ?192.168.1.13? (abvh202.neoplus.adsl.tpnet.pl [83.8.205.202])
        by mx.google.com with ESMTPS id e3sm8797679fga.21.2009.12.11.10.00.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Dec 2009 10:00:11 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B226D56.7000004@kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135097>

On Fri, 11 Dec 2009, J.H. (John 'Warthog9' Hawley) wrote:
> Jakub Narebski wrote:
>> "John 'Warthog9' Hawley" <warthog9@kernel.org> writes:

>>> John 'Warthog9' Hawley (6):
>>>   GITWEB - Load Checking
>>>   GITWEB - Missmatching git w/ gitweb
>>>   GITWEB - Add git:// link to summary pages
>>>   GITWEB - Makefile changes
>>>   GITWEB - File based caching layer
>> 
>> This patch didn't made it to git mailing list.  I suspect that you ran
>> afoul vger anti-SPAM filter.
>> 
>> Does this "File based caching layer" have anything common with GSoC
>> 2008 project, available at git://repo.or.cz/git/gitweb-caching.git ?
> 
> Yeah, it does seem that way (like I said eaten by a grue), it 
> *currently* has nothing to do with Lea's GSoC code but it is still my 
> intention, long term, to integrate the two.
> 
> The patch, in all it's glory can be viewed at: 
> http://git.kernel.org/?p=git/warthog9/gitweb.git;a=commitdiff;h=42641b1e3bfae14d5cc2e0150355e89cb87951db
> 
> It is anything but a small patch to gitweb, the patch is 117K and 
> comprises 3539 lines (including git header commit information).  There's 
> not any real good way to break it up as it's a bit of an all or nothing 
> patch.

First, why do you reinvent the wheel instead of using one of existing
caching interfaces like CHI or Cache::Cache (perhaps creating a custom
backend or middle layer which incorporates required features, like being
load-aware)?  This way changing from file-based cache to e.g. mmap based
one or to memcached would be very simple.  And you would avoid pitfals
in doing your own cache management.  perl-Cache-Cache should be available
package in extras repositories.

If module is no available this would simply mean no caching, like in many
(or not so many) other cases with optional features in gitweb.


Second, if you can't use CGI::Cache directly, you can always steal the
idea from it, then the change to gitweb itself would be minimal:

  "Internally, the CGI::Cache module ties the output file descriptor
  (usually STDOUT) to an internal variable to which all output is saved."


P.S. I'll postpone critique of the patch itself for now.  The above issues
are much more important.

-- 
Jakub Narebski
Poland
