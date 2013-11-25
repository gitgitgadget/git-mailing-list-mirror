From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: branch annotations?
Date: Mon, 25 Nov 2013 23:59:56 +0530
Message-ID: <CALkWK0nfSMSOnEXxoRfvvorrc-goDJFbbgcQDm1gKwiZEKQTuQ@mail.gmail.com>
References: <20131125084644.350bd4f7@bigbox.christie.dr> <20131125145644.GB23802@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tim Chase <git@tim.thechases.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 25 19:30:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl0vi-0005h3-Sp
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 19:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757329Ab3KYSaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 13:30:39 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:43955 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328Ab3KYSai (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 13:30:38 -0500
Received: by mail-ie0-f175.google.com with SMTP id x13so7696288ief.34
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 10:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=u3hr1hL3Vv1odog8NvNr0ZZStPFdC6X8Dxcd3ldG13k=;
        b=u1kM0Qunu95Pc++bLeXlBULMRR2tXp37sF4Drl13YzcYskEB80Ib5KhFMzkZtM1DJY
         qOEO6jiJcFErm4zzBWJDPU7P3VSh7ysstBzIiOIQqIBr8u6J9JG2T2l9R8w9oed2vQSe
         EnArBxE46jgsNBIaLkcu9XXHyOa1ZnBf8x9qwAC/04Hqsmu3eeiTF6wwq9SdNml014Y6
         xvtQwk79Gin55jHBrmnhjw8YD9B3b1hU0xbaHVqKTCvsXfOX3whMxvXC/eiMB4YvuIVv
         DyqoQaZdr+/uGxZUuYKxCr/9fhJyeYKyZBaH32eYd208TtPTZo3MJKGI/IES5tBsfmjW
         9qDQ==
X-Received: by 10.50.73.74 with SMTP id j10mr13797867igv.50.1385404237871;
 Mon, 25 Nov 2013 10:30:37 -0800 (PST)
Received: by 10.96.90.39 with HTTP; Mon, 25 Nov 2013 10:29:56 -0800 (PST)
In-Reply-To: <20131125145644.GB23802@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238327>

Jeff King wrote:
> I think it makes sense to be able to show it as part of "git branch",
> but the verbose branch listing there is a bit of a mess. Doing it
> cleanly would probably involve refactoring the branch-display code to
> allow users to specify more flexible formats.

Certainly. I'm quite unhappy with the current 'git branch', and am
looking to improve it. Branch descriptions will definitely be useful
to display as well.

> Ramkumar (cc'd) was looking into that refactoring a while back, but I
> did not follow it closely (it looks like some of the underlying
> for-each-ref refactoring is on the 'next' branch?).

The previous effort in collaboration with Duy fell apart,
unfortunately. Currently, there are a few small patches enhancing
f-e-r from the original series in 'next'. Once they graduate, the plan
is to refactor f-e-r a bit so that 'git branch' can slowly be moved
into using its machinery.
