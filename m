From: "Shun Kei Leung" <kevinlsk@gmail.com>
Subject: Re: git-fast-import crashes
Date: Mon, 15 Oct 2007 16:19:35 +0800
Message-ID: <e66701d40710150119y7c9e0ff6n83c5fbd25d351fc6@mail.gmail.com>
References: <e66701d40710120242p6fc05148hd40d19d295373ac4@mail.gmail.com>
	 <20071013032916.GL27899@spearce.org>
	 <20071013033407.GM27899@spearce.org>
	 <20071013073640.GC7110@artemis.corp>
	 <20071013075027.GD7110@artemis.corp>
	 <e66701d40710142153o70a7b696r928491be437ac6d@mail.gmail.com>
	 <20071015073307.GA1508@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 10:19:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhLAz-0007vq-Qs
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 10:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbXJOITj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 04:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbXJOITj
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 04:19:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:45176 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbXJOITi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 04:19:38 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1190154nfb
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 01:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=o1tlqZU+Nb8kdpMsp3UC3utvBw5Eskz4S40UH4KMMlc=;
        b=TwSPJjMlRVwDQfhDsyRJmoZAkotwk4My5sxeoGtIbANaB9+YEBMXLHCGUgSB9Sc8xRPZtvWweTn8vcbJt1GseAhapO91Ap5db9VVJ36VgvG8lAr1Gv6opfpRDsIINjvfdY8jhQkFXyPIsTSkiBR/FODykShBwnzXCmMOHxuWuVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=By9oBwgh9fpq1EbNja1gFLL+qjDDgiOciNf7O4BXqsdG4fKxdtzcsCpsO8JyEJPeBvei3Dz6yfm9Ck5eeOgwArtyZtAFWE2TuEfDwiatZJznkguOhThaR9U6yXF7X7h8XbAZnSqHhVG6TxaLYAUMqSRJTN4FPRstjpAdx4Kq6jg=
Received: by 10.78.131.8 with SMTP id e8mr3725110hud.1192436375977;
        Mon, 15 Oct 2007 01:19:35 -0700 (PDT)
Received: by 10.78.132.20 with HTTP; Mon, 15 Oct 2007 01:19:35 -0700 (PDT)
In-Reply-To: <20071015073307.GA1508@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60959>

>   I don't get the reason for your "because" but so be it.

Well, my reasoning was that the commit didn't touch the convert.c. But
after re-reading the patch, I think I should apply and test with the
patch again.

...
> Or if the data to reproduce the bug are online
> or shareable, it'd be great to share, so that I can reproduce the issue
> here.

The repository is private, and it is in maintenance mode for the rest
of today. I will get back to you tomorrow with updates.


Thanks & regards,
Kevin Leung
