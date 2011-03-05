From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Fri, 4 Mar 2011 23:00:30 -0600
Message-ID: <20110305050030.GC22976@elie>
References: <20110214231920.GA24814@elie>
 <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
 <20110227084317.GB3356@sigill.intra.peff.net>
 <1298820840.19827.69.camel@drew-northup.unet.maine.edu>
 <20110228230311.GA7533@sigill.intra.peff.net>
 <AANLkTi=LPqu9zDiAJpxqC=ZCLig+aCv5ztXw668ERtH7@mail.gmail.com>
 <op.vrnq8gk856e9f9@xman.eng.oslo.osa>
 <1298997963.5247.30.camel@drew-northup.unet.maine.edu>
 <AANLkTinAUsY-d3Ec6HpKbjzC+eUjGcq1LK5ODjxRC-yz@mail.gmail.com>
 <AANLkTimX3n5PNdK9YpA92SQM7G-WAiC1aPP7qJ-UEudq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Drew Northup <drew.northup@maine.edu>,
	Alexey Feldgendler <alexeyf@opera.com>, git@vger.kernel.org,
	David <bouncingcats@gmail.com>, Jeff King <peff@peff.net>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sat Mar 05 06:00:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvjbf-0005NC-Pn
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 06:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008Ab1CEFAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 00:00:39 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59020 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab1CEFAi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 00:00:38 -0500
Received: by yxs7 with SMTP id 7so1011398yxs.19
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 21:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=A8LxD/zynCy+vrh086hkEmRSh61hgjpmeDwRPpTAm10=;
        b=FeFxCciP/oNaEkvf/DXG+6cIi8NKsrxL8A3lm4ZxBmlgoac94XA/1XztEc0fcIP/YN
         g14IsijnkeQynQlw0p9kVQ6xUR8e1yHgsEwc3CEj2Jn/6WCcDLUfBKlvILIZBJq2NJ6s
         dB5PzR4UbZCJ9TybNPyQ4Jjjpy77bvb7Ql1YE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vIYul+6btgCztLuLJlYmei+Fi0IKxuLHm39/NQly9XydWus1I/fLULgTQYbgmzNXz8
         1xD47dIA0i5EzxwyzTDqy8TCt2PBvfC1z7bi2P84RYEfY5A6flC7EM0YcsMr5Vbc67ya
         Mnsu31lfXsqG/JOmttXtlsahTq1oEdF8F1Xmc=
Received: by 10.151.134.7 with SMTP id l7mr1666280ybn.126.1299301237395;
        Fri, 04 Mar 2011 21:00:37 -0800 (PST)
Received: from elie ([69.209.58.75])
        by mx.google.com with ESMTPS id x4sm160555ybl.20.2011.03.04.21.00.34
        (version=SSLv3 cipher=OTHER);
        Fri, 04 Mar 2011 21:00:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimX3n5PNdK9YpA92SQM7G-WAiC1aPP7qJ-UEudq@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168479>

Miles Bader wrote:

> I don't why so many people seem to be trying so hard to come with
> alternatives to "staged" and "staging area", when the latter are
> actually quite good; so far all the suggestions have been much more
> awkward and less intuitive.

*nod*  Actually, "staging area" is intuitive on first reading and
"stage" less so to me, while the alternatives tend to be more
confusing for what it's worth.

I think this thread has outlived its usefulness.  Could people with
concrete proposals (e.g., "the description of 'git add' is confusing
in such-and-such way; this rewording makes it clearer", or "the
glossary does not describe the staging area very well; how about
this description") please start new threads?

Thanks,
Jonathan
