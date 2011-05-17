From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Is there a debug mode for git-clone https traffic?
Date: Wed, 18 May 2011 01:08:06 +0200
Message-ID: <BANLkTi=-i063MqrboT1MHrQy-vM0yBTUGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 18 01:08:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMTN8-0003JC-CA
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 01:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584Ab1EQXIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 19:08:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48183 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932553Ab1EQXIH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 19:08:07 -0400
Received: by fxm17 with SMTP id 17so804104fxm.19
        for <git@vger.kernel.org>; Tue, 17 May 2011 16:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=hwKyqwhmFc/xKTIAkN9PVsrdkjXmzXPv7L6Try4wyKM=;
        b=sNuVOU0hJI5gM+JyLTGaT5ICYNHXowuJqhvf4nczN3t+CxdryfDjtYi3TedUQncaJJ
         FT6MVOMY/vjLeF6m/Pfw1HLyOtzA+v6INsDtHVz7jCb5xdUljaI5gcnjdYKLIYO82IzA
         dXN7oN5erOBM0FqabX3zG6qksQfJ04JWYtuKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=NoQrq463MHlKUoljQ9UEpOqY3OPUrCfEGC8GiYr+ES+CnV7x6UKcl2s+DnTAiLdPBQ
         dWs1xn4qSi9qQrkLrQc4TW24DOlqqqoQdhHmTcBImnOe38hnthB/xp/HZOgmiKluiPaj
         nRtkRo4H8+H/JfT8qglmA8Fdz2tIeIfghRUQI=
Received: by 10.223.59.81 with SMTP id k17mr1492067fah.94.1305673686535; Tue,
 17 May 2011 16:08:06 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Tue, 17 May 2011 16:08:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173831>

I''m trying to debug a problem where over a https proxy I have
"warning: remote HEAD refers to nonexistent ref, unable to checkout."
when doing git-clone.

I suspect that it might be an overzealous security scanner sitting in
the middle.

Is there some debugging mode for git-clone where it'll dump the
traffic being sent over the wire that I could use to confirm this?
