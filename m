From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] git-svn: respect Subversion's [auth] section configuration values
Date: Mon, 15 Oct 2007 11:17:50 +0400
Message-ID: <20071015071750.GF984@void.codelabs.ru>
References: <20071006185719.GA3943@void.codelabs.ru> <4708355B.4090403@vilain.net> <20071006185719.GA3943@void.codelabs.ru> <20071007032241.GG14972@hand.yhbt.net> <20071007101437.GB3943@void.codelabs.ru> <20071007214334.GA7442@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 09:18:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhKDK-000789-AZ
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 09:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411AbXJOHR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 03:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754378AbXJOHR7
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 03:17:59 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:60615 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbXJOHR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 03:17:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=ohd8PBEEuksSgyNlExas/ljiggXT8C9CE0kyCPaNcvS9VFqnJeq0VoYi7IWzEXXjIZaS4NyJnmTF8/HdKNnXTZ4jnZoznQgR7lntlt6PU6pLljM0lEq7Ll8Tn6F1B46AuDqvTy6chfaYPhHDJslpSs7Akb8u7jzIj89u1jT3Z2E=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1IhKD5-00055h-ED; Mon, 15 Oct 2007 11:17:55 +0400
Content-Disposition: inline
In-Reply-To: <20071007214334.GA7442@untitled>
X-Spam-Status: No, score=-1.6 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60955>

Eric, good day.

Sun, Oct 07, 2007 at 02:43:34PM -0700, Eric Wong wrote:
> > Great, thanks for the pointer!  Eric, do you want me to produce
> > another patch or you'll correct mine?
> 
> Go ahead and produce another patch.  I haven't had much time to
> work on git lately.

OK, the patch will follow in the separate thread.  I had embedded
"no warnings 'once'" both to my new code and to your code to get
rid of the $kill_stupid_warnings.  I did it selectively to minimize
the impact of the "no warnings" pragma.
-- 
Eygene
