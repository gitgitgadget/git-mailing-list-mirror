From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 7 Feb 2011 10:01:06 +0100
Message-ID: <AANLkTiksUqVnWeZOm-9XN3BbfVcjc6fWdwPcPJ-PLb88@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102070451.37370.johan@herland.net> <20110207051123.GA4748@sigill.intra.peff.net>
 <201102070958.11551.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 10:01:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmMym-0000tC-EE
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 10:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180Ab1BGJBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 04:01:47 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44924 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab1BGJBr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 04:01:47 -0500
Received: by iwn9 with SMTP id 9so4344833iwn.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 01:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=9Sb7PSxVzCXH1jiNE+PhJ6EKnialWQD3BBf1Zc0te/g=;
        b=xpuU/t63Ag47Ex0LYNIZOWaTUT0zzKWddYfozVFb/f57U1ox/a2B33cjlSmdIfnzKb
         THhgYMtOJEBVlgM0o4+xVY01z0JUAUf0JX0Es7Kgxo641YgBw12X5+IpaYIu6RfqAvH1
         OR1OAtQSAI7rLdt0t3w5ExkKldipO9jtXUXyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=oClpG3p12FZyaoZKrMus4qA5L9R6VMUlMWW53mTDHCpvRv3VmEWJV+auscsDhWsXbU
         zW03nMAD+q4beHtWOPinHv2g3pHBIvZunuWrUVwR32VxHKCwpkwYFqdLlVEnsLrAr+RT
         TSKhAbpsDv7io0Ee5wjfyQt0sVB97wYO+zRKw=
Received: by 10.231.147.149 with SMTP id l21mr16779112ibv.152.1297069306503;
 Mon, 07 Feb 2011 01:01:46 -0800 (PST)
Received: by 10.231.39.140 with HTTP; Mon, 7 Feb 2011 01:01:06 -0800 (PST)
In-Reply-To: <201102070958.11551.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166243>

Heya,

On Mon, Feb 7, 2011 at 09:58, Johan Herland <johan@herland.net> wrote:
> This is the same technique we use when talking about branch names: On this
> mailing list, nobody is confused when I refer to 'maint', 'master', 'next'
> and 'pu'. Still, in our own work repos (at least in mine), these branches
> are actually called "refs/remotes/origin/<name>" (commonly referred to by
> their shorthands "origin/<name>"). Here we are, juggling the same kind of
> namespaces that I propose for tags, and it seems to work well without
> causing much confusion.

With the difference that you can't refer to "maint" as just "maint"
unless you've created "refs/heads/maint" iff it is unambiguous.


-- 
Cheers,

Sverre Rabbelier
