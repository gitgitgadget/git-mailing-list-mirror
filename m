From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] pager: drop "wait for output to run less" hack
Date: Wed, 6 Jun 2012 01:09:44 +0200
Message-ID: <CABPQNSbk4h8bbhk92XAHVt5zVMCs3JLdjMf8P0wGD3wmyVEE1Q@mail.gmail.com>
References: <20120605085604.GA27298@sigill.intra.peff.net> <CABPQNSbhgan+i_Q142R8VvRdJ5T+GyYHqgEJ6KS-BBJguRu-OQ@mail.gmail.com>
 <20120605160157.GA20582@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 06 01:10:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc2tR-00048X-GB
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 01:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635Ab2FEXKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 19:10:25 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60930 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461Ab2FEXKY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 19:10:24 -0400
Received: by pbbrp8 with SMTP id rp8so8087705pbb.19
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 16:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=7V5UP6/R3gwM7xyNoqViUOZC2ApH8Ow5mMcKxZ3rme4=;
        b=DwnoP87mDf7KCLj1lFwRExgCn3fpQ6jrNGlgTEv+ISUZjTkn6AX9g+OfKS0xTxQErv
         42pFCxiZmOyjmsKIBQ8IxB4XP/bAa/+efyYH2cjbj3WduTBfvBbJ+OaLjQGgc31FSsp5
         oBv0+gaBQIhqr2ZPApLin2AsFhRcgL99OSYXPKSETexLgeIrjedvpmxzevtwr59IPbQ9
         2sJv3bTWl9LYTQmkbpsRV7sNQ5pA2VHpw3WLP3YQgg9HhYcsy7My5fjWx6HiK9NhYA98
         y8WrYk5YW3Uoup3da4L1DJZTrsPpukzJW+PmMGUv+8RIY6/y7QUp4EdwY3G04rG+S8QM
         259A==
Received: by 10.68.197.71 with SMTP id is7mr32020695pbc.49.1338937824213; Tue,
 05 Jun 2012 16:10:24 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 5 Jun 2012 16:09:44 -0700 (PDT)
In-Reply-To: <20120605160157.GA20582@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199297>

On Tue, Jun 5, 2012 at 6:01 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 05, 2012 at 05:52:24PM +0200, Erik Faye-Lund wrote:
>
>> On Tue, Jun 5, 2012 at 10:56 AM, Jeff King <peff@peff.net> wrote:
>> > I checked, and even RHEL5 is on less 436. So besides people on antique
>> > "I installed less from source more than 5 years ago" systems, my only
>> > concern would be that some other pager depends on this hack in a weird
>> > way. But I have never heard of such a thing, so...
>>
>> On my RHEL5 box at work:
>> $ less --version
>> less 394
>> Copyright (C) 1984-2005 Mark Nudelman
>
> Then I think you are not following the bug-fix updates, as they've
> issued several updates based on 436:
>

I don't know what exactly the setup is, other than that it's set up to
match the RHEL5 setup of a major customer with a very conservative
upgrade policy.
