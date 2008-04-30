From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH 3/3] commit: Show the committer ident when is different from the parent
Date: Wed, 30 Apr 2008 21:23:43 +0200
Message-ID: <8aa486160804301223w574fe425n5d0678020ff1e7b4@mail.gmail.com>
References: <1209545236-4266-1-git-send-email-sbejar@gmail.com>
	 <1209545236-4266-4-git-send-email-sbejar@gmail.com>
	 <20080430145017.GA922@sigill.intra.peff.net>
	 <20080430163701.GA6544@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Alex Riesen" <raa.lkml@gmail.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 30 21:24:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrHuv-0007oz-Ou
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 21:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbYD3TXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 15:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbYD3TXr
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 15:23:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:12437 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbYD3TXq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 15:23:46 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1521669ugc.16
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7/gmllPuXaLfe2rNq1m6YEHELmDyXg4jgiOb1FRQXUU=;
        b=rphXEJvlIXktpbihqv6x1biec0hW2LEg4r72g6alwitFiJZPH6HEMYDrYzl1AnlIpzB7wq1LKSL7JcW75Nxzs4PVrk2d1I60/ZOeuUvG/rgdxDUdPQBeQVT8jYststIaI9hC+LYpC/NLu805q75b+Ws3TkjgQhEAGRv1mqBa3kM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YhwrygUeBXezpvBHFlFy/JhJWRCRp/AcPRleko4QMqUZy/62hvUd6uGNjEyWMS0YbS3OYA3aAKETfISRG1sjwLApPI/kOnjz6y/pgMuBTzkhICxvSX79SvQz432Habkuvs6pkDag9HVlCmekF0JHZijN3b6nu57mPTDEkX5ivz4=
Received: by 10.150.86.10 with SMTP id j10mr1514382ybb.212.1209583423078;
        Wed, 30 Apr 2008 12:23:43 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Wed, 30 Apr 2008 12:23:43 -0700 (PDT)
In-Reply-To: <20080430163701.GA6544@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80864>

On Wed, Apr 30, 2008 at 6:37 PM, Jeff King <peff@peff.net> wrote:
>  Actually, thinking about this a bit more (and using it), I'm not sure
>  that the best rule for showing the committer is "differs from the
>  previous committer." For example, if I am building on Junio's git.git,
>  the committer name is shown, even though I have made many commits in
>  this repo already.
>
>  So if the goal is to show the committer name only when it "matters", I
>  don't think you have succeeded.
>
>  -Peff
>

On Wed, Apr 30, 2008 at 7:52 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
>  I like the idea in general, but the implementation could be refined.
>  Maybe consider looking at user.name (whether the repo has an ident
>  set)? This is usually done conciously, and the user wont need this
>  reminder.

Maybe only show the committer ident when both happens:

1) the committer ident is different from the parent
2) the committer ident is set automatically

Santi

P.D.: Jeff, thanks for the amending patch.
