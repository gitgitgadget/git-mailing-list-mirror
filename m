From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] whatchanged: document its historical nature
Date: Mon, 12 Aug 2013 08:50:00 +0100
Message-ID: <20130812074959.GJ2337@serenity.lan>
References: <52027B17.7040602@googlemail.com>
 <7vtxj1crv6.fsf@alter.siamese.dyndns.org>
 <CALkWK0kTfQYZG8R1EMuV37pdJ-aj9btXmfJ1Fb4QoMeZ1QucAw@mail.gmail.com>
 <vpqfvukdy39.fsf@anie.imag.fr>
 <CALkWK0kD=adWKVf+zb+Pnjz-HBkhks8ZvmQ3eYSpdXvahr=e4g@mail.gmail.com>
 <vpqvc3gcijh.fsf@anie.imag.fr>
 <7vwqnw9jv6.fsf@alter.siamese.dyndns.org>
 <7v38qi63bn.fsf_-_@alter.siamese.dyndns.org>
 <20130809201447.GH2337@serenity.lan>
 <7vtxiy4m6o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 09:50:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8mtR-0003DD-MG
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 09:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275Ab3HLHuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 03:50:17 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:37303 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab3HLHuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 03:50:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id C4DB4606505;
	Mon, 12 Aug 2013 08:50:14 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n6K8HqGcuK+6; Mon, 12 Aug 2013 08:50:09 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 4D0F119800A;
	Mon, 12 Aug 2013 08:50:01 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vtxiy4m6o.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232170>

On Fri, Aug 09, 2013 at 01:57:19PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> >> +New users are encouraged to use linkgit:git-log[1] instead.  The
> >> +`whatchanged` command is essentially the same as linkgit:git-log[1]
> >> +run with different defaults that shows a --raw diff outputat the
> >
> > s/outputat/output at/
> 
> Thanks.
> 
> > Although I wonder if it would be better to say
> >
> >     New users are encouraged to use linkgit:git-log[1] instead.  The
> >     `whatchanged` command is essentially the same as linkgit:git-log[1]
> >     with the `--raw` option specified.
> 
> But that is different from the truth, no?  "git whatchanged -p" will
> not behave as if "git whatchanged -p" with the "--raw" specified.
> The 'raw' kicks in only as a default.

Hmm, I hadn't realised that specifying "-p" would disable the "--raw".
I still find the last sentence of the original patch slightly awkward
though.  How about

    New users are encouraged to use linkgit:git-log[1] instead.  The
    `whatchanged` command is essentially the same as linkgit:git-log[1]
    but defaults to ``raw'' diff output and does not show merge
    commits.

?
