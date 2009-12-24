From: Fyn Fynn <fynfynn@gmail.com>
Subject: Re: Specifying excludesfile in a portable way?
Date: Wed, 23 Dec 2009 23:14:10 -0800
Message-ID: <1a04eebf0912232314y5dcbdfa7w4adea2eb617e0992@mail.gmail.com>
References: <1a04eebf0912231945l3235bc4dpdd8c541feef9bdd3@mail.gmail.com>
	 <20091224055350.GB419@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 24 08:14:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNhtt-0006Wj-PP
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 08:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbZLXHON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 02:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbZLXHOM
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 02:14:12 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:50203 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbZLXHOM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 02:14:12 -0500
Received: by ywh6 with SMTP id 6so8146560ywh.4
        for <git@vger.kernel.org>; Wed, 23 Dec 2009 23:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=4T5GzFqRMFt/4XXP9tv8RsAPYPAi7YA9rlba3NP8CSE=;
        b=MI0+vMaR02VcOgFd52AuK482UULS8Bx6Rd9a9WtfO3WOcz93ZQ3F2o98BTIudAUBR3
         V2+ztt2AZbAlX0i5TcW/GN0dDGqZWdxrrUrBYCo9Ei8YkSJO7u4RbWwM/3YVP3/WH+Rr
         N9CgfdLeZCjnHI8ljDPc3DGRXMP4AF5jrWh30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hKvVXuIc1EdSGhG2nomy2EjtTB2bNsbkRuY6dVZpi/9DOi5v4z50sQlDpXedPM11yi
         dzva2hVs0F76i61k0lPdrC1zDRZDyx/OoMkQWiNvYe2ip4uaKkdeF8svxmB4qSqmQIp2
         RYStGLFnFumEWacgbx9OWfY/Ll6+5pEeQ4NJM=
Received: by 10.101.10.35 with SMTP id n35mr17115010ani.193.1261638850977; 
	Wed, 23 Dec 2009 23:14:10 -0800 (PST)
In-Reply-To: <20091224055350.GB419@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135642>

On Wed, Dec 23, 2009 at 9:53 PM, Jeff King <peff@peff.net> wrote:
> Not in v1.6.4, but you can use "~/.gitexcludes" in v1.6.6 (which was
> just released today).

That's great to hear!  But since it can take some time to update git
on all machines, is there an alternative for now, e.g. a way to
specify all those exclusions in .gitconfig itself?

> -Peff
>
