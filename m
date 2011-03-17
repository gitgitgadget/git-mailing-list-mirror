From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Sharing a massive distributed merge
Date: Thu, 17 Mar 2011 03:04:14 -0400
Message-ID: <AANLkTikdXCo_3hGZSaW3+9x6gQ2_B3A=scWN-f3gMSY4@mail.gmail.com>
References: <4D8119BE.2090208@workspacewhiz.com> <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com>
 <20110317063816.GD11931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 08:19:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q07UE-0003Z5-HD
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 08:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689Ab1CQHTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 03:19:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39688 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab1CQHTE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 03:19:04 -0400
Received: by iwn34 with SMTP id 34so2514732iwn.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 00:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=mo7JydgTls9QcL4fPjrBQk4F1itmLx6O/fyFmDETjJM=;
        b=lkk3j52hBeVL6wZOfhmkt2fwwZZoDHZI/HgZWHCxUSgqsJpw0nTwWVYVQkIb0GPwyv
         lIsOIEgkVynDeMmTrGzCoWSB0FLS6ZRVQM/s7k2+h6rk0g1bCkLPRNe7twN9qzpe2VwE
         mUq/UH1ix/4ZTsMt8TSsZZopLRZgDeFSduTdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HusHkERpMYtB+y2VkPlRuuFwU0xeR3voZUJrfQik6pRagpHC1RJkekmwydNDImpCEj
         QSs6tJfX87MZyMP06tv8zisVekAbb1ASgKuKULCmVG7IQ83SWO1g7eKh2UWdV+GHfs9Q
         2JlxVxXGzWxeDlddgjhcbyrbdXVYOaIaCsfaY=
Received: by 10.42.137.198 with SMTP id z6mr1357333ict.261.1300345484191; Thu,
 17 Mar 2011 00:04:44 -0700 (PDT)
Received: by 10.231.34.7 with HTTP; Thu, 17 Mar 2011 00:04:14 -0700 (PDT)
In-Reply-To: <20110317063816.GD11931@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169217>

On Thu, Mar 17, 2011 at 2:38 AM, Jeff King <peff@peff.net> wrote:
> [2] It really seems like the right command to get the list of resolved
> files would be "git diff-index" with either a diff-filter, or grepping
> the output of --name-status. But I couldn't convince it to show me
> unmerged files; the unmerged entries always just appeared as
> modifications (actually, deletions in --raw), which made them
> indistinguishable from modified resolutions.

I use this alias for getting unmerged files:

$ git help unmerged
`git unmerged' is aliased to `!git ls-files --unmerged | cut -f2 | uniq'

j.
