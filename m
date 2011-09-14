From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 16:30:10 -0700
Message-ID: <CA+55aFxFnAjpSAd+uB25BuZXBJGvN59qNMmF3fzvky8XK_DP0A@mail.gmail.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <vpqfwjzxu6i.fsf@bauges.imag.fr>
 <CA+55aFyGRM132OzoJR7wZ8wETvxrFWSmSMjMJnVOKP+6vys-Sw@mail.gmail.com>
 <201109141814.04752.johan@herland.net> <E9E05FA85D0F4461BAE9ECAFE25CD84E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>, Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 01:30:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3yug-0002ve-UO
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 01:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694Ab1INXae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 19:30:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46131 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab1INXab (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 19:30:31 -0400
Received: by wyh22 with SMTP id 22so2167913wyh.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=tfBr93bzFLa8tlkwOZgVzmg6UYu50/8sZ6zb7iR237Q=;
        b=xySjBOV/RdAZM5W76agYayB0L4oRSGuqilp85yhYQxQXaPN5fcsxhxDltKLTZcfNuD
         Nd9mCoBggD2n4wyLSjWizMDNaVHIbc/z/YaWeajFe+nA1BL9cEPTl7kThXFh4+HLCFYW
         8YQe5vUkS3fymfbmeoDs98Xrh0sW9IOUwzhH8=
Received: by 10.216.9.139 with SMTP id 11mr356563wet.106.1316043030076; Wed,
 14 Sep 2011 16:30:30 -0700 (PDT)
Received: by 10.216.174.8 with HTTP; Wed, 14 Sep 2011 16:30:10 -0700 (PDT)
In-Reply-To: <E9E05FA85D0F4461BAE9ECAFE25CD84E@PhilipOakley>
X-Google-Sender-Auth: mEdqdLSbJZxx8XjEKTImsfRjsOI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181412>

On Wed, Sep 14, 2011 at 3:51 PM, Philip Oakley <philipoakley@iee.org> wrote:
>
> Is one option to store the branch description (if any) on line two of the
> <branch name> file in .git\refs\heads.

Or even on line one.

We already basically do that for the magic FETCH_HEAD branch, and use
it to populate the merge commit. Extending that kind of thing to all
branches might be a nice idea.

Of course, then the question becomes "what about packed refs"? Do you
just leave the unpacked ref in place for those?

                          Linus
