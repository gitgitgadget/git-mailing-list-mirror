From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: FUNKY tags.
Date: Wed, 17 Aug 2005 12:55:18 +1200
Message-ID: <46a038f90508161755b43735c@mail.gmail.com>
References: <20050816224332.GE26455@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 02:56:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5CDz-0006FI-2D
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 02:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVHQAzU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 20:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVHQAzU
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 20:55:20 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:60885 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750784AbVHQAzT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 20:55:19 -0400
Received: by rproxy.gmail.com with SMTP id i8so49028rne
        for <git@vger.kernel.org>; Tue, 16 Aug 2005 17:55:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iXtchqUsY9SQxcHn5KoQ9V8H0JUwGlk+lBG2GIaatlJ0uNyIgYMwEcj6jiLGmNCLeTch+a1rKsv4UCvHetJx2d9Z9D1qbny+PuVD7/42RFWmptIbsLcZVokqGViblqcgyb0GgRJUKddgwxAq5wDn4lV4fW0a8dI+s1v07GRR/KI=
Received: by 10.38.97.80 with SMTP id u80mr38404rnb;
        Tue, 16 Aug 2005 17:55:19 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Tue, 16 Aug 2005 17:55:18 -0700 (PDT)
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050816224332.GE26455@redhat.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/17/05, Dave Jones <davej@redhat.com> wrote:
> I've no idea what I did when I tagged those trees, but according
> to a google search, cvsps does that when it find patchsets which
> are chronologically (and thus by patchset id) earlier than the tag,
> but are tagwise after.  Spooky.

It's probably tags that were moved around with "cvs tag -F footag".
When using cvs in with a dovetail strategy, people tend to merge
BRANCH->HEAD and use a floating tag to mark how far it's been merged
in.

I am somewhat worried about cvsps getting confused by these floating
tags. Any help in teaching cvsps to ignore tags is welcome ;)


m
