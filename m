From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: StGIT 0.13 recognizes but not list packed StGIT controlled branches
Date: Mon, 19 Nov 2007 18:43:41 +0100
Message-ID: <200711191843.43247.jnareb@gmail.com>
References: <200711190005.49990.jnareb@gmail.com> <200711191257.09158.jnareb@gmail.com> <b0943d9e0711190515x3f58748bm224366ddb292755d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 18:45:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuAfG-0004Zi-Kf
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 18:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbXKSRnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 12:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbXKSRnt
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 12:43:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:15090 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbXKSRns (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 12:43:48 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1486531nfb
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 09:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=2iDeIFadEn3Qvn1Q1439zHHkYEAg/FaxShpQFZu8fxA=;
        b=oxH/HyIpO1vJ9c4CkLLw9OwwV88+JH6DrlpkVJbqIml2jYae6MKrS+y9uAydWXKnbrsEfysaaRN+pUswpFmUrGsPR9usPJM14ym1Lskvx9RC9aTTAT7ejC8H1pJMJDj1heR2AKH8ZcmNx9X39mOjuS7Ral6VY8qIFBxh2wha0uM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=b2aVlR0d72uSw/uF4WcFvCwyKUbqTvt+7EGVsLGu+pLD4WgaM0zb2BKLRGYIjrMv5TtM9nkXFCSnJQearYSossyiW403ne1adWElNtqmaSHDioTYmVoQsIZwjGsrwQzfzokGPMAdseTSQQlHkKYZUsRwtKZ9EoP6KYJgcKJd+SI=
Received: by 10.86.50.8 with SMTP id x8mr5255000fgx.1195494226106;
        Mon, 19 Nov 2007 09:43:46 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.241.246])
        by mx.google.com with ESMTPS id l19sm7230012fgb.2007.11.19.09.43.44
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Nov 2007 09:43:45 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <b0943d9e0711190515x3f58748bm224366ddb292755d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65475>

On Mon, 19 November 2007, Catalin Marinas wrote:
> On 19/11/2007, Jakub Narebski <jnareb@gmail.com> wrote:
>> Catalin Marinas wrote:
>>>
>>> Have you tried the latest StGIT snapshot? We added support for this
>>> and it will be available in 0.14 (to be released pretty soon).
>>
>> Would it work with Python 2.4.3? Yes, I know I should upgrade my
>> Linux distribution (I use now Aurox 11.1, which is based on Fedora
>> Core 4)...
> 
> Yes, it works with Python 2.4. We deprecated the Python 2.3 support.

I was worried that it would require Python 2.5 (IIRC some stgit RPM
had it in requires)


By the way, does StGIT write something meaningful by default in reflog
messages? Because now my reflog looks like this:

2162:[autoconf@git]# git reflog
407d6dc... HEAD@{0}: 
5a46eb5... HEAD@{1}: 
[...]
ea55960... HEAD@{15}: 
8f5d6b4... HEAD@{16}: 
15bb3f6... HEAD@{17}: checkout: moving from master to autoconf
8aff795... HEAD@{18}: pull origin: Merge made by recursive.

It would be really nice if StGIT wrote something meaningfull when
updating ref, like "stg refresh: <something>", or "stg rebase: <sth>"...

-- 
Jakub Narebski
Poland
