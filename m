From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC PATCH v4 00/19] Sparse checkout
Date: Thu, 20 Aug 2009 17:31:36 +0200
Message-ID: <vpqy6pey013.fsf@bauges.imag.fr>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
	<m3ocqamrz6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 17:31:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me9cJ-0001Bs-6W
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 17:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbZHTPbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 11:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754535AbZHTPbl
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 11:31:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39011 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbZHTPbk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 11:31:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n7KFU6dr025554
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 20 Aug 2009 17:30:06 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Me9c0-00044n-Ah; Thu, 20 Aug 2009 17:31:36 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Me9c0-0004Vy-9K; Thu, 20 Aug 2009 17:31:36 +0200
In-Reply-To: <m3ocqamrz6.fsf@localhost.localdomain> (Jakub Narebski's message of "Thu\, 20 Aug 2009 08\:21\:03 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 20 Aug 2009 17:30:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7KFU6dr025554
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1251387007.51695@xyw4xOVZ3CCfM+2cQEtMiA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126647>

Jakub Narebski <jnareb@gmail.com> writes:

> Content-Type: text/plain; charset=utf-16be
                                    ^^^^^^^^

I don't know what it should have been, but not UTF-16 ;-)

(readable message below)

> Nguyen Thai
>> Welcome to the fourth round of sparse checkout this year, dubbed "The
>> mummy^W^W^W^W^Wno-checkout returns", although the bit now comes under
>> a new name "skip-worktree" [1]. This series has two parts: sparse
>> worktree and sparse checkout. Details will be given below.
>> 
>> For brave users of this series: I have pushed it to my sparse-checkout
>> branch [2] so you can just clone it and test away. Visible changes:
>> 
>>  - the spec is now .git/info/sparse-checkout
>>  - the spec is positive matching, that is it matches what _is_ in
>>    worktree, not what is out of worktree like the last series
>>  - you need to set core.sparsecheckout no additional command argument
>>    is needed.
> [...]
>
>> [1] There are a few reasons behind this rename:
>>  - there is nothing about "checkout" in the first part, it's about
>>    "sparse worktree"
>>  - the double negation issue with "no-" part of "no-checkout"
>>  - new name makes cache.h diff align beautifully
>
> Well, on one hand side it is more clear what is checked out, 
> and perhaps more common case of checking out only selected files
> is simpler.
>
> On the other hand if it was .git/info/no-checkout or checkout-exclude,
> or worktree-exclude, empty file or lack of such file would mean full
> checkout.  Then core.sparsecheckout (or core.sparsefile) would be
> needed only for performance reasons (no need to examine
> checkout-exclude file) even if we decide to ship example file with
> comments describing its syntax, in templates/info--checkout-exclude
>
> But that is just bikeshedding, don't let it distract you from the real
> issue of this series...
>
> -- 
> Jakub Narebski
>
> In related news: there is really no question that bike sheds should be
> painted red. Really.  
> (Johannes Schindelin, on git mailing list)

-- 
Matthieu
