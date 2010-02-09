From: Jay Soffian <jaysoffian@gmail.com>
Subject: blame -L questions
Date: Mon, 8 Feb 2010 22:03:37 -0500
Message-ID: <76718491002081903s2e37875bs85eeb55779167ce7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 04:03:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NegO7-0002hA-L8
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 04:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab0BIDDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 22:03:38 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:60396 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab0BIDDh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 22:03:37 -0500
Received: by iwn12 with SMTP id 12so8107560iwn.26
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 19:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=1h+PUT76mViVMfx9QiABsr+WCdr30inLm9G/R07nRQw=;
        b=HCTrq4eg9z8rUmDatcqhrzpQ/MYGdUoqvtTGtAnn9d3bkkRpe6+qXlZuDp8v7dKFZz
         ZplIBnILTGPMBNht725VZF4XaKeNLIVCww2K34zUk7TpiGXqEe9LgAU0bFz6Jgyk5C2k
         L4UdTQBwjwfvxKmMVZ+sENujCMkiPWz2Phi9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=am6HIVA0pWUec8IFEa/oMopiyJzGDddHQ5OnC41mH1xBUQvz4gPlAVgZjYArrUta+L
         psEruZfDr9bnqWvS3BdGoSOun7/9fRCAofS35WzH/kx1CmV00SGLw/V7NVfXKaiFIAYN
         cxJIVA5hpLiQisI+CLi3ZkgMoUhaAptEmbU1U=
Received: by 10.231.150.2 with SMTP id w2mr2346155ibv.90.1265684617071; Mon, 
	08 Feb 2010 19:03:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139351>

Junio,

I'd like git blame to be able to emit multiple blocks when using it
with -L /start/,/end/.

My use case is emitting blocks that are wrapped in

#if defined(WHATEVER)
....
#endif

I was going to use the syntax -L /start/../end/ for this.

I naively thought I might just be able to setup multiple blame_entry's
linked through the next/prev pointers at the start, but that clearly
does not work.

So I was wondering if you could give me any tips about how the
scoreboard, blame_entry, and origin all fit together before I injure
myself. :-)

Thanks,

j.
