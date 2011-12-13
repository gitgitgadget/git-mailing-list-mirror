From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] t5540: test DAV push with authentication
Date: Tue, 13 Dec 2011 22:28:07 +0100
Message-ID: <CAHGBnuO1CFGacMQb+Md_uGsLu=V9bGDpcFLd9Lb4C5jSN+uUiw@mail.gmail.com>
References: <20111213201704.GA12072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Naewe <stefan.naewe@gmail.com>,
	Eric <eric.advincula@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 13 22:28:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaZtW-0008EM-NH
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 22:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539Ab1LMV2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 16:28:11 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55408 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab1LMV2I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 16:28:08 -0500
Received: by ggdk6 with SMTP id k6so102600ggd.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 13:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=c6kk8WoG9sV67efgwlLHL1AuG+RxqXgsh/zToIRrBDs=;
        b=efu+rc/veelS/vqJKFUfmMzZD1dta3bVwBzWYXOvRDTcjMJBzFdZe3AZd6a41dl4Eh
         kA95n8M2a9543D5GgbLZR/xElenrNiNuV5cCTGmsmhWmYpYiIM8JKPv1Asyzy9t86tXc
         l5SCThJMt6lgsqwsF4+XO28N4fqYNZaFXNfPc=
Received: by 10.182.75.65 with SMTP id a1mr4731550obw.32.1323811687624; Tue,
 13 Dec 2011 13:28:07 -0800 (PST)
Received: by 10.182.33.165 with HTTP; Tue, 13 Dec 2011 13:28:07 -0800 (PST)
In-Reply-To: <20111213201704.GA12072@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187064>

On Tue, Dec 13, 2011 at 21:17, Jeff King <peff@peff.net> wrote:

> We don't currently test this case at all, and instead just
> test the DAV mechanism over an unauthenticated push. That
> isn't very realistic, as most people will want to
> authenticate pushes.

Thanks for adding this, Peff!

-- 
Sebastian Schuberth
