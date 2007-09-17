From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 18:14:56 +0200
Message-ID: <8c5c35580709170914n60bf3580r963567fcaac1d2e9@mail.gmail.com>
References: <11900314321506-git-send-email-hjemli@gmail.com>
	 <46EE7584.8010202@op5.se>
	 <8c5c35580709170616i49a8836hb60423c5eebf601d@mail.gmail.com>
	 <Pine.LNX.4.64.0709171422340.28586@racer.site>
	 <8c5c35580709170638mc0c8279pa86d71bd79fd3084@mail.gmail.com>
	 <Pine.LNX.4.64.0709171454031.28586@racer.site>
	 <8c5c35580709170712v2f5df7b1w8fa0377b69f24988@mail.gmail.com>
	 <20070917160755.GA11287@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Andreas Ericsson" <ae@op5.se>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Eric Wong" <normalperson@yhbt.net>
To: "Chris Shoemaker" <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 18:15:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXJFW-0006GT-Li
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 18:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbXIQQO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 12:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbXIQQO6
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 12:14:58 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:46322 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbXIQQO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 12:14:57 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1344221rvb
        for <git@vger.kernel.org>; Mon, 17 Sep 2007 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8g590lzuzp48eQQsCviVg1A/FULs/emUGm2u39ungXQ=;
        b=raVmX0TFftklPzUjUWA9ikk7OYOmEShebMCcs3nuxLpu2Z0QaCb7/PR99qrpFwlWmmopD93vZH3u/KbcyyRdlUYVD0tLPJ+Rrvsfg/68cCDQpYaj8NlAeBlJusSQuoru3076I38FK8EmLAkBImDZcgwVrAjGFYQUq7XKPa77trQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ks9VQ4FNZWtgDAV1mOcrkpn72BkQCBm8b/RlmIXB9yYaYBrZ/lYr7+gWG9Go9Pd3gtaXKRHo9E6z795vC4HAA/mDMFTnA/d6mqOT6r/8DbHEWXdPzqXqgUri69fs+16d+Kj9qPf/94ZML5rmIXJ3w36Do1WPzBmeEZKDhitAG24=
Received: by 10.114.125.2 with SMTP id x2mr2775489wac.1190045696476;
        Mon, 17 Sep 2007 09:14:56 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Mon, 17 Sep 2007 09:14:56 -0700 (PDT)
In-Reply-To: <20070917160755.GA11287@pe.Belkin>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58459>

On 9/17/07, Chris Shoemaker <c.shoemaker@cox.net> wrote:
> On Mon, Sep 17, 2007 at 04:12:56PM +0200, Lars Hjemli wrote:
> > On 9/17/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > But then, I do not use svn branches here, and that might be the problem?
> >
> > Probably. The case I'm trying to solve is:
> >   -git-svn branch A is merged into git-svn branch B
> >   -A is a fast-forward of B
>
> Ah, now I see what you mean.  But, IIUC, if you want to dcommit your
> merge, you should treat it the way svn treats it, with git-merge
> --squash.  Then, dcommit won't be confused about the branch you're
> committing to.

Yeah, --squash is a viable option (I _almost_ used it ;-) but I wanted
to keep the merge-history on the git side (without modifying the
grafts-file).

-- 
larsh
