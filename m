From: Valentin QUEQUET <valentin.quequet@gmail.com>
Subject: Fwd: GIT - cloning torvalds/linux-2.6.git repository trouble.
Date: Sat, 5 Feb 2011 18:45:42 +0000
Message-ID: <AANLkTi=FAWh9T3HaocdKB7V4osRPsehTo=hTP0U-JbfR@mail.gmail.com>
References: <AANLkTikiKagzJMh_xuOSzfA4c-qxOHhVeU2jhmbaDHji@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 19:45:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pln8n-0008CK-Ey
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 19:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab1BESpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 13:45:44 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55971 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab1BESpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 13:45:43 -0500
Received: by iyj8 with SMTP id 8so822519iyj.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 10:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=WFVhZtp0X+CXrboa6CJByjs5Tp5OzmSxTZxWyi5Gtv0=;
        b=X+qp7OgT5B+cOZYlbj4UzJFUrpDy1ot+d02rT4E1j9Ze8qZtR6sEG9EgPQJbphCizj
         NuhfJ3E8QILCQXdAPGD3zpU9/iQrCw7LlcmGGSKMW9p+5IZwUHbROniwJTsgpJJx8EYf
         LlnMGjWi0cSUParseCQwwtEZ+wojrmU2vkrHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=nynbO2wAZoCflwKJWH8NPdXe0MGRDA77HKl3QIJQWvrIq5j4AYZDYDvGrs+aBUjSkB
         ZdYK46iACFyZZ/huIfkljWpTbxJ+/AseRtpktM9Ly8fnlfzyRpsKMOX+hvdH3vQV5/Kz
         x10j1bUNUBh67FrP4GrkcSIBE6aBe0XNT7Jjw=
Received: by 10.42.174.72 with SMTP id u8mr1459004icz.477.1296931542877; Sat,
 05 Feb 2011 10:45:42 -0800 (PST)
Received: by 10.42.135.7 with HTTP; Sat, 5 Feb 2011 10:45:42 -0800 (PST)
In-Reply-To: <AANLkTikiKagzJMh_xuOSzfA4c-qxOHhVeU2jhmbaDHji@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166109>

---------- Forwarded message ----------
From: Valentin QUEQUET <valentin.quequet@gmail.com>
Date: Sat, 5 Feb 2011 18:17:57 +0000
Subject: GIT - cloning torvalds/linux-2.6.git repository trouble.
To: linux-kernel@vger.kernel.org

Hi Dear Linux enthusiasts,

I recently (yesterday) began to fetch (clone, fetch, ...) the current
  Linux GIT repository:
    http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

I first failed to fetch it through any protocol ( git:// , http:// , https:// )
  because of my UNRELIABLE WiFi connexion.

I eventually managed to download the following file :

http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/heads/master
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/info/packs

http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-0b38509807589c455b1c769368348bd845441959.idx
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-c53d2db50f885f3803a3afd46484b54c06b1433e.idx
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-910f14bdd726702c46cfd622ee40fcaf4881a5ec.idx
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-81315ef1065b534c70a409978aa11daf2e27fdb5.idx
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-83898168fc5bce601472bd3260cd6b08f5f4f7b2.idx
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-7ff1ea46fec7532e88a900a9a1340794fb3ffa3f.idx
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-221cb4abe6bb3165bf062219200020148b83948b.idx
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-6576226aba312e2a3b610665e35cfc466f980c55.idx
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-0ab67efdf76cff54cd9fa5166d1df19c8edf685a.idx
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-0b7fc86700a243d2ea341c04926c4425fe85fd26.idx
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-fb3e46067bf5b97b6b49dbda9cda51cf3ef3b660.idx
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-04fb51824d013a5fbac892f95369d92daf60f195.idx
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-76001124ed6335482ee1cea785f93426ab278417.idx

http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-0b38509807589c455b1c769368348bd845441959.pack
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-c53d2db50f885f3803a3afd46484b54c06b1433e.pack
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-910f14bdd726702c46cfd622ee40fcaf4881a5ec.pack
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-81315ef1065b534c70a409978aa11daf2e27fdb5.pack
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-83898168fc5bce601472bd3260cd6b08f5f4f7b2.pack
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-7ff1ea46fec7532e88a900a9a1340794fb3ffa3f.pack
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-221cb4abe6bb3165bf062219200020148b83948b.pack
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-6576226aba312e2a3b610665e35cfc466f980c55.pack
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-0ab67efdf76cff54cd9fa5166d1df19c8edf685a.pack
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-0b7fc86700a243d2ea341c04926c4425fe85fd26.pack
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-fb3e46067bf5b97b6b49dbda9cda51cf3ef3b660.pack
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-04fb51824d013a5fbac892f95369d92daf60f195.pack
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-76001124ed6335482ee1cea785f93426ab278417.pack

And all these .pack and .idx files appear to be valid ones, with
respect to the "git verify-pack" command.

This set of files seems to be consistent with the current state (by that time)
  of the Linux git repository (torvalds/linux-2.6.git)

Now, I would like YOU to tell ME how I can checkout from the PACKs
I've just downloaded.

How may I populate the working directory , objects/xy/... , refs/... ,
... hierarchies to
  make my (local) repository usable.

I suspect I shall find this information in documentation related to
the "git fetch" command,
  but I haven't managed to get it right.

Your HELP is very welcome.


If you prefer not to pollute LKML, you may choose to aswer me at:

  valentin.quequet@gmail.com


Thanks in advance,

Valentin
