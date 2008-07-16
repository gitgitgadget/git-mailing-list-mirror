From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 02:24:58 +0400
Message-ID: <20080716222458.GH2925@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com> <7v7iblsnfh.fsf@gitster.siamese.dyndns.org> <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com> <7vmykhr6h1.fsf@gitster.siamese.dyndns.org> <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 00:26:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJFRk-0007NC-OQ
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 00:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345AbYGPWZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 18:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757315AbYGPWZF
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 18:25:05 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:19115 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757292AbYGPWZE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 18:25:04 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3613824fkq.5
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 15:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MGtK3ebwiH22LEG2JUaze+KpOYvuohXevHTvEAgGfsY=;
        b=oUzetp8x27M/UMhf8Umplk/yJTfnv9O1zCHQjiTW3HEw4wiB1DoE+82OiHmJRHHFx7
         RpuSU7sM5kHQZQU+ED/CScCHnx+DK2vC36n8PqmcmgGV8qekz79YeOO2zgB1XAlOMUhG
         mHKSsUhb45F9qNHMjJ4oyQIVDkCjHM4xFIsUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fy3usgqPX4BrCuG5wiEP7RRHbTvEqBkg0dzTq25RFh0xDb09K2qshipVRWjPtJt18K
         0dX0LjVmqX4+JnvbJw6/mR9BnUtwHWG2G1hCz9ibuAHfSBixW3ESouDsvo0RZ4dciL0O
         gYiq8Tuckra73uSeX/jEJY1iB4NGt4qx1Y6LE=
Received: by 10.187.221.20 with SMTP id y20mr328868faq.107.1216247102322;
        Wed, 16 Jul 2008 15:25:02 -0700 (PDT)
Received: from localhost ( [85.141.190.235])
        by mx.google.com with ESMTPS id 13sm19456258fks.6.2008.07.16.15.25.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 15:25:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88772>

On Wed, Jul 16, 2008 at 03:29:39PM -0400, Avery Pennarun wrote:
> 
> I find it interesting how git usability discussions tend to go.  It
> usually starts out by someone saying, "Look, git really isn't that
> hard to learn, just do it like this..." and then someone says, "But
> actually, that's still really complicated.  Everyone thinks xxx other
> VCS is easier to learn.  Here's how they do it..." 

Everyone thinks so? Somehow, I don't, and there are people who think
that Git is easily to learn if you teach it properly.

> And then someone
> says, "Yeah, but xxx VCS sucks!" and that somehow makes it okay that
> git is empirically harder to learn than xxx VCS, as anyone can see by
> browsing the web.

Browsing the web is not an empirical study.  And if you say harder, you
should specify to whom. To those who already know xxx VCS, naturally
anything new or different than what you got used to will be difficult
at the beginning. Naturally, it is easier to learn something if there
are more books and articles about it, or just there are more people who
can answer on any your questions. But with everything else being equal,
do you really believe that SVN or CVS is easier to use than Git if we
speak about learning comparable functionality? What is your argument
for that? "svn update"? Well, it is a sure way to make mess in your
working directoy. So, your argument does not sound very convincing.

Dmitry
