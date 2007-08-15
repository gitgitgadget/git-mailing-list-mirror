From: "Nikodemus Siivola" <nikodemus@random-state.net>
Subject: Re: merge-recursive: do not rudely die on binary merge
Date: Wed, 15 Aug 2007 14:19:16 +0300
Message-ID: <6bcc356f0708150419h51546814x62ceb7c900293d58@mail.gmail.com>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net>
	 <20070814231422.GA10662@pe.Belkin>
	 <7vps1paceh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Chris Shoemaker" <c.shoemaker@cox.net>, git@vger.kernel.org,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 13:19:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILGuJ-0001X5-P2
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 13:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbXHOLTT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 07:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbXHOLTT
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 07:19:19 -0400
Received: from hu-out-0506.google.com ([72.14.214.230]:13445 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbXHOLTS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 07:19:18 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1539678hue
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 04:19:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=MlWa3N4KYC83SlfIkCJb4YBkrVyRA+Z95gaVuVNz8vvZNydZYbPRQ0lkWGEExWWnWYuabQj67YRj7vKE9eGpO77YOnGTXBArjfKNy7fiGCs6dfIYNJ0WP3Y5afetzrYicSpGLdIH68csrcBil9dCs0hTzhKjTzGXt1a1/Up28+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=gwxO4zef1bOP5QyuZKY+Ng3u3i+unsQtmDmR0eCyFJpsr15pyPREa0X7fUypo+yELnFgIizz0hBbnE+1f8qhz7gsCFf46va1i4/pZD5unUHer8dHul57kYWKwz6HtfZAc8fxnFG9mjhrEUpJQhDUvDByUfVPfP7Y0qBGoSJP130=
Received: by 10.78.183.15 with SMTP id g15mr151157huf.1187176756428;
        Wed, 15 Aug 2007 04:19:16 -0700 (PDT)
Received: by 10.78.164.1 with HTTP; Wed, 15 Aug 2007 04:19:16 -0700 (PDT)
In-Reply-To: <7vps1paceh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: 14e18460a3caf29d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55892>

On 8/15/07, Junio C Hamano <gitster@pobox.com> wrote:

> People should learn this command.  Really.
>
>         $ git cat-file -p :$n:path
>
> where $n == 2 is ours, $n == 1 is common ancestor, and $n == 3
> is theirs.

A question related to this: as a user, how can I tell if a command
is something I'm expected to use, or if thinking I need it is a
sign that I'm doing something wrong?

Git has many commands, and telling the business-as-usual apart from
the deviant ones is not always easy. It may be that it's just a question
of knowing what is plumbing and what is a porcelain, but I'm not sure.

Cheers,

 -- Nikodemus
