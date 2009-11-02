From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Headless tags don't have a follows or precedes?
Date: Mon, 2 Nov 2009 16:09:19 +0300
Message-ID: <20091102130919.GB27126@dpotapov.dyndns.org>
References: <26093136.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 14:08:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4we7-00079c-JM
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 14:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbZKBNIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 08:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754762AbZKBNIV
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 08:08:21 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:50653 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbZKBNIU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 08:08:20 -0500
Received: by bwz27 with SMTP id 27so6279434bwz.21
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 05:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=e6flkGKs48t5am0AN4nhwd99uEvhf3CKY1YCxZGxI2M=;
        b=D2Z5vIUD0TKenbYhsI4RCGXLPhlkM1T8CKXsD5RNpND66RoBN6qUswJZE5RFyh4nAp
         7rLlw+DKS/kU6s2eQy0D1M8Jw18Nf1OzwYzHEwU00jAmbaizl44P7vlDX/pEeaXGEBm8
         W+dGKbR5odbB4l1xoZZtiUgw7iMFFa0kRmNTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lahjVCTxG/zRL31DAOhvm4w7VwyQ8Jsg56HH6cCO3dIl+ao6JnsRU0LA5csGIHiJes
         cbeuXqREUAugaT6p2/acTxPg3qKwFei8AeGeaMAPmSLXTqVpu+v3fNhZzb8UoM6rVj6Q
         sb21nOGMTcxnKt5Eb7lkhLbThder/I9q4pC7s=
Received: by 10.103.80.4 with SMTP id h4mr2115015mul.112.1257167304889;
        Mon, 02 Nov 2009 05:08:24 -0800 (PST)
Received: from localhost (ppp91-77-227-241.pppoe.mtu-net.ru [91.77.227.241])
        by mx.google.com with ESMTPS id 23sm9342653mum.44.2009.11.02.05.08.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Nov 2009 05:08:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <26093136.post@talk.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131906>

On Wed, Oct 28, 2009 at 04:36:59AM -0700, Tim Mazid wrote:
> 
> I've noticed that if I create a headless tag (one that doesn't have a
> branch, right?),

I have never heard tag being described as headless... A tag is just a
pointer on some commit (annotated tag contains additional information
such as creater, data, message), in any case, it has no direct relation
to any branch.

> when I click on that commit, it doesn't have precedes or
> follows information. Is this by design?

Tags do not store any precedes or follows information, no matter how you
created them, but visualization tools can look at the tree and display
what was before some commit and what was after it. Without seeing your
tree, it is impossible to tell whether gitk (or what you use?) displayed
that correctly or not.


Dmitry
