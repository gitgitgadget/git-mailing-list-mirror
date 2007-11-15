From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Grammar fixes for gitattributes documentation
Date: Thu, 15 Nov 2007 18:20:10 +1100
Message-ID: <ee77f5c20711142320x1a070b21xf00f0853fe09e34c@mail.gmail.com>
References: <33080F0B-80C0-4860-9A74-C6878EE3B2CD@wincent.com>
	 <7vfxz9kxz3.fsf@gitster.siamese.dyndns.org>
	 <3461FD6E-1C46-4278-9EB0-5D730BB99084@wincent.com>
	 <20071115071558.GE10185@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Wincent Colaiuta" <win@wincent.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 08:20:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsZ1h-0003CN-2Q
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 08:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758043AbXKOHUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 02:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758441AbXKOHUO
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 02:20:14 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:64287 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757001AbXKOHUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 02:20:12 -0500
Received: by rv-out-0910.google.com with SMTP id k20so416198rvb
        for <git@vger.kernel.org>; Wed, 14 Nov 2007 23:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OSUVu0ZBTB6HLpWT4KqZ59sOtuJ+cvBICOoIpyxjuVU=;
        b=VE9HEyBm3sJL7fumx0H2myTIzT+Seqvhr/wV6YyvphmIhYYuTJX+gsxhmScDhbJsk1/xM3VtFkKGHE2Xl9VOn0qQbUiJuE2OoD5TNsx13Now16Hgdei1ts2bi5vbTsM5beCGYAiJiByvavx+c3BsIoNUILX1A6qUwPgcaILH6/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MCfH61DobAJpaYHnvuQg0L2TyyiAfrb95bSKbnN4Jx615//2maoMQpf/4bRAkh/ABCwA/sUrkWu8Fvd4Yh2G7qHYHdohxZf3NaBEqCO0P3o2hYAmFMk+qxDUliYn38sXEn7ncMVuutRc3FxmvvwAxZB4q2VGlhtwYWRPULKp3Rc=
Received: by 10.140.191.14 with SMTP id o14mr150280rvf.1195111210891;
        Wed, 14 Nov 2007 23:20:10 -0800 (PST)
Received: by 10.141.20.13 with HTTP; Wed, 14 Nov 2007 23:20:10 -0800 (PST)
In-Reply-To: <20071115071558.GE10185@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65076>

On Nov 15, 2007 6:15 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 14, 2007 at 10:04:25AM +0100, Wincent Colaiuta wrote:
>
> >>> +A `filter` attribute can be set to a string value which names a
> >>> filter driver specified in the configuration.
> >>
> >> Will we get the canned "which vs that" discussion on this change?
> >
> > Perhaps. Neither would be incorrect, although technically "that" is a
> > tighter match.
>
> Really? I would think "which" works better, in that it is not
> restrictive. I.e., "The filter attribute is set to a string. This
> string, btw, names a filter driver" (which) rather than "The filter
> attribute is set to a string, and from the set of strings, it is set to
> the particular string that names a filter driver" (that).

"that" should be used to introduce restrictive clauses (as you point
out), and this use should be a restrictive clause, since you can't set
the attribute to just any value--you need to set it to the value
*that* names the desired filter driver.


Dave.
... writing a thesis, so has grammar on the brain.
