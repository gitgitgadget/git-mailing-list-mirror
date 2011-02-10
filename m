From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git fetch,git merge and git rebase
Date: Thu, 10 Feb 2011 02:22:18 -0600
Message-ID: <20110210082218.GA5997@elie>
References: <1297315789338-6010561.post@n2.nabble.com>
 <loom.20110210T082201-996@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Akash <bcakashguru@gmail.com>
To: Alexey Shumkin <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Thu Feb 10 09:23:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnRnq-0000ER-Dg
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 09:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418Ab1BJIW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 03:22:27 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37251 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab1BJIW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 03:22:26 -0500
Received: by gxk9 with SMTP id 9so473646gxk.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 00:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dIZd5cuqZNBNby8MWp5nRVzA/VVPpG8ZUB4yK9KMDJM=;
        b=FVIM9FKAP7GbiCEKecmkw3RyniQ2UUXimWhxA/yGR0v+pu1SIIaAnfd5A/R7dWXrI0
         Oab535wV57UNZkIapWvvIPst+k3YuT1vgsJLUJvxKgQowqIQc2mDLWiXWeCt7lXVhhnh
         gu+psKw8tTVRwwRCQJJwGyTZ3ty4G3v6nDMtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ma1439Q+d8bvFjky/8ysZe8/nesKi75GLkoRP6Yi2j5K2yNVC1RABfm7Uv/8VVmGHQ
         z66ODyGzSb+IJyx6ccAcU+UZKeXb1GpqWt/gGHqFrD+NWU93OtAtxjUkgye3jiX4Vutq
         tJEaWZt569yVg5cmwE04/PG6ORMcvabg1UmCk=
Received: by 10.150.146.21 with SMTP id t21mr2897358ybd.280.1297326144593;
        Thu, 10 Feb 2011 00:22:24 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id u3sm1542357yba.4.2011.02.10.00.22.22
        (version=SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 00:22:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20110210T082201-996@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166477>

Alexey Shumkin wrote:
> Akash writes:

>> I am new to git .Can someone explain in simple terms what git fetch,git
>> merge and git rebase do?..I tried googling but was very confused after going
>> thro it.
>> 
>> Also, can someone prescribe a link which explains git in detail right from
>> scratch.
>
> RFTM, with all respect ))
> http://progit.org/book/

More hints:

 - "man git" (or "git help git") has some hints to get started:
   . a tutorial
   . a list of "everyday git" commands to get going
   . a short article on centralized, cvs-style workflow
   . a user's manual

 - when anything is unclear in those documents, I will be very happy
   to learn about it (so cc me in that case :)).  Please be specific
   as possible about what is confusing.

 - people on this mailing list and the #git channel on freenode are
   generally happy to help if you are trying to do something
   specific (or have some other specific question).

 - there's much material on the web in addition to what's mentioned
   above.  For example the old git crash course for svn users at
   http://git.or.cz/course/svn.html taught me a lot about both git and
   svn.  Theoretically, good material from a variety of sources can
   gradually flow into the user's manual and reference manual pages,
   though actual practice does not always match that theory.

Good luck.

Kind regards,
Jonathan
