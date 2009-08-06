From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Thu, 6 Aug 2009 20:49:29 +0200
Message-ID: <40aa078e0908061149s3d08bcc5qbd86bfa4e5624006@mail.gmail.com>
References: <20090805181755.22765.qmail@science.horizon.com>
	 <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain>
	 <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain>
	 <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: George Spelvin <linux@horizon.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 20:49:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ820-0007v7-1Z
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 20:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbZHFStb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 14:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbZHFSta
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 14:49:30 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:52366 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbZHFSta (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 14:49:30 -0400
Received: by bwz9 with SMTP id 9so954077bwz.41
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 11:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0UpsrIopZQ+D0ni3bThUpVYC8/3g97D+qb0RcRcLESA=;
        b=cnrZM3vfKZanFbaMfl0PaLA/etzRJC/BIRuDXezR5R+NR79mia/nvhv2vSbh5xPltn
         WKpPedA0pQOStwyDoPN0QnYPYA2mlP01QN6bTXmqC5KgVsFG3yF+FIEkqkuNqzkMWk2P
         6CGUjDThajquTh/lwYdg4/Cby0x5ErqhjvkdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P9byCJknmGJgM0Pn2AzJBEkjjJmYss1+QPzPuUHemUC/nRW7Sajvr8am7kokoy7/XU
         YXvAgJuaeOJwwY9FREr/h1c2K/aSUGXiiSFOxiSM2FlxCBQSAm1q3fYZjbeLjmzbXAy9
         jFs70Fpfj7FjkRkTiGVRn1b00y90doMKPYwW4=
Received: by 10.204.71.135 with SMTP id h7mr1119640bkj.168.1249584569758; Thu, 
	06 Aug 2009 11:49:29 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125105>

On Thu, Aug 6, 2009 at 3:18 AM, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
> I note that MINGW does NO_OPENSSL by default, for example, and maybe the
> MINGW people want to test the patch out and enable BLK_SHA1 rather than
> the original Mozilla one.

We recently got OpenSSL in msysgit. The NO_OPENSSL-switch hasn't been
flipped yet, though. (We did OpenSSL to get https-support in cURL...)

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
