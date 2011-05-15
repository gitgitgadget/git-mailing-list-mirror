From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #06; Fri, 13)
Date: Sun, 15 May 2011 11:51:00 +0700
Message-ID: <BANLkTi=TW=8_-Vrh=h1LekPTFzQOzZj-iw@mail.gmail.com>
References: <7vd3jm74gv.fsf@alter.siamese.dyndns.org> <BANLkTimHdZ_9PUg509Yb7g2Oyp3qk0cKdA@mail.gmail.com>
 <7vsjsh5gjw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 06:59:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLTQ2-0003na-A6
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 06:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396Ab1EOEvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 00:51:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42793 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab1EOEvb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 00:51:31 -0400
Received: by bwz15 with SMTP id 15so2990870bwz.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 21:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=oR9h6cRrGFnS5KPHNAod4V07z1SiLCb5G7bozPDWMro=;
        b=Zauyy2aKK3pKL3B0G+Q0n4lR7XJgPYDviZbC15g7+VDO/GJMOueW0U4JrgfAhtNEmP
         s6/kaM5KavIMIQTpgaXgwKbfYw2u/uT+nUZZpiSciTipvnVTQQCsU0wvn69fphe8ku/P
         eU37BnH55f2+K5ZAiUYUswQ4/1C4wFRJq5o70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XZE0z9Hqkv3x1eeM520MrCZlAiJ+TGJQg29JcVimyY0FeG7Wee+2z1ydYSd1QSwqDE
         h3kWVyL6dVUwMqw9cPxgK3+hzTvwfdHqjJ03SIbdi9FkVbTjHyU4SOTd4Ggh59so72rJ
         4lxlWK1LPgQaOjyu2hkYS2pwcNEGzkBTj7QkM=
Received: by 10.204.7.213 with SMTP id e21mr2730011bke.209.1305435090110; Sat,
 14 May 2011 21:51:30 -0700 (PDT)
Received: by 10.204.177.147 with HTTP; Sat, 14 May 2011 21:51:00 -0700 (PDT)
In-Reply-To: <7vsjsh5gjw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173620>

On Sun, May 15, 2011 at 12:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The sending side of "git push" (aka "send-pack") and "git fetch" (aka
> "upload-pack") should also be Ok because pack-objects has known to handle
> large blob in a pack by copying the bits straight without re-deltifying.

Sending a lot increases chance of unexpected disconnecting. But that's
not the focus now.

> I however think the receiving end still wants to hold everything in core.
> It would be the natural next thing to fix around this area before doing
> anything else. If somebody is interested, look at the receiving end
> ("index-pack" and "unpack-objects") while I am still busy in this topic.

I looked at index-pack before. Will see how to fix it (that is if I'm
not busy with pathspec stuff)
-- 
Duy
