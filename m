From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use whitespace.
Date: Fri, 16 May 2008 15:22:55 +0100
Message-ID: <e2b179460805160722x654d80e0s2e37c4fa04ef0a27@mail.gmail.com>
References: <20080427151610.GB57955@Hermes.local>
	 <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness>
	 <B287EA35-6C5D-4A5A-BEF1-C55A70D913ED@silverinsanity.com>
	 <20080428094119.GA20499@sigill.intra.peff.net>
	 <e2b179460804280256g4ff903bu39c9460086df7157@mail.gmail.com>
	 <20080513091143.GA26248@sigill.intra.peff.net>
	 <e2b179460805131110k3cf582fdn9b8bd31046b90ca7@mail.gmail.com>
	 <e2b179460805150316n77513037y5409042b01170d4e@mail.gmail.com>
	 <20080515112030.GA12781@sigill.intra.peff.net>
	 <7vr6c3h4eb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Brian Gernhardt" <benji@silverinsanity.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 16 16:24:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx0qa-0000SG-JX
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 16:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289AbYEPOW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 10:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756210AbYEPOW5
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 10:22:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:26818 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770AbYEPOWz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 10:22:55 -0400
Received: by rv-out-0506.google.com with SMTP id l9so210169rvb.1
        for <git@vger.kernel.org>; Fri, 16 May 2008 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=dyM4ca1tdBgpuvx41zqgnj5s114QBVoX4M9UOF1UU6Q=;
        b=uSHw2xVt9L8gJtoA44/tlOAwHN4OD8XtKK+x/Nc7OMG8veC7r/CR59SVCdhCyZF5x0UL0oFbepQEf53O5xKsVCL1KxtNPNchuXlxFwfF4tZbRCAAQoVuNkxxfUOcUF6VsCzQBOHYyagIWD5CZy2a771GPlmNyp5Cu9nDiL/R3MA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n8jIU91V9kc7ICHubpeJiz1T5qjOub9bA9KBzDFt4ojzeyRhQ256IJFW2iNiR3PrRl25iR7PoL8hFAu+quW8MM58Rh6o/z2iW2nkWNZj1O2LnIQGRcVnPPgqunNb0Tw+rUApd9KOA54HUKJgzEgZdLKV3h/3I0QspldyBycTI2I=
Received: by 10.141.18.14 with SMTP id v14mr1823758rvi.125.1210947775299;
        Fri, 16 May 2008 07:22:55 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Fri, 16 May 2008 07:22:55 -0700 (PDT)
In-Reply-To: <7vr6c3h4eb.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82294>

2008/5/15 Junio C Hamano <gitster@pobox.com>:
> I'd prefer heterogeneous automated test coverage to be on 'next' and
> 'master'.  If the coverage extends to 'maint' that would be nicer...
>

Do you have any interest in seeing the results of these automated
builds? I'm thinking specifically of the case where you're about to
tag a final release...

Obviously I'll shout on the list if/when we get a breakage.

An example of a tracking fork with the build/pass tags pushed to it is
at http://repo.or.cz/w/git/gitbuild.git - unfortunately as the
branches are significant, the mob approach doesn't really work, so if
anyone else would like to push tags to this repo, please just ask.

Mike
