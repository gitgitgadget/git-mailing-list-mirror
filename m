From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: format-patch on permission change gives empty patch
Date: Thu, 7 Oct 2010 12:12:38 +0200
Message-ID: <AANLkTik=3bT3h3tCsm3nAdi=VbwJsY0+33HPpF0_m36X@mail.gmail.com>
References: <20101006.173714.245380201.davem@davemloft.net>
 <20101006.174008.70175671.davem@davemloft.net> <7vtykyy70w.fsf@alter.siamese.dyndns.org>
 <7vocb6y5sq.fsf@alter.siamese.dyndns.org> <AANLkTimA4jrDXmfJp2em34fj6b1sj9kdEyZ_xPTzqcEN@mail.gmail.com>
 <m3eic2fher.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Miller <davem@davemloft.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 12:13:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3nTg-0005tp-Gw
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 12:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab0JGKND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 06:13:03 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47796 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab0JGKNB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 06:13:01 -0400
Received: by gxk9 with SMTP id 9so208562gxk.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 03:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=KFkYFisxVCrgdLYJyZYd8kJfsbCSOQHhs7fwnz+zEZo=;
        b=K+89TLaxY79QWx6rjGwfkaqw1kaUwebpNR5wtzo/NkqcKxpMfCKeYgc+vt3jhN40ND
         PR4jrDBoYMxpGeYYAquTB+z33SK4lWmLVSl3uGReAO9h5TP4tVWOIVGCit0fo93OhO2r
         bSxfctDHO7NtEN2QxU7W4nnHLgtJm5wJW9Z8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=uKqpyQVlMJ47hRTFqJtPpm/5rf+//4oxuWDu5Ml2jeAOnhi0BcJdnWHStgnv7+oiWy
         g3OATV1dKvxsdTJG5wN3EObhOMiB53vqd0Gag5+idHPzggCWkcyBYirlqXY88WUSdjCP
         mGsFgyDrXAX3LhoqtdQUd+yARpGPZ06vnYFSU=
Received: by 10.151.41.17 with SMTP id t17mr750115ybj.443.1286446379866; Thu,
 07 Oct 2010 03:12:59 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Thu, 7 Oct 2010 03:12:38 -0700 (PDT)
In-Reply-To: <m3eic2fher.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158393>

Heya,

On Thu, Oct 7, 2010 at 12:05, Jakub Narebski <jnareb@gmail.com> wrote:
> Hmmm... doesn't rebase pipeline use "format-patch --rebasing" (where
> '--rebasing' is internal option deliberately left undocumented)?

If so, that's exactly what I mean :)

-- 
Cheers,

Sverre Rabbelier
