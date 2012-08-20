From: Pete Wyckoff <pw@padd.com>
Subject: Re: What's cooking in git.git (Aug 2012, #06; Sun, 19)
Date: Mon, 20 Aug 2012 18:48:08 -0400
Message-ID: <20120820224808.GA30139@padd.com>
References: <7v393im4jy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 00:48:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3alf-00054Z-8L
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 00:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667Ab2HTWsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 18:48:13 -0400
Received: from honk.padd.com ([74.3.171.149]:44368 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756618Ab2HTWsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 18:48:12 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 20B9ED27;
	Mon, 20 Aug 2012 15:48:11 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3AFFB31424; Mon, 20 Aug 2012 18:48:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v393im4jy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203902>

gitster@pobox.com wrote on Mon, 20 Aug 2012 00:00 -0700:
> * pw/p4-submit-conflicts (2012-08-16) 12 commits
>  - git p4: add submit --prepare-p4-only option
>  - git p4: add submit --dry-run option
>  - git p4: accept -v for --verbose
>  - git p4: revert deleted files after submit cancel
>  - git p4: rearrange submit template construction
>  - git p4: test clean-up after failed submit, fix added files
>  - git p4: standardize submit cancel due to unchanged template
>  - git p4: move conflict prompt into run, use [c]ontinue and [q]uit
>  - git p4: remove submit failure options [a]pply and [w]rite
>  - git p4: gracefully fail if some commits could not be applied
>  - git p4 test: use p4d -L option to suppress log messages
>  - git p4 test: remove bash-ism of combined export/assignment
> 
> I saw Pete and Luke going back and forth collaborating, so I take
> that this may still be rerolled---if not, please holler.

Yes, expect a reroll; this isn't ready to go as-is.  We'll
continue the back and forth.

> * pw/p4-use-client-spec-branch-detection (2012-08-11) 5 commits
>  - git p4: make branch detection work with --use-client-spec
>  - git p4: do wildcard decoding in stripRepoPath
>  - git p4: set self.branchPrefixes in initialization
>  - git p4 test: add broken --use-client-spec --detect-branches tests
>  - git p4 test: move client_view() function to library

I've got a

    Tested-by: Matthew Korich <matthew@korich.net>

to add in the top-most commit "make branch detection work...".
Should I send a whole reroll, just one patch, or simply a note
like this?  In general, for next time, please.

Thanks,

		-- Pete
