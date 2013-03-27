From: Charlie Smurthwaite <charlie@atechmedia.com>
Subject: Re: Segfault with merge-tree on multiple Git versions
Date: Wed, 27 Mar 2013 18:46:37 +0000
Message-ID: <51533E8D.5050206@atechmedia.com>
References: <51531059.8000407@atechmedia.com> <7vsj3gn55b.fsf@alter.siamese.dyndns.org> <515331F2.3060703@atechmedia.com> <874nfw4t0r.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	John Keeping <john@keeping.me.uk>,
	Thomas Rast <trast@inf.ethz.ch>
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Wed Mar 27 19:47:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKvNR-0000zq-He
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 19:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108Ab3C0Sqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 14:46:45 -0400
Received: from smtp.atechmedia.net ([109.104.109.18]:35390 "EHLO
	smtp.atechmedia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328Ab3C0Sqo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 14:46:44 -0400
Received: by smtp.atechmedia.net (Postfix, from userid 2002)
	id 8CE53C11EA; Wed, 27 Mar 2013 18:45:01 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on smtp.atechmedia.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,HELO_NO_DOMAIN
	autolearn=no version=3.3.1
Received: from exchange.atechmedia.net (exchange.atechmedia.net [109.104.109.9])
	by smtp.atechmedia.net (Postfix) with ESMTP id 74471C01BC;
	Wed, 27 Mar 2013 18:45:01 +0000 (GMT)
Received: from [IPv6:2001:9d8:2005:12::3] (2001:9d8:2005:12::3) by
 exchange.atechmedia.net (2001:9d8:2005:1::9) with Microsoft SMTP Server (TLS)
 id 14.1.438.0; Wed, 27 Mar 2013 18:46:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <874nfw4t0r.fsf@59A2.org>
X-Originating-IP: [2001:9d8:2005:12::3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219300>

On 27/03/13 18:06, Jed Brown wrote:
> Charlie Smurthwaite <charlie@atechmedia.com> writes:
>
>> I am also using this to obtain a diff that would be applied if a merge
>> were to be run. Is there a better way to obtain this information that is
>> more commonly used?
> You can do an actual merge using detached HEAD:
>
>    $ git checkout --detach upstream-branch
>    $ git merge topic-branch
>
> This has the benefit that if there are conflicts, you can resolve them
> here and commit the result so that rerere can auto-resolve them later.
>
> Are you looking for something that can be run in a bare repo?

Yes, I would need to be able to do this on a bare repo for my use case. 
Thanks!
