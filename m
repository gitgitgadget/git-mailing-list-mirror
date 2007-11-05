From: Alejandro Martinez Ruiz <alex@flawedcode.org>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in
	git, help users out.
Date: Mon, 5 Nov 2007 22:54:33 +0100
Message-ID: <20071105215433.GA12827@inspiron>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 22:54:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip9u6-0003mh-VM
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 22:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbXKEVy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 16:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbXKEVy3
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 16:54:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:30320 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXKEVy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 16:54:28 -0500
Received: by ug-out-1314.google.com with SMTP id z38so994299ugc
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 13:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=6C940nMfSdg4BkBcKlqprj6yhGa3CAFUEaqx8cbLxd0=;
        b=W4mH1Oqn40P985O6KTB608CvLsz9WmtAArWXOYz8kQMnitUcw6EhLDSQd6lmK9mZmTiuMb0UGCYUKKQLjUVuQJkg+XMF56NRW98zgYTw+yNo5tJTYtj6FBmAabWf2i3tzr576b4TFncbJsPgEMOFGVb8RId9zAtveakR6l1MLJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=Rj+gi4aJjHA3hiFhYQ4LLSrzm8xWEpMLfMBStALuiRR7YAeAPZdiw4q7QfvrCAzWYmHCKoEMSrfagoShGPsVS17iuQywXwFGTFueE52YhZwnaCs3Bd4+KwX8sof0X+dDo9Vsv8M35Ac3FQePA0QJIcyXCYqSOe81oQsF2GZbdJM=
Received: by 10.67.29.20 with SMTP id g20mr1919655ugj.1194299666470;
        Mon, 05 Nov 2007 13:54:26 -0800 (PST)
Received: from unleashed.kicks-ass.org ( [89.129.132.241])
        by mx.google.com with ESMTPS id i39sm15196369ugd.2007.11.05.13.54.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2007 13:54:25 -0800 (PST)
Received: by unleashed.kicks-ass.org (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	alex@flawedcode.org; Mon,  5 Nov 2007 22:54:36 +0100 (CET)
Mail-Followup-To: Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63567>

On Mon 05 Nov 2007, 11:28, Steven Grimm wrote:
>
> But that suggested command is not going to convince anyone they were wrong 
> about git being hard to learn. I wonder if instead of saying, "I know what 
> you meant, but I'm going to make you type a different command," we should 
> make git revert just do what the user meant.

I think that would just add to confusion.  "revert" applies to full
changesets, not single files, plus it creates a new commit, which is
probably not what the user wants.  Most of them just want to revert some
local changes to some random files, so teach them what they need, if
anything.

> There is already precedent for that kind of mixed-mode UI:
>
> git checkout my-branch
> vs.
> git checkout my/source/file.c

This is a different case: you're basically performing the same
operation, with the second line applying just to a subset of files.

- Alex
