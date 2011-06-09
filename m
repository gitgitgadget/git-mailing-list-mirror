From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 4/8] t5800: document some non-functional parts of remote helpers
Date: Thu, 9 Jun 2011 08:20:48 +0200
Message-ID: <BANLkTin+QFm7WrTbQ5q90=WRxXVtHcBekg@mail.gmail.com>
References: <20110607171838.GA21685@sigill.intra.peff.net> <20110607172030.GC22111@sigill.intra.peff.net>
 <7vk4cv29oe.fsf@alter.siamese.dyndns.org> <20110609001150.GA19715@sigill.intra.peff.net>
 <7vzklrzvfb.fsf@alter.siamese.dyndns.org> <20110609004555.GD19715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 08:21:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUYcZ-00064l-DS
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 08:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924Ab1FIGVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 02:21:30 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57759 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab1FIGVa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 02:21:30 -0400
Received: by qwk3 with SMTP id 3so562688qwk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 23:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=5Hh26CU9gdaUPzJT4IhHqUZbcBms5F6G9HPslKVQ2d4=;
        b=nZ6mNpm2HqTdY8CAhngB9u6ZZ0W0TTWwBL9dPbanlZwEcW7m5SrhKTSaK18hZ/XpgF
         Xm7eH/tZ/WWW21e+tU60tHgU7HHL7o9Re8C1q9bwdSPQaC3a4F3Ak3QE9Rf2TsJzpfMW
         0aPj/bBWKFfGUMybiwpQZ/kJSRWn8DbwmjHsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Gkx0kdQzKG2WUbXeA8Xzy8qSUsf4gxCZpNA9SgFy3KLczWiY+RyFF7IplsG8s8a5J8
         Swx0t2B3AokLheRtrNu1p4Ou/fazM1IWJd6aZLaMxVev1QqeSRZD/w8cO+fGLMB6UzPR
         3xUd5JarVxbYLQo5iWHu7QROqzkfQUMGhvPww=
Received: by 10.229.127.105 with SMTP id f41mr254460qcs.15.1307600489161; Wed,
 08 Jun 2011 23:21:29 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Wed, 8 Jun 2011 23:20:48 -0700 (PDT)
In-Reply-To: <20110609004555.GD19715@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175491>

Heya,

On Thu, Jun 9, 2011 at 02:45, Jeff King <peff@peff.net> wrote:
> Fair enough. I think a better wording would be "...the upstream has refs
> that we do not have locally", which is more accurate and more clear.

Fixed locally. Although, this probably needs a new commit message anyway.

-- 
Cheers,

Sverre Rabbelier
