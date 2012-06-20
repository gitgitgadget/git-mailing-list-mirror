From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 1/8] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Wed, 20 Jun 2012 14:30:40 -0500
Message-ID: <CAFzf2Xw3TdvZCFLvbqKY5F9b+0hTzTQEEfmqjL9u=uvyc7mZ5w@mail.gmail.com>
References: <20120619232231.GA6328@sigill.intra.peff.net>
	<20120619232310.GA6496@sigill.intra.peff.net>
	<20120620035015.GA4213@burratino>
	<20120620042607.GA10414@sigill.intra.peff.net>
	<20120620102750.GB4579@burratino>
	<20120620163714.GB12856@sigill.intra.peff.net>
	<20120620182855.GA26948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:30:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQc1-0006vI-HA
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757900Ab2FTTam convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jun 2012 15:30:42 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:47453 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757679Ab2FTTal convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jun 2012 15:30:41 -0400
Received: by gglu4 with SMTP id u4so5995825ggl.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=P2ytu53XF1JVxGiK9kGbXm6veBkLrh97jaRgpJ9ls7s=;
        b=feATwN3aelMhU+xCjEdcJJfF2rZO36cAi6/wW0Low3xRMTy2VCEmpUFiqQ/25QPGS+
         /JDmI3LRzkxtKMwCRhE7VCXbGQa3XGfr0LPQbRsPBALJ0IMX2nTWQNXjwSf9h5YYgdSr
         sE2Ej/JeMTNCoaj5IgqUTYsjLsg4h33ewP72bEfnii0rzLFTxxB0Bk0TjzSAYR4QZnme
         lXaHK/Pk1suBTRNrtq7s5ge5fYeT1a1MJgyEvr85sYeRbS3KdHFlcBCBCm19RcRuksBa
         OQOQeVYBBEQb+rVR/3eVBMSOywf4+v40rZ/rDdUkOsJYb+QDD+8jKf8dXPmywDDI+xRb
         LZAg==
Received: by 10.50.182.196 with SMTP id eg4mr5655692igc.26.1340220640212; Wed,
 20 Jun 2012 12:30:40 -0700 (PDT)
Received: by 10.42.30.136 with HTTP; Wed, 20 Jun 2012 12:30:40 -0700 (PDT)
In-Reply-To: <20120620182855.GA26948@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200337>

Jeff King wrote:

> Here's an updated series that drops these lines and I hope will addre=
ss
> the commit message issues you brought up:
>
> =C2=A0[01/11]: Makefile: sort LIB_H list
> =C2=A0[02/11]: Makefile: fold MISC_H into LIB_H

Please no.  Progress would be teaching the remaining compilers to
autocompute header dependencies so there would be no need to maintain
a master header list at all. I would understand if the headers had
been falling out of date and this were a way of saying "we give up",
but given that that is not happening, why would this change be a good
thing?

My comments were only about explaining what I found hard to understand
in the commit message. The patch was good. Please don't retaliate this
way. :)

Hope that helps,
Jonathan
