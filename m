From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [ANNOUNCE] GIT 1.6.4.rc1
Date: Sun, 19 Jul 2009 23:45:00 +0900
Message-ID: <20090719234500.6117@nanako3.lavabit.com>
References: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
	<20090719080558.6117@nanako3.lavabit.com>
	<7vskgt1q3t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Finn Arne Gangstad <finnag@pvv.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 16:46:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSXfC-0002H2-GE
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 16:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567AbZGSOpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 10:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbZGSOpo
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 10:45:44 -0400
Received: from karen.lavabit.com ([72.249.41.33]:51974 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754562AbZGSOpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2009 10:45:43 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 93E7211B91E;
	Sun, 19 Jul 2009 09:45:40 -0500 (CDT)
Received: from 9744.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id K2SVXEB2JVD1; Sun, 19 Jul 2009 09:45:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=l2pQ1Kn2giY1ArD/1AQ+bQ9HXWrNt1lLua60yEIRvd6mKtfRbpZxKzKwc5uCcCkXD94GcsayaD+XPAnTQRk4o09xwOpGsODRW7DAMoW8jiXLcMez4/wwEnx8AkcXg9eHzVARkHXe8+vqb5jrQG25ELQJ7GQXkF5gj+qAXFm0yIY=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vskgt1q3t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123553>

Quoting Junio C Hamano <gitster@pobox.com>:

> I wrote that side note after googling around and found that many users
> outside git community wondering what a strange way to announce a new
> feature it was, and I think they are right.  I stupidly said that we
> should tone the message neutral, because we might want to change the
> default in the future but we are still not committed.  But the end result
> is just a confusing advertisement of an optional feature.
>
> I actually think that the right course of action at this point is this
> patch instead.  We keep the default, we do not annoy the users, and people
> who want to use a non-default configuration can use the feature.

An alternative approach could be to rewrite the message to say that we will change the default to something other than 'matching' as the first step, and then apply Finn Arne's patch as the second step to really force people to choose, because I thought the plan was to switch the default to something other than the matching.
But apparently I misremembered. I googled and found nobody explaining that this message is a preparatory step for such transition. The only reactions I found were the ones that said this is a strange way to advertize a new feature.
I think you are correct, and I think your patch is the right way forward.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
