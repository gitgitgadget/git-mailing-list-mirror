From: J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH/RFC] grep: add a grep.patternType configuration setting
Date: Fri, 3 Aug 2012 14:22:49 -0400
Message-ID: <CADFUPge8LdBKHFrs32gFtzFwvvbK6OSxfMBdHF6fyRwtcCocTw@mail.gmail.com>
References: <1344005630-6541-1-git-send-email-dark.panda@gmail.com> <7vsjc4aq0b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 20:23:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxMWq-0008ID-U9
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 20:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286Ab2HCSXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 14:23:12 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58004 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab2HCSXK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 14:23:10 -0400
Received: by yhmm54 with SMTP id m54so1168108yhm.19
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 11:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tiQ00P8NUcZajZE+bLsWonpG4M0nXxdBuEocpKPYv0c=;
        b=BaO9hC/W4SMc/RhOnEk1XiILJkdEkqnT89Ikz8aVW9AvieoIzfnE1djBwOjBfl8SRR
         kpYvjuRxaGYTY2D6xtsJqG5FqjBafVHGt4KOaTZ37ZI5bubGmgS9l+cxlj371YhO7d0f
         InN3C63Y8pTyrdjOApWExFb5N5EIBgC27EDKR0m2ZUq3MMWrgZUW6IqbETcw5aJRFT0F
         H4XfDnWsUOMFtHTRn0Eu/7hUlPIKABtiTK0D8FrqyCj2Xse3t0lvMDxD8kMv5tb6ZvHB
         R9UslDmTMONilaMFaeGQxEZpHsy6NfycU+yeCzb9x4v3Y9546e9AAPo1/jWG378Wh8T8
         4G9A==
Received: by 10.60.169.100 with SMTP id ad4mr6990118oec.21.1344018190019; Fri,
 03 Aug 2012 11:23:10 -0700 (PDT)
Received: by 10.76.76.38 with HTTP; Fri, 3 Aug 2012 11:22:49 -0700 (PDT)
In-Reply-To: <7vsjc4aq0b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202847>

On Fri, Aug 3, 2012 at 12:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Much nicer than the drafts in earlier discussion.  One micronit is
> that probably it is preferrable to do '!=' instead of '>', as we are
> only trying to see if it is unspecified on the command line (hence
> need to pay attention to configuration) and do not care how the
> enums are ordered, but that is nothing that requires a re-roll.

True enough. Old habits I guess, eh?

> All the new tests in the script looked very well thought out.
>
> I noticed that this particular one will still succeed when somebody
> breaks your code to ignore the configuration (as -G "a+b" would give
> the expected match) or give higher precedence to the configuration
> (as fixed "a+b" also will give the expected match).  Not that it is
> wrong to have such a test that is unlikely to catch certain kinds of
> regressions in the suite, and the particular kind of breakage will
> be caught by the next test (snipped) anyway.

Yeah, that test is kind of iffy, but does no harm I suppose.

> Will queue.  Thanks.

Great, thanks. Been an informative experience for a first-time git
patcher. Cheers.
