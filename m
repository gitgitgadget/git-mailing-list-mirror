From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 0/6] Make "local" orthogonal to date format
Date: Wed, 2 Sep 2015 21:21:48 +0100
Message-ID: <20150902202148.GM30659@serenity.lan>
References: <20150901083731.GE30659@serenity.lan>
 <cover.1441144343.git.john@keeping.me.uk>
 <20150901224431.GA9353@sigill.intra.peff.net>
 <20150902074826.GK30659@serenity.lan>
 <20150902080529.GA19248@sigill.intra.peff.net>
 <xmqq4mjcq2ac.fsf@gitster.mtv.corp.google.com>
 <20150902194946.GL30659@serenity.lan>
 <xmqqk2s8mvig.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 22:22:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXEXm-0002wC-Rk
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 22:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914AbbIBUWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 16:22:01 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:36659 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbbIBUWB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 16:22:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id B0C29CDA5F2;
	Wed,  2 Sep 2015 21:22:00 +0100 (BST)
X-Quarantine-ID: <AN5rXwJFhwnA>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AN5rXwJFhwnA; Wed,  2 Sep 2015 21:21:59 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 9F962CDA57C;
	Wed,  2 Sep 2015 21:21:50 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqk2s8mvig.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277120>

On Wed, Sep 02, 2015 at 01:11:35PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> > OTOH, I don't think there's any disagreement about what "relative-local"
> > and "raw-local" would output were they supported, just whether they are
> > useful.  There doesn't seem to be any harm in supporting them;
> > "relative-local" will be identical to "relative" and "raw-local" will
> > require preparatory code movement for the raw output.
> 
> Sure.
> 
> Bikeshedding further, while Peff's message "-local is meaningless"
> is a correct statement of the fact, I do not think it explains well
> why we chose to error out instead of giving the most natural result
> (i.e. exactly the same as 'relative').
> 
> Perhaps stating "relative-local is not supported" without saying why
> would be better.  "Because it is meaningless, we refuse to support
> the option." is a very strong statement that tells aspiring future
> Git hackers not to attempt to add a support for it, which is
> probably a wrong message to send.

In which case, should we just support it now?

Normally I'd suggest banning controversial options on the basis that
it's easier in the future to allow something that was previously banned
than change the meaning of an options, but in this case I can't see any
other meaning for these options than that described above.
