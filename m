From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: What's not in 'master' but should be
Date: Fri, 18 Jan 2008 11:53:06 +0100
Message-ID: <8c5c35580801180253x9022e62qf1ec515e101fb294@mail.gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	 <47891658.3090604@gmail.com>
	 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	 <47893E1A.5020702@gmail.com>
	 <7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	 <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	 <8c5c35580801180215s2c980b4kbc66fbb05778ff67@mail.gmail.com>
	 <7vwsq7fn2e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 11:53:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFoqv-0007DR-DH
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 11:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbYARKxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 05:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbYARKxJ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 05:53:09 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:12562 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbYARKxH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 05:53:07 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1662088wah.23
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 02:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vIwmOXt3ajTIRWF/U5dKPhFPpYPFX1XdkYft28/W9Zc=;
        b=B6bNuKNtGyyFKI0qm8gRccLCaA4DdK8d0JHZPFGRmnwhgiG+/q9+DQbHi7F35vmFAGYd277ZdVEoMXmBMpCsGbiIo3l54g3gIGd8XeZ2Dz2fcwViwnO+ShGZvUtgQDyEAmhOdzCNlW827aRrfWX2JhMX+d3JF2amR2+ckdJ943Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sGEXIwLeVMs+e/QAEGr8dKOPb7LgoahCUNUdDXHAhE7QrwxpxLWlw1mfmtX6D2eAKBviTadqGMCASROB9dCbN0ThQ+wiPrZTA93fPtRNqWaYSv140kBVzuCYx3Q9UvMieegjhmIK4aj1IaW2FhlKr8IoWOLH4Cs9fsQoztx89oE=
Received: by 10.114.103.1 with SMTP id a1mr733948wac.59.1200653586718;
        Fri, 18 Jan 2008 02:53:06 -0800 (PST)
Received: by 10.114.241.8 with HTTP; Fri, 18 Jan 2008 02:53:06 -0800 (PST)
In-Reply-To: <7vwsq7fn2e.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70996>

On Jan 18, 2008 11:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Lars Hjemli" <hjemli@gmail.com> writes:
>
> > Here's a patch which might have been lost in the noise:
> >
> > http://thread.gmane.org/gmane.comp.version-control.git/70463
>
> Not really.  It came late into rc cycle without fixing any
> breakage.  Not 1.5.4 material.

Hmm, isn't a nonfunctional libgit considered breakage? Without
something like this patch it is no longer possible to use
write_tar_archive()/write_zip_archive() in libgit.a.

--
larsh
