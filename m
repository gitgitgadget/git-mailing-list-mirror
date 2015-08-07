From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: wishlist: make it possible to amend commit messages after push to remote
Date: Fri, 7 Aug 2015 22:02:12 +0100
Organization: OPDS
Message-ID: <43BA4A09C14A43DEB23F4F14C2279A30@PhilipOakley>
References: <55C3FA66.90805@iki.fi> <20150807160924.GA4185@ikke.info> <55C4E77C.8070402@iki.fi>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: <jhi@iki.fi>, "Kevin Daudt" <me@ikke.info>
X-From: git-owner@vger.kernel.org Fri Aug 07 23:01:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNolw-0005sH-6C
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 23:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946302AbbHGVBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 17:01:44 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:19846 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946240AbbHGVBn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Aug 2015 17:01:43 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DoEAC4G8VVPMKxBlxbGQEBgwCBPYMkgy5tvWQEBAKBRU0BAQEBAQEHAQEBAUE/QQSDWQYBAQQIAQEZFR4BASELAgMFAgEDFQUCBSECAhQBBBoGBwMUBgESCAIBAgMBCogXuAiGWI9kgSKKLYQmEQFRgnAvgRQFlQgBgQ+NE5RJg2WBcAyCKD0xgQ6BPgEBAQ
X-IPAS-Result: A2DoEAC4G8VVPMKxBlxbGQEBgwCBPYMkgy5tvWQEBAKBRU0BAQEBAQEHAQEBAUE/QQSDWQYBAQQIAQEZFR4BASELAgMFAgEDFQUCBSECAhQBBBoGBwMUBgESCAIBAgMBCogXuAiGWI9kgSKKLYQmEQFRgnAvgRQFlQgBgQ+NE5RJg2WBcAyCKD0xgQ6BPgEBAQ
X-IronPort-AV: E=Sophos;i="5.15,631,1432594800"; 
   d="scan'208";a="615579053"
Received: from host-92-6-177-194.as43234.net (HELO PhilipOakley) ([92.6.177.194])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 07 Aug 2015 22:01:42 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275489>

From: "Jarkko Hietaniemi" <jhi@iki.fi>
> Thanks (also to Jacob Keller), the git-notes might work in some cases.
> But it's obviously a pasted-on solution, requiring a different usage,
> e.g. "git log --notes", and whatever other UIs do with it.
>
>> One more thing, if you know that no one has fetched the branch you 
>> just
>> pushed yet, you can amend the commit and force-push it without any
>> problems (I'd sugget using --force-with-lease).
>
> In my particular case, not going to work, multiple CI engines jump
> hungry at every commit.

Sound like you need an intermediate repo (similar in style to a personal 
github repo) between your personal machine and the CIs so that you get 
the chance to do those rebases/amendments, before you finally push to 
the CI.

It's almost the same human psychology issue as realizing what to do 
_after_ sending an email asking for help (and wanting to recall the 
email...).

To me, part of the sucess of a DVCS is having that extra layer where 
control has been distributed to you, rather than control still being 
with 'them'.

</bikeshedding>
--
Philip 
