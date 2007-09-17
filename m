From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 15:40:49 +0200
Message-ID: <8c5c35580709170640w3b55079bt8702e75802a81e@mail.gmail.com>
References: <11900314321506-git-send-email-hjemli@gmail.com>
	 <46EE7584.8010202@op5.se>
	 <8c5c35580709170616i49a8836hb60423c5eebf601d@mail.gmail.com>
	 <Pine.LNX.4.64.0709171422340.28586@racer.site>
	 <20070917133742.GA10923@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Andreas Ericsson" <ae@op5.se>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Chris Shoemaker" <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 15:40:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXGqO-0005lL-2H
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 15:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbXIQNkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 09:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445AbXIQNkw
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 09:40:52 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:28722 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbXIQNkv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 09:40:51 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1304568rvb
        for <git@vger.kernel.org>; Mon, 17 Sep 2007 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wIzc8RDmZvnu/lUWp7S1xDbPEHyPXPQ1dzB/HWJR7N4=;
        b=ThldxQbVNOQlVdqIfUeP3SMLOxw8hv3pCRt8ZLyyQ3hgpLh5WEGcrRmSJR2wLVa7ofkbPl6bA53jZYYEs/7ysgzxkr+E/YEXEIhRFO294RbWKcKwGvWE7OHwgrXu3M613+OSULAw2UytyypxH4Hppb01bILByPakLUutAXzKrcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q/NIDX5cXZqqvc1MOO/iID6QLGfaUC69dFXDKKQNafGxcjEh9V6z0NzhNn981ATYggzf2hGtmXAz43fP112lJZPS45isL41Htw4V081xYwjJtvYVut3eihOTuB7+ATPEz2zjWOHvmkVyASg/KSXEwBh7FJuirpaiQXcCYMDhG94=
Received: by 10.114.156.1 with SMTP id d1mr2661734wae.1190036450445;
        Mon, 17 Sep 2007 06:40:50 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Mon, 17 Sep 2007 06:40:49 -0700 (PDT)
In-Reply-To: <20070917133742.GA10923@pe.Belkin>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58443>

On 9/17/07, Chris Shoemaker <c.shoemaker@cox.net> wrote:
> On Mon, Sep 17, 2007 at 02:23:38PM +0100, Johannes Schindelin wrote:
> > Ah, I think I know what you're trying to get at.  But "git svn fetch &&
> > git rebase git-svn" might be a better approach [...]
>
> BTW, this is spelled "git svn rebase" these days.

Not in this case, since 'git-svn rebase' would fall in the same trap
as 'git-svn dcommit'.

-- 
larsh
