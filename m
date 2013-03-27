From: Charlie Smurthwaite <charlie@atechmedia.com>
Subject: Re: Segfault with merge-tree on multiple Git versions
Date: Wed, 27 Mar 2013 17:17:00 +0000
Message-ID: <5153298C.8020107@atechmedia.com>
References: <51531059.8000407@atechmedia.com> <7vsj3gn55b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, John Keeping <john@keeping.me.uk>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 18:17:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKtyg-0004Tt-Ps
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597Ab3C0RRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 13:17:06 -0400
Received: from smtp.atechmedia.net ([109.104.109.18]:34739 "EHLO
	smtp.atechmedia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab3C0RRF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 13:17:05 -0400
Received: by smtp.atechmedia.net (Postfix, from userid 2002)
	id 3F5BDC11F7; Wed, 27 Mar 2013 17:15:22 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on smtp.atechmedia.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,HELO_NO_DOMAIN
	autolearn=no version=3.3.1
Received: from exchange.atechmedia.net (exchange.atechmedia.net [109.104.109.9])
	by smtp.atechmedia.net (Postfix) with ESMTP id E9E88C014B;
	Wed, 27 Mar 2013 17:15:21 +0000 (GMT)
Received: from [IPv6:2a01:348:311:2:98d8:7ad8:33d4:9b08]
 (2a01:348:311:2:98d8:7ad8:33d4:9b08) by exchange.atechmedia.net
 (2001:9d8:2005:1::9) with Microsoft SMTP Server (TLS) id 14.1.438.0; Wed, 27
 Mar 2013 17:17:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <7vsj3gn55b.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [2a01:348:311:2:98d8:7ad8:33d4:9b08]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219283>

On 27/03/13 17:06, Junio C Hamano wrote:
> Charlie Smurthwaite <charlie@atechmedia.com> writes:
>
>> I am experiencing a segmentation fault in various versions of Git using
>> different repositories.
>> ...
>> Test Command
>> git merge-tree 26bb22a052fef9f74063afd4fc6fc11fe200b19f
>> 8d6bdf012941d876b2279994e02f1bb0d5c26e7d
>> d5ef97ac407d945f231cd7c8fb1cfe48b3a12083
> Thanks for a report (and thanks to John and Thomas for finding the
> typo).
>
> Nobody I know uses merge-tree; the last real change we did was back
> from July 2010, and the only reason I was looking at it recently was
> because I was planning to write a new merge strategy using it.
>
> Mind if I ask what you are using it for?
Thank you everybody for investigating this and creating a patch. Can I 
assume that this fix will reach somebody who can apply it to master?

With regard our use, we run an SCM hosting service http://codebasehq.com 
and are in the process of deploying a merge-request feature. We use 
git-merge-tree to determine whether a Git merge can be completed 
automatically (without manual conflict resolution), and if so offer the 
user a button to execute an actual merge. If there is a better way to do 
this, I'd be happy to consider it.

Charlie
