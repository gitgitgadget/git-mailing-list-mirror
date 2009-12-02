From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: "git merge" merges too much!
Date: Wed, 02 Dec 2009 19:20:21 +0900
Message-ID: <20091202192021.6117@nanako3.lavabit.com>
References: <m1NEaLp-000kn1C@most.weird.com> <20091129051427.GA6104@coredump.intra.peff.net> <m1NFAji-000kn2C@most.weird.com> <20091130192212.GA23181@dpotapov.dyndns.org> <m1NFXpl-000knKC@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Dmitry Potapov <dpotapov@gmail.com>
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 11:20:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFmK9-0001ja-Gz
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 11:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbZLBKU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 05:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005AbZLBKU3
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 05:20:29 -0500
Received: from karen.lavabit.com ([72.249.41.33]:60297 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727AbZLBKU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 05:20:28 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 56F9015754D;
	Wed,  2 Dec 2009 04:20:35 -0600 (CST)
Received: from 2268.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id MP1WKW6TA4D1; Wed, 02 Dec 2009 04:20:35 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=pFE5BCUiM5j1Gc0PaMY0c1WqXRzf4TGVMVzDqY9qJIhd4C4a4evXhXPAP797cVklI0KZ96TwoSwwtuCL+fKGGRfg1z6wVGyd6D36DfJ2jXNNETEkt3RFoimpfqPyc0rcXj1uPZuvFdl8KkR9A1KnrLnOPfkE680vinRPGB1VWTc=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <m1NFXpl-000knKC@most.weird.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134322>

Quoting "Greg A. Woods" <woods@planix.com> writes:

> At Mon, 30 Nov 2009 22:22:12 +0300, Dmitry Potapov <dpotapov@gmail.com> wrote:
> Subject: Re: "git merge" merges too much!
>> 
>> The key difference comparing to what you may got used is that branches
>> are normally based on the oldest branch in what this feature may be
>> included. Thus normally changes are not backported to old branches,
>> because you can merge them directly.
>
> Hmmm... the idea of creating topic branches based on the oldest branch
> where the feature might be used is indeed neither intuitive, nor is it
> mentioned anywhere I've so far read about using topic branches in Git.

You may want to add the result of googling 

  "Fun with" site:gitster.livejournal.com

to the list of Git documents you read. "Fork from the oldest 
branch" is one of the techniques Junio teaches often and many 
of his other techiniques are built upon.

He not just teaches useful techniques but explains a lot about 
the reasoning behind them in his Git book. His blog articles 
have the same explanations on many topics I saw in his book 
but not in other places. It is a useful substitute until his 
book gets translated to English for people who don't read 
Japanese.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
