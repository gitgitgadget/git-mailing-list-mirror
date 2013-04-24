From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 12:23:39 -0700
Message-ID: <20130424192339.GH29963@google.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <20130424164003.GB4119@elie.Belkin>
 <7va9ones4p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 21:23:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV5ID-0008K3-GV
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 21:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266Ab3DXTXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 15:23:44 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:48969 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797Ab3DXTXo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 15:23:44 -0400
Received: by mail-pa0-f42.google.com with SMTP id kl13so1386699pab.29
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ETSZyBHv0CHclgd4mGTgqNeaHa5qd1yNPcOh5VqITCY=;
        b=s7kcPnUQHGBVCU138yXpvJ36dKWg7pvzd0xJ8/qncpnWJBGXaImBz3qSguV5C2UCsP
         SqbNEdHCZUXPqtYfnL4ii1C4c4/KS7flH3l9xngL1BxOo31LRjcTQ6npuq0o5afOZeT1
         cO3aVZqWK4UVxqQnzy6ndzcT0ZtQ7zkdR+wkA2b5FS/njFfc+h2jQ+a9d6GStrUmxgIE
         WmaPYmxoIrKpegh5xW7/fOzM6yXYFvwv0NKj7Jz0TY/hSX2B6ztLNRKHZ6OXt9wWOBBB
         qHMh97zzkFYzJf08sDvGGNOa5cJupVvU6UddVz4FdKWdbvnHfCUbsPYikb+5HtTZ4bxo
         1/nA==
X-Received: by 10.66.151.46 with SMTP id un14mr21589610pab.14.1366831423791;
        Wed, 24 Apr 2013 12:23:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id lo7sm4739535pab.19.2013.04.24.12.23.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 12:23:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7va9ones4p.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222304>

Junio C Hamano wrote:

> And it does not match "git log origin...HEAD" which gives both sides
> of the symmetric difference of the history.  To match it, you have
> to say "git log --right-only origin...HEAD" or something.

I tend to use --left-right.  All I meant is that with both diff and
log, ... is a way to get something meaningful when my history and
someone else's history have diverged.

I agree that it would be easier to explain if there were some

	git diff --from-merge-base A B

We could say that "git diff A...B" is a mostly meaningless shorthand
for that.
