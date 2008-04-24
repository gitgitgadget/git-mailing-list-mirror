From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-gc doesn't clean up leftover objects after git-filter-branch unless you clone first
Date: Thu, 24 Apr 2008 12:59:34 -0400
Message-ID: <32541b130804240959y3b05d4b5u67ac7a7c14bf187e@mail.gmail.com>
References: <32541b130804230841h32c07f3arc94cccfaf0b156a3@mail.gmail.com>
	 <7vve28sdys.fsf@gitster.siamese.dyndns.org>
	 <20080423221316.GE30057@sigill.intra.peff.net>
	 <20080424012836.GA30812@sigill.intra.peff.net>
	 <32541b130804240843k471ecfeteb1008c44a56808b@mail.gmail.com>
	 <20080424161407.GA23737@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 24 19:00:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jp4o4-0001oA-0N
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 19:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbYDXQ7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 12:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbYDXQ7h
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 12:59:37 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:20934 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbYDXQ7g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 12:59:36 -0400
Received: by fk-out-0910.google.com with SMTP id 19so4483758fkr.5
        for <git@vger.kernel.org>; Thu, 24 Apr 2008 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=LfvYQQmi7YEn+/a2JxIBikqD310oQfIh2ZaAGqLjnm8=;
        b=U1dP+kZ0cr2KTirFJMpxXCGJCj6UoxDxpyYzjsbvg/EERETSWA/Y0jEC2Jwtwn0NM6VgUF0Z/os3WWPWaQHOtwzhJklDBtrjigM73CSf6zSCrhBPLxGgOryz/NbUl07Vo2Wr8yGydpabgzdKlGrq4Q6apVxk77zqvZcHly+82YY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TK/JAS+biaB6cy7ahlg/entmCm8FPOp+fdz3cawGFVW14RftZS8q3tL718iDVR4PBMqmRQIklfixp8l+xrSSHiWvMfdLkoAaoTainCpZybpPLPzi/OxGAXWigH6d/mpFPHCXqrZcv5IQvLmj8z7zuqsuaKorWY5DtvT1s2mfEm8=
Received: by 10.82.166.9 with SMTP id o9mr2639869bue.11.1209056374629;
        Thu, 24 Apr 2008 09:59:34 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Thu, 24 Apr 2008 09:59:34 -0700 (PDT)
In-Reply-To: <20080424161407.GA23737@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80310>

On 4/24/08, Jeff King <peff@peff.net> wrote:
> Hmm, maybe it would make sense to put that note in git-prune, with a
>  note in git-gc to look at the prune page.

Perhaps.

>  But if the note were moved to git-prune, it would be natural to mention
>  git-reflog there. What do you think?

I gather there's a movement in recent git versions (sorry, I only
tuned in recently) to encourage people to use git-gc instead of
git-prune in almost all cases.  The reasons I ever looked at git-prune
at all was that git-gc mentioned it in "See Also", and because
"git-prune" sounded more obviously like what I wanted than "git-gc"
when I looked at "man git".

Adding git-gc *and* git-reflog as See Also entries in git-prune would
make sense to me.

Avery
