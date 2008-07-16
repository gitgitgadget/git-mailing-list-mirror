From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 15:29:39 -0400
Message-ID: <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
	 <7v7iblsnfh.fsf@gitster.siamese.dyndns.org>
	 <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
	 <7vmykhr6h1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 21:31:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCi0-0000fA-1U
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbYGPT3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 15:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbYGPT3l
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:29:41 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:15082 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172AbYGPT3k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 15:29:40 -0400
Received: by wx-out-0506.google.com with SMTP id h29so3496215wxd.4
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 12:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PX1J9TGT9ZsOrpSGEu9OFXiVnWzHEV9XgJmC1hTl5M8=;
        b=Pccc3bToEhuxBl+YIINbpROdxVqadA0sfDSBxVaummyPCXDzDIiRPOO8VyfC3f1zTN
         tuoSrf4lvtBNsBvqrPFwszoCaIyqKXwdQehxQD4L0foAc98DKzUntQ67Wxc5G3kuez8L
         Ae1f52GdzQNotJ2nilnvbbZPG/Dv6e1FjYd3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iFMBaaOPeYjsuAeq4NIVWNTeMRjp7hEvxCI2EHQITPPdEd1GZ32sx4g6f785cUlfUU
         32CPtKL0CfasCYNukHkE4QUFnAx14nRLJdR621Y/ymQYLvTX3jj9BDrLdxHqhBOxihcI
         nfFCacD2uo161sQljP9leV3XDUCLiajvAbFT8=
Received: by 10.100.3.4 with SMTP id 4mr2688112anc.54.1216236579635;
        Wed, 16 Jul 2008 12:29:39 -0700 (PDT)
Received: by 10.100.8.19 with HTTP; Wed, 16 Jul 2008 12:29:39 -0700 (PDT)
In-Reply-To: <7vmykhr6h1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88733>

On 7/16/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Avery Pennarun" <apenwarr@gmail.com> writes:
> > svn avoids these excess merges by default, albeit because it puts your
>  > working copy at risk every time you do "svn update".
>
> By default?  As if it has other mode of operation.
>
>  Of course if you do not allow any commits in between to make the history
>  truly forked, you won't see merge commits.  It is like saying that you
>  like your broken keyboard whose SHIFT key does not work because you think
>  capital letters look ugly and your keyboard protects you from typing them
>  by accident.
>
>  Is that an improvement?
>
>  I won't waste my time further on the apples and rotten oranges comparison,

I find it interesting how git usability discussions tend to go.  It
usually starts out by someone saying, "Look, git really isn't that
hard to learn, just do it like this..." and then someone says, "But
actually, that's still really complicated.  Everyone thinks xxx other
VCS is easier to learn.  Here's how they do it..." And then someone
says, "Yeah, but xxx VCS sucks!" and that somehow makes it okay that
git is empirically harder to learn than xxx VCS, as anyone can see by
browsing the web.

svn is fundamentally broken, but just because they did *some* things
wrong doesn't mean they did *everything* wrong.  You can learn lessons
even from your inferiors.

Have fun,

Avery
