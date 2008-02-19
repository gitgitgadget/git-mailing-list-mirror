From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH(TIC)] push: annoy all users by deprecating the default semantics
Date: Tue, 19 Feb 2008 13:40:14 -0500
Message-ID: <76718490802191040h6b041ae4q7ae3329be82ec902@mail.gmail.com>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com>
	 <20080219043353.GA23239@sigill.intra.peff.net>
	 <76718490802190509k20225092o66853916f48e08b1@mail.gmail.com>
	 <20080219150826.GA24499@sigill.intra.peff.net>
	 <76718490802190718t5e70abb2x8f96fc7154576594@mail.gmail.com>
	 <20080219152549.GC24499@sigill.intra.peff.net>
	 <alpine.LSU.1.00.0802191610480.30505@racer.site>
	 <20080219163743.GA31668@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jason Garber" <jgarber@ionzoft.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 19 19:41:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRXOx-00037Y-J0
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 19:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbYBSSkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 13:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754392AbYBSSkR
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 13:40:17 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:39139 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbYBSSkP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 13:40:15 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3632081wah.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 10:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/TqqZs9poOS554WJzcESA3Y5tlfWVg1d2k+xyQMThPQ=;
        b=XhrPDUD2vrZOzJtP1JgUH/Fzrsk0Q6duW/phJBwbTd/kzX1G2C0xk/hiLNGd4g3FYtXd1l5gg1QeMGJu79aRJTz0exzKirYK3Tebt8do3JuZErK8nlktWq2eggvCKN3ZLTogL/6mmbpm2g7UUF3EESsEskTYn4TKploVVvq7u34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pCuxLRVbjSR9Gwu5U626AejAsP8ACBzsDoF9y+qMuVc2Y5MAq/EapkKpTM/j4xj4pFrhwCS6p0YlwLTytY+8L7Ut/3qYT6uE8NZl9fRUPsOMSOb3qEsusfTxLC9sELQTBWFWi1fybz5BPhufK1nQF3mVDu/hixgOPdBsHPg7ne0=
Received: by 10.115.74.1 with SMTP id b1mr3785171wal.93.1203446414796;
        Tue, 19 Feb 2008 10:40:14 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Tue, 19 Feb 2008 10:40:14 -0800 (PST)
In-Reply-To: <20080219163743.GA31668@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74443>

On Feb 19, 2008 11:37 AM, Jeff King <peff@peff.net> wrote:
>
> Seriously, though, I think it is not just new users. It is that for some
> (many? most?) people, wanting to push just the HEAD is the _normal_
> workflow. So they must remember to always say "git push origin HEAD",
> and if they ever forget, the side effects are non-trivial to clean up.

[alias]
	mypush = push origin HEAD

(my<cmd> aliases are a lot easier than fighting the powers that be.)

:-)

j.
