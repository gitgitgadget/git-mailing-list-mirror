From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Wed, 20 Feb 2008 14:54:42 -0500
Message-ID: <76718490802201154t53ff4195xba055b5d42a3759c@mail.gmail.com>
References: <alpine.LNX.1.00.0802201337060.19024@iabervon.org>
	 <7vzltv4ey8.fsf@gitster.siamese.dyndns.org>
	 <alpine.LNX.1.00.0802201418590.19024@iabervon.org>
	 <7vskzn4dpz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 20:55:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRv2N-0004rO-OC
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 20:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757606AbYBTTyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 14:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757361AbYBTTyp
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 14:54:45 -0500
Received: from el-out-1112.google.com ([209.85.162.180]:4678 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089AbYBTTyo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 14:54:44 -0500
Received: by el-out-1112.google.com with SMTP id v27so1337330ele.23
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 11:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iulI+/aGULDkCAoj8R1nUCGbuxqIg2cEqXvjBYGJ2CE=;
        b=qsVRTQJmTl3hr9wdeLcZGW3BCl6DcNQXUHZVVmixPjianNLHqaDcfo1qYGkePVipL1KK17l3Ng/dhU3my74zh/4DT3avdV7CnQhROSsa1XgpD8NZD/YrTrs0E8R11/U/IPRw6x9CwFgh3zh8VkKfLeo6lhKcXA5rv9CbMVK1B2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E8COpXyFakom3D2v3V+YtcbfD7BvUsZx6I/sSxc9Wxxp7Hp8ee21TANArk0gplEKnCm5ShHPxk8uxDszREYMCIpfjrUDDXPqsKabK2ArWMFIzSq7OSTYuaCz3EiPOvFfazOJ7mJj3rBUByQbi9M5blYyRVg8CGbAi3+QglDDIwA=
Received: by 10.115.33.1 with SMTP id l1mr5492733waj.137.1203537282462;
        Wed, 20 Feb 2008 11:54:42 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Wed, 20 Feb 2008 11:54:42 -0800 (PST)
In-Reply-To: <7vskzn4dpz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74542>

On Feb 20, 2008 2:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Yeah, that "aka" is still disturbing.
>
>         [url A]
>                 aka = B
>
> would read to me: "A is also known as B" but that is clearly not
> what it means here.  You would want this:
>
>         [url A]
>                 aka = B
>                 aka = C
>
> to mean "B is also known as A.  C is also known as A."  IOW, you
> are using it backwards, because their name is more official and
> you are using your own unofficial name to call it.
>
> Sorry, but I cannot think of a better way to resolve this, other
> than by spelling the keyword backwards, but that still makes it
> "aka".

I dunno, I find this eminently clear:

        [url A]
                alias = B
                alias = C

B and C are aliases for A. How else could you read that?

j.
