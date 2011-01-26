From: Mika Fischer <mika.a.fischer@googlemail.com>
Subject: Re: [msysGit] Git unable to access https repositories due to
 curl/OpenSSL 1.0.0 handshake issues
Date: Wed, 26 Jan 2011 11:04:45 +0100
Message-ID: <AANLkTikmM8VzM0hKmr7h7mTUO_z8wqvNFYShw2Pe982m@mail.gmail.com>
References: <0aa77107-bb31-4f74-90e2-02ce5155b0a0@l17g2000yqe.googlegroups.com>
 <AANLkTi=UQR3cEbTj4N0W_4CLG9T1F+rmkLEew+WO4w5f@mail.gmail.com>
 <AANLkTinGLMcRJ9EuZY_k4GoKyg+r7hxcgnq3z0=qOemA@mail.gmail.com>
 <AANLkTimJznExH8N9fcgSC88HOPfaFDF7jFMTZUJauL9+@mail.gmail.com> <alpine.DEB.2.00.1101261056570.5603@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kusmabite@gmail.com, msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Wed Jan 26 11:05:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi2FX-00045A-1L
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 11:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab1AZKFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 05:05:07 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55036 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab1AZKFG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 05:05:06 -0500
Received: by iwn9 with SMTP id 9so706821iwn.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 02:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Ego2f31QXkkqTDH1ggCsDZttAggruDmCzmOxhGhBU48=;
        b=ToIKQkX81ps5PnDPgWLLzuh60d86lvlLplbHyFROfiUNh2W3sJ1BtzY/ZAB5Ks6o3m
         XdvyaA5HqtfNpnaDfE/EryLILQCPAbS64SkL2nYF3V1X4JYUormbQKqEg5nd4CqM0YXD
         IrjMVTbBJeKrIzRyHKsMZvpfta23KoKsFS2mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=jYFITyrB3ueq6HhJp8q1idmcAOajzVqzXI/5aKX50ZriF5kP4D2EqgwkuKb9BUf6NL
         ikvjOs4LcvvgYZsY5751s2NrFCdLCwgPehIUbQ7uHuSxbGXksIQOuQrTIme9AF/WT/8+
         515AtQLbJGjmwuM1WXauejEKLGXSAO58BWYZo=
Received: by 10.231.39.76 with SMTP id f12mr7898081ibe.126.1296036306001; Wed,
 26 Jan 2011 02:05:06 -0800 (PST)
Received: by 10.231.8.215 with HTTP; Wed, 26 Jan 2011 02:04:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101261056570.5603@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165513>

On Wed, Jan 26, 2011 at 10:57, Daniel Stenberg <daniel@haxx.se> wrote:
> Are these clean builds of libcurl and OpenSSL from source?

I just compiled libcurl against the OpenSSL library of OpenSuSE 11.2 (0.9.8k).

If you want me to test other combinations/versions etc. just let me know.

> I'll try to look into this.

Thanks a lot!

Best,
 Mika
