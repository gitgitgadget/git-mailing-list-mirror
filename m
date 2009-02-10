From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Wed, 11 Feb 2009 08:52:56 +0900
Message-ID: <20090211085256.6117@nanako3.lavabit.com>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com>
 <20090210110330.GB12089@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, Tuncer Ayaz <tuncer.ayaz@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:55:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX2Rl-0006Pt-Qk
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757037AbZBJXxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756935AbZBJXxi
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:53:38 -0500
Received: from karen.lavabit.com ([72.249.41.33]:49705 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754262AbZBJXxh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:53:37 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 3FE6C11B9CC;
	Tue, 10 Feb 2009 17:53:36 -0600 (CST)
Received: from 9617.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id ZF0F37SSSNXM; Tue, 10 Feb 2009 17:53:36 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=rVQLWFzzLApwTVG9JHYDIB9ZJpRruRsDyG37Rrfw7gFiSNCozXR+/0SFYkR9i5MlkR4eSiH59fkMRv5jSWD+wW3Y0iaWeBE1RgvdlKV6C8Qu1pJM97dUOhI8wZDs3VVsRnKZNQBEGrXEvDqnn9bjQsFeVvlk86jIZ9O5MW2BDnU=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vwsbynv0o.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109352>

Quoting Junio C Hamano <gitster@pobox.com>:

> Jeff King <peff@peff.net> writes:
>
>> Some comments:
>>
>>   1. Is the staggered indentation intentional? It looks awful, and the
>>      only use I can think of is to separate unstaged from staged
>>      changes. But surely there must be a more obvious way of doing so.
>
> Probably not.
>
>>   2. Why do staged changes get a letter marking what happened, but
>>      unstaged changes do not?
>
> Bug?   FWIW, the original patch from October shows:
>
>     M changed
> M   M changed-again
> M     changed-staged
>     D deleted
> D     deleted-staged
>
> (where changed-again has both staged changes and further changes in the
> work tree).
>
> The gap between these two are to show the rename similarity index, which
> we could do without.

I have a question. Why do you have the gap for the rename similarity between the two but not between the second status and the filename?
