From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 09/14] remote-testgit: report success after an import
Date: Fri, 2 Nov 2012 17:19:33 +0100
Message-ID: <CAMP44s2T7iOdn6mWXqcUw97d8_-=pR=7ZQ5t_ygPGOphXW5cQw@mail.gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
	<1351821738-17526-10-git-send-email-felipe.contreras@gmail.com>
	<5093D193.3030108@gmail.com>
	<CAMP44s2ZPbda7yJ9UtOhWMqaKp4TaAgoyeUWUSrt0vco7RK+Tw@mail.gmail.com>
	<5093EFF4.5080308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 17:19:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUJyG-0003t2-0x
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 17:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758547Ab2KBQTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 12:19:35 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45891 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757837Ab2KBQTe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 12:19:34 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3762693obb.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VQcUe8jwBl2h7OapKH4JlPrxRAAuXH5Wttj6iOOHR00=;
        b=aTAqkrQtrVlAbstZNXGWboaNUvQIAcrC2VqXDmJfB6cbNOJ2ozRKh/bv36z6BFzmcl
         nP1IFHxumYMk+MOHMFcmBr+BcBr48C5Tbcp+iX8aZ4DS3zFvyHqooCxscurMfdgF/zfP
         DE/SN54oJ9Fq3z/a+XLACweLVCrUNFzkuOKJWFcBmk6bJacFgKKnmV+JIsMZVXdAitT5
         AJVPZs4bARie2cxw9GMT1E4RH+0V3OdAmsfuRHAjlM9rpFhhkpU7HyoRgLLCaZ4Bj8BZ
         eM2YIMKL2Kh3JdIE9e/1OXdtIQ0v+ozZzgIUab7Lw3bdw32jPz/ZSxZJUORHji+lVlNZ
         7vEw==
Received: by 10.60.12.233 with SMTP id b9mr1786023oec.95.1351873173913; Fri,
 02 Nov 2012 09:19:33 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Fri, 2 Nov 2012 09:19:33 -0700 (PDT)
In-Reply-To: <5093EFF4.5080308@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208960>

On Fri, Nov 2, 2012 at 5:08 PM, Stefano Lattarini
<stefano.lattarini@gmail.com> wrote:
> On 11/02/2012 04:46 PM, Felipe Contreras wrote:
>>
>> In the end I liked this approach much better.
>>
>> If you have a solution for this that works in POSIX shell, I'll be
>> glad to consider it, but for the moment, I think a simple, easy to
>> understand and maintain code is more important, and if it needs bash,
>> so be it.
>>
> If this is a deliberate decision, it's ok with me.  I'm just a "casual"
> reviewer here, not an active contributor, so I'll gladly accept
> preferences and decisions of the "active crew", once it's clear that
> they are deliberate and not the result of mistakes or confusion.
>
> In any case, I agree that having a clean, understandable code as a
> starting point is better than having a more "portable" but trickier
> one right away.  If it will need converting to POSIX, that can be
> done as a follow up (and as we've both noticed, this would be the
> only point where such a conversion might be problematic -- the other
> changes would be trivial, almost automatic).

As things are the options are:

1) Remove this code and move to POSIX sh. People looking for reference
might scratch their heads as to why 'git push' is not showing the
update.
2) Keep this code and remain in bash.

Until we have a:

3) Replace this code with a clean POSIX sh alternative

I would rather vote for 2)

Cheers.

-- 
Felipe Contreras
