From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 3/4] push: make non-fast-forward help message configurable
Date: Mon, 07 Sep 2009 09:44:57 +0900
Message-ID: <20090907094457.6117@nanako3.lavabit.com>
References: <20090906064454.GA1643@coredump.intra.peff.net>
	<20090906064816.GC28941@coredump.intra.peff.net>
	<7v8wgsk0rw.fsf@alter.siamese.dyndns.org>
	<20090906072322.GA29949@coredump.intra.peff.net>
	<7vzl98fr22.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 02:45:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkSMG-0000nF-HN
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 02:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758428AbZIGApN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 20:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758387AbZIGApM
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 20:45:12 -0400
Received: from karen.lavabit.com ([72.249.41.33]:55524 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758363AbZIGApL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 20:45:11 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 7092611B981;
	Sun,  6 Sep 2009 19:45:12 -0500 (CDT)
Received: from 8357.lavabit.com (212.116.219.112)
	by lavabit.com with ESMTP id 8MCCW1OW8VWH; Sun, 06 Sep 2009 19:45:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=tiv3VExT8mc3UIOJzsHwibxJEU/3w6p5Uw35nSXWToCnVKz7FYPtXHXVvCWRLWLzYx9ht3NlsMdlwXx81Mao0aupN9E8jszvIeNf9W1xnDLdyg74jNucKRUeDJGluhK5zYuZjuEZ37QhZv33PN+6FFh6iR4IYBdrMpkWaT4wCPA=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vzl98fr22.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127878>

Quoting Junio C Hamano <gitster@pobox.com>

> Speaking of which, has anybody felt annoyed by this message?
>
>     $ git reset --hard HEAD^^
>     HEAD is now at 3fb9d58 Do not scramble password read from .cvspass
>
> This is not "maybe you should try this", but I would consider that it
> falls into the same "I see you are trying to be helpful, but I know what I
> am doing, and you are stealing screen real estate from me without helping
> me at all, thank you very much" category.

You may be fixated at the sha1 part of the message when you find this message annoying, but I disagree strongly. I always appreciate the assurance this message gives me that I counted the number of commits correctly, whether I say HEAD^^^^ or HEAD~7.

Showing the subject of the commit you are now at is very useful and I will be equally irritated as you do if it starts showing the subject of the commit I was at.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
