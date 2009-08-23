From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete line
Date: Sun, 23 Aug 2009 17:18:19 +0900
Message-ID: <20090823171819.6117@nanako3.lavabit.com>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
	<1250999357-10827-3-git-send-email-git@tbfowler.name>
	<7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 10:19:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf8I1-0004no-Eu
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 10:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875AbZHWISl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 04:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755865AbZHWISk
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 04:18:40 -0400
Received: from karen.lavabit.com ([72.249.41.33]:47203 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755563AbZHWISh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 04:18:37 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id E51CE11B8AA;
	Sun, 23 Aug 2009 03:18:38 -0500 (CDT)
Received: from 5468.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id M0GSG78LCXT1; Sun, 23 Aug 2009 03:18:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=25aIYe+VyNuvMC/+mWsLkvEWBwL/KeZp7AafVctuECXzjD+ri34FeRThzc83S0HvE6mUGOQzMpiMMfW2po4auC0UvsupNSdFUErQzmu3JhRzA9HLZ9SHQ81KazpASsTjPQ3SSDHvIlstGWKIEkjUJ3pRZo9Vz0qMrXUgHlH5v+g=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126848>

Quoting Junio C Hamano <gitster@pobox.com>

> How about doing it like this patch instead?  This counterproposal replaces
> your 3 patches starting from [3/6].
>
> -- >8 --
> Subject: xutils: Fix xdl_recmatch() on incomplete lines
>
> Thell Fowler noticed that various "ignore whitespace" options to
> git diff does not work well with whitespace glitches on an incomplete
> line.

I think this should be "options to git diff don't work".

I have two unrelated questions.

(1) Why do you post patches to the list, instead of committing them yourself?
(2) How do I apply a patch like this one to try to my tree? Am I expected to edit the mail message to remove everything before the shears mark before running the git-am command?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
