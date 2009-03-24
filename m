From: Stefan Karpinski <stefan.karpinski@gmail.com>
Subject: Re: [PATCH] git-cget: prints elements of C code in the git repository
Date: Tue, 24 Mar 2009 10:04:28 -0400
Message-ID: <d4bc1a2a0903240704s34547647s28e6df83455f89c@mail.gmail.com>
References: <49C8B159.2040600@gmail.com> <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302> 
	<49C8E074.4030808@gmail.com> <20090324135906.GA10644@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Roel Kluin <roel.kluin@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 15:07:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm7Gy-0006mJ-GA
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 15:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759080AbZCXOEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 10:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759053AbZCXOEs
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 10:04:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:14608 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759025AbZCXOEp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 10:04:45 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2317261rvb.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FXB6zjEuGRx7zD97Pn+nrj/+3xPNreWievXzZH0bUNw=;
        b=BwHDeOEiaMWb4yXZzHOz6Zclu9l9dLp1jIlzmSD0JYtepfE61zUI/B1AleRPDjXGsq
         C6XL+5zXLmt/VoU1IGabF7Iqu9KAf5UMqYcr931Uu+Pigfv+GJcgUJ5xQv0bqp8FGq8F
         MU89YCfxFpVUT/wap+S7v4XrF1U9JRxeD23jo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q6tVARX0xiiv26hEM6kiG2Y9XwOD/dOXJmCWmX8Yzgzufap46XlNh01z60EM03/jdN
         JLvqaoFmDxoZxhXtupnFdKugwGygS5s2DVlkNLLz5XQc44DRiw6Bc6B2s+oljSXfsn0k
         gOI0WCGZjWItKtSenJup4q2r7cyi7ms79vdC8=
In-Reply-To: <20090324135906.GA10644@coredump.intra.peff.net>
Received: by 10.114.125.15 with SMTP id x15mr5638746wac.42.1237903483587; Tue, 
	24 Mar 2009 07:04:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114461>

On Tue, Mar 24, 2009 at 9:59 AM, Jeff King <peff@peff.net> wrote:
>
> Wouldn't it be a lot easier to base this on something like ctags, which
> already knows how to do all the parsing of C quirky C?

Ctags also has the advantage of handling other languages. According to
the man page: C, Pascal, Fortran, YACC, lex, and lisp.
