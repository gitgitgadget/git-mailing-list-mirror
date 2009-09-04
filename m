From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Fri, 4 Sep 2009 09:02:16 +0200
Message-ID: <20090904070216.GA3996@darc.dnsalias.org>
References: <20090902080305.GA11549@neumann> <20090902081917.GA5447@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 09:06:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjSre-00087R-8D
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 09:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933126AbZIDHCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 03:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933106AbZIDHCg
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 03:02:36 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57819 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933126AbZIDHCd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 03:02:33 -0400
Received: by bwz19 with SMTP id 19so50777bwz.37
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 00:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=sNfwNOT2N6UP8beD+ev74LkwRuREYqZuSyGlwJypY+U=;
        b=orRUzXtOmOLlSeRHbwCsFl+pQQJHnSUzbNX//ZG5ruVCFX2lj1H2b0j9UtxgJFaX0H
         ltqubl7+XH3ChiFxPy5sdBZamxTmltbc8KK+5Q5ToGDPl1mDPwv8RCRBytvKSLZp075F
         WlYQ9LG6YWrJWsPrO0l5QbEsm5xPVW3KQjFgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=aq8+bqi9VieTFO7MzpOdKbKu5x14TxaY5raQr6sgpFaSjkRNEhVRSyKxHUqgtM4+Cd
         pUZVrCcXnsx7qhOJ0p3kRcAS1cVZPkLfpsx45OjWjnuvqkuFZFfVY5X+6+37XjpZ10xB
         UVQzPAoNammyF+hmCyZwk+RkRn2N6f9IoTfh8=
Received: by 10.204.154.198 with SMTP id p6mr8785949bkw.131.1252047753482;
        Fri, 04 Sep 2009 00:02:33 -0700 (PDT)
Received: from darc.lan (p549A4096.dip.t-dialin.net [84.154.64.150])
        by mx.google.com with ESMTPS id 17sm957777bwz.105.2009.09.04.00.02.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Sep 2009 00:02:32 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MjSoK-0001Qt-CV; Fri, 04 Sep 2009 09:02:16 +0200
Content-Disposition: inline
In-Reply-To: <20090902081917.GA5447@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127687>

On Wed, Sep 02, 2009 at 04:19:17AM -0400, Jeff King wrote:

> [1] I would prefer "git add -u ." to add only the current directory, and
> "git add -u" to touch everything.

FWIW, I feel the same way. And there is no easy way to do that now. (cd `git
rev-parse --show-cdup`; git add -u) ?

> But then, I am one of the people who
> turn off status.relativepaths, so I think I may be in the minority in
> always wanting to think of the project as a whole.

That mindset is one of git's greatest strengths IMO.

Clemens
