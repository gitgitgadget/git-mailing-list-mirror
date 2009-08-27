From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Question regarding git fetch
Date: Thu, 27 Aug 2009 16:28:07 +0000
Message-ID: <32541b130908270928i528fa754o16f4cc7a141417c9@mail.gmail.com>
References: <1251387045053-3527289.post@n2.nabble.com> <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com> 
	<loom.20090827T180201-590@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 18:28:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mghpy-0000vP-DK
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 18:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbZH0Q20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 12:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752957AbZH0Q20
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 12:28:26 -0400
Received: from mail-gx0-f205.google.com ([209.85.217.205]:34089 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbZH0Q2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 12:28:25 -0400
Received: by gxk1 with SMTP id 1so1432025gxk.17
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=zvfKRZxj8uYbWZQ2+/r/pC600H4hnppzbIUHXda2ShI=;
        b=l0F/k+0rdsG6dVnOy/O0k77YDM4AQzPaiwOzprlTieJcokKP86hqLSUUyrB8O+W9Qc
         VuVPO/3qfEPKAyhJ09GnvusP1OjJZBSZixNlWezTSRMFCzCHOBqMQ/wllYJMgCdBfPUu
         JzTnS+0gEhoZ4XoTPGEWhq7uSbFx8t0u1yrsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=oFxYw2n7Jb8V/UvCWvkyPJs4ePeo2vhjMvFuvkvzlj9/c1lTiHG/l2KLId0CG91hzE
         7OKrXrDc13HL9gaei84ZWR4PuBeEH7HcjEhZg3Q9GNrAtaRoIYrvoOLy4gk960qd/p2A
         IuOyStIXBYb8BNyUUIJfx4m7v68ebWEM8Uekc=
Received: by 10.150.8.4 with SMTP id 4mr135189ybh.114.1251390507089; Thu, 27 
	Aug 2009 09:28:27 -0700 (PDT)
In-Reply-To: <loom.20090827T180201-590@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127175>

On Thu, Aug 27, 2009 at 4:21 PM, Eric Raible<raible@gmail.com> wrote:
> Avery Pennarun <apenwarr <at> gmail.com> writes:
>
>> Git currently promises that your refs/remotes/* branches will
>> never be updated unless you explicitly request it, even if you're
>> fetching, merging, and pulling other stuff.
>
> So your claim is that "git fetch central" is somehow more
> explicit than "git fetch central master"?

It is, because there's nothing else you could possibly do with it.  It
fetches too many things, so you don't know their names (other than the
ones it puts into refs/remotes/*).

So it's not exactly that it's more explicit - in fact it's rather
confusing and non-explicit that the three-parameter version does
something almost entirely different from the four-parameter one - but
the three-parameter version is at least completely unambiguous.

> Either way, AFAICT it seems purely historical that
> "git fetch central master" doesn't update remotes/central.

This seems true to me.

Have fun,

Avery
