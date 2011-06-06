From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Mon, 6 Jun 2011 21:05:11 +0200
Message-ID: <BANLkTikLZSrsy0D0Gs-tNKgbqJOG7qJNsA@mail.gmail.com>
References: <20110603050901.GA883@sigill.intra.peff.net> <20110603051805.GC1008@sigill.intra.peff.net>
 <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com> <20110603181052.GA17538@sigill.intra.peff.net>
 <7vei37bxbp.fsf@alter.siamese.dyndns.org> <7vaadvbwpw.fsf@alter.siamese.dyndns.org>
 <20110606161143.GC11485@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:06:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTf7d-0005n0-Ls
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 21:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757047Ab1FFTFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 15:05:52 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:51557 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab1FFTFw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 15:05:52 -0400
Received: by qyg14 with SMTP id 14so2113202qyg.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=xPE4QWaZlBl8mJ1tP46E72LsVvtsSaeudolghgTvuGQ=;
        b=dwoDjKuPhSEgAMN/U7b6GHBMTMshGEnqWUtsnhFy1BaTa4znSSwGTwUd72wpzvvaQp
         xc13EMkJ81dy7XE8g2av2RjAHSrAZZFUiiBsg/UNTNFOoD/6VY9/Hnm+XhsmfS/L7Lv1
         jP1CCBJdTXSczy+IA+wMDXRYKJ0iVMj6ab2oU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HtmAlQO84B4BNZUxCccS+sg5yw04XTAYOWOjsfDDYfZ1IzXc9pS6zYRiFTlrokDI3o
         lWW0BxJlevpxwtuRptzMY6OHrrEVMGDuYNUZcDcHD3hITMwQ7SrucnNCtvCtaTOApdkg
         JmAEFEFUmUuq23YU+D7/h1oOvoE0lXY4MnyVE=
Received: by 10.229.127.105 with SMTP id f41mr3958094qcs.15.1307387151184;
 Mon, 06 Jun 2011 12:05:51 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Mon, 6 Jun 2011 12:05:11 -0700 (PDT)
In-Reply-To: <20110606161143.GC11485@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175150>

Heya,

On Mon, Jun 6, 2011 at 18:11, Jeff King <peff@peff.net> wrote:
> I'll try the nicer fix Sverre mentioned and post a real patch. I wanted
> to add a test for multiple refs to the test suite, but I got bogged down
> by other breakages. Some of which I think are the fault of testgit, but
> one of which I think may be a problem in the transport-helper code.

I'm not 100% the current remote-helper code allows that, since there
might be some interaction where the transport-helper code needs to
read from the helper before closing the connection. I don't think
that's the case, but I'm not sure of it either.

> I gave up in frustration after many hours of dealing with it on Friday,
> but I'll give it another go today. :)

Sounds familiar.

-- 
Cheers,

Sverre Rabbelier
