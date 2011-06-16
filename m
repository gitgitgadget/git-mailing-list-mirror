From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH 7/7] archive: provide builtin .tar.gz filter
Date: Thu, 16 Jun 2011 14:27:27 -0400
Message-ID: <BANLkTikv+3G5isAGECTm=YJjzvQkmZZvKw@mail.gmail.com>
References: <20110616003800.GC20355@sigill.intra.peff.net>
	<7v39jai94h.fsf@alter.siamese.dyndns.org>
	<20110616065146.GA30672@sigill.intra.peff.net>
	<20110616075621.GA12413@arachsys.com>
	<20110616174653.GD6584@sigill.intra.peff.net>
	<7vtybphcym.fsf@alter.siamese.dyndns.org>
	<20110616182149.GB12689@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>,
	"Ren?? Scharfe" <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 20:27:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXHHz-0000o8-0e
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 20:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758184Ab1FPS13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 14:27:29 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:46622 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757801Ab1FPS13 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 14:27:29 -0400
Received: by yia27 with SMTP id 27so914965yia.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=tZrpCDrcKvKiNivmpvosvmj1cSneI5HcYxoPXx/UwpI=;
        b=jMIFwvIBvU7GQJauN97DbueAduIYDnbejwFiW9demZfkZsLqVPiZspGl9Rv93mYVOY
         7QR4R1HCx22qaFj9b2Uuf2QZ5eAYhy6LUJUC+uucXFlDLZUFLk1iTzhCUTfMk7LTS/TU
         YleftXM1LQpxVpZWKn8fBubBWfeRmsyZG+O8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=B8r5ExchUeLd6HcA3S1JXoBkqvJU1pcSNKommOp+lVCMij4xth+7N60WHx6ChJExsn
         nraPH4vvpaDNHcxPrfRO7TXjr90CieF7UYdFkGkIUtBWaU4Tcx6WbZeKMNX9lDPaH99e
         vfv4sL15qFC96gorpSDIVh/kCD2iSu9GSeBbs=
Received: by 10.236.46.74 with SMTP id q50mr1987538yhb.137.1308248847851; Thu,
 16 Jun 2011 11:27:27 -0700 (PDT)
Received: by 10.236.70.106 with HTTP; Thu, 16 Jun 2011 11:27:27 -0700 (PDT)
In-Reply-To: <20110616182149.GB12689@sigill.intra.peff.net>
X-Google-Sender-Auth: OYGGI8O2bU6wGvy0Yg72eOEMSzo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175913>

On Thu, Jun 16, 2011 at 2:21 PM, Jeff King <peff@github.com> wrote:
[snip]
> Also, since it's easy via the external helper route, should there be any
> other builtin formats? Bzip2? It's not that big a deal for a big hosting
> site like kernel.org to stick it in their configuration, but I wonder if
> normal users would find it useful.

I'd certainly find it useful.

-John
