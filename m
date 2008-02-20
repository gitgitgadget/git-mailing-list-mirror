From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Thu, 21 Feb 2008 07:02:09 +0900
Message-ID: <200802202203.m1KM37aR012221@mi1.bluebottle.com>
References: <7vskzn4dpz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:03:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRx2Z-00021M-0S
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 23:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756458AbYBTWDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 17:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755400AbYBTWDK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 17:03:10 -0500
Received: from mi1.bluebottle.com ([206.188.25.14]:46128 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbYBTWDI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 17:03:08 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m1KM37aR012221
	for <git@vger.kernel.org>; Wed, 20 Feb 2008 14:03:07 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=L7kJjTXIW9m2dZsRj+Ex2z8cvPXVZ8XhQMlQ3j6CEktsSfY6bQHXqj90d/2qqFqxF
	p9K/E8n97lvrv/4tML5c4O/pkdfkUXK8JkvJriBYEpGwGAKAqIoVXdE4jX/RNMC
Received: from nanako3.mail.bluebottle.com ([212.62.97.23])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m1KM2uow009813
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 20 Feb 2008 14:03:01 -0800
In-Reply-To: <7vskzn4dpz.fsf@gitster.siamese.dyndns.org>
X-Trusted-Delivery: <0279f20c1e5afedaf5819bceef0068da>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74548>

Quoting Junio C Hamano <gitster@pobox.com>:

> Yeah, that "aka" is still disturbing.
>
> 	[url A]
>         	aka = B
>
> would read to me: "A is also known as B" but that is clearly not
> what it means here.  You would want this:
>
> 	[url A]
>         	aka = B 
> 		aka = C
>
> to mean "B is also known as A.  C is also known as A."  IOW, you
> are using it backwards, because their name is more official and
> you are using your own unofficial name to call it.
>
> Sorry, but I cannot think of a better way to resolve this, other
> than by spelling the keyword backwards, but that still makes it
> "aka".

Isn't what you mean to say "A stands for B and C"?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Find out how you can get spam free email.
http://www.bluebottle.com/tag/3
