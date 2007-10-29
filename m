From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH 6/7] include $PATH in generating list of commands for "help -a"
Date: Mon, 29 Oct 2007 22:45:31 +1100
Message-ID: <ee77f5c20710290445y553fc9fo90c6e4df9b2aa1a7@mail.gmail.com>
References: <1193474215-6728-6-git-send-email-srp@srparish.net>
	 <1193582654-12100-1-git-send-email-srp@srparish.net>
	 <Pine.LNX.4.64.0710281642220.4362@racer.site>
	 <20071029024431.GA12459@srparish.net>
	 <Pine.LNX.4.64.0710291129250.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Scott Parish" <sRp@srparish.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 29 12:46:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImT48-0000cW-Ly
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 12:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbXJ2Lpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 07:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755485AbXJ2Lpd
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 07:45:33 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:47831 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441AbXJ2Lpc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 07:45:32 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1540343rvb
        for <git@vger.kernel.org>; Mon, 29 Oct 2007 04:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HSZor5USM/d/AYKDJCUhgGeaBehHkh3GASTIJHMkV+w=;
        b=EX6tyus+/Sc2SPPgciui3dNp/19q2APIdf397jNyQNytPCEVx03ahvuHXvKiGZjnp5R1cgP3/vUV6Iucdeyk6GWFA0uqQ783+CWKAqoYvPSGbVdM7JP9BEZlwZ8aF9LH75amkoHmFsRFX80cdBnDQrgNfdp+cfHVQAg3MbcF2hI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q4hhoZrGZnTAuamDD/dP8BW0Jbyw7vvpYCV2SIYiuRXO5qJ4F2IR+QIlTVOAz+sfGwyMOHi5cM1WBBMzhwSZGlb0nrTgFzrTXV/nKNHeySg8UV3oNVOJNYLWWPHhQQ5sc8ZANcNFniB4IWVrjhVno8h/sCpfBflnp7zg6PQTW9w=
Received: by 10.141.180.5 with SMTP id h5mr2681894rvp.1193658331593;
        Mon, 29 Oct 2007 04:45:31 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Mon, 29 Oct 2007 04:45:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710291129250.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62614>

On 10/29/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 28 Oct 2007, Scott Parish wrote:
>
> > I was thinking set operations when i named this (hense "a" and "b"),
> > but i'll try this out.
>
> Yes, I guessed that.  But in that case, "subtract" is actively wrong,
> since you cannot guarantee (and indeed do not want to assume) that one is
> the subset of the other.

The nearest set theory operation would be "difference" (or
"complement"); that does not require that the subtrahend is a subset
of the minuend.


Dave.
