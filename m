From: Gisle Aas <gisle@aas.no>
Subject: Re: Make author and committer available to pre-commit hook
Date: Tue, 6 Jul 2010 11:22:07 +0200
Message-ID: <AANLkTilsdbJLHTY7cx2GeZg9ai_OZhmnEt0KdFjF81Pd@mail.gmail.com>
References: <AANLkTinpCDRf_Yhuj2-tdZwmvHk8yna1Xjdtbrmx35CB@mail.gmail.com>
	<20100705114619.GA21146@sigill.intra.peff.net>
	<AANLkTinlGBt3nBa7Ge5ytjisTeDu3As4wCkF8M1iz5JV@mail.gmail.com>
	<AANLkTim-TXX4uVyUN9loOI276wnKp22m4F7g5c-js61U@mail.gmail.com>
	<7vocel5n08.fsf@alter.siamese.dyndns.org>
	<20100706072947.GB3567@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 06 11:22:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW4M6-0004yf-QQ
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 11:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836Ab0GFJWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 05:22:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37780 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905Ab0GFJWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 05:22:09 -0400
Received: by fxm14 with SMTP id 14so4527578fxm.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=tVbBnKPap/vtcDD/lkMDSeIlM+C8t+//gtXbJmbBAeU=;
        b=lT5oBQFZBpYO1OZ0JmhOwIc4aUZ0JL7AdPDvHAM1/Yi4gXHntb4fpGk9BBd8rOqSVy
         IfyaGtBR7y6BELThogt1oesMBzhkft9jKxD/p9vCf3nrUxFAmyNeLsDxOtk1KLBVVIop
         NsdIMmy53IykMovWA1JIaDFEzRfGkqBQq3/cM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=fBzv2g3odMxbiDT2K/gi8Vjk29nEpsQ1k8u4CpPW2k2n5q3UiHGKO1XOxJPnNk409z
         +CMq16qn8GmXgkL1n593ISVBO6MH79gGD9IGquzHLM4hj1OSaeGhJRvIA4UfXi3rtWB9
         7IJLpzo6kEbyQsj+2IEG9rlYIaH+bsUQaceKo=
Received: by 10.239.131.202 with SMTP id 10mr295024hbo.115.1278408127722; Tue, 
	06 Jul 2010 02:22:07 -0700 (PDT)
Received: by 10.239.173.201 with HTTP; Tue, 6 Jul 2010 02:22:07 -0700 (PDT)
In-Reply-To: <20100706072947.GB3567@sigill.intra.peff.net>
X-Google-Sender-Auth: 1eNWkMsQKGuZ0zoBR4dZF0gBLT4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150339>

On Tue, Jul 6, 2010 at 09:29, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 05, 2010 at 08:04:39PM -0700, Junio C Hamano wrote:
>
>> I wonder if we should also make author/committer dates available via the
>> same mechanism.
>
> I don't see why not. It is a trivial amount of code, and I can see at
> least author date being useful.

One question that arise is what format the date variables should have.
 Is the raw format (that is "1278400946 +0200") sensible?

I've created a patch for this locally, but it has some side effects in
messing up the dates stored by 'git commit -C...' which I have not
figured out yet; and now I need to get some other stuff done.  It
might take some days until a revised patch is ready.  Feel free to
contribute your "trivial amount of code" before I get around to it :-)

Regards,
Gisle
