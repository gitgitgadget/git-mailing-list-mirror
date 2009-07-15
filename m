From: Ondrej Certik <ondrej@certik.cz>
Subject: mailmap distinguishing names
Date: Wed, 15 Jul 2009 16:22:08 -0600
Message-ID: <85b5c3130907151522x1009a796tced7726d9be4ca7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 16 00:22:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRCri-0008Vy-Ep
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 00:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457AbZGOWWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 18:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755324AbZGOWWK
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 18:22:10 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:61194 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbZGOWWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 18:22:09 -0400
Received: by gxk9 with SMTP id 9so2769067gxk.13
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=GoyMF83JmuY+yOzaqL3QOgymY/XVl4wRLuXqaem7cIU=;
        b=sgAq9FF1V19e2+jlwNB/N1WEVjM5cipZ5+Y2UDt/fU9L6ErS/0EwPSSh0ailJgBm6l
         wyQQrqNA4FWug7hyakFqNIjwtW2GqtqxgX1w5L1V4V4lNC7QkLgc01Rw5kJyhVuWUNAI
         w7tMTncX0nQzIQd8lJwPIS/ZndAVXVmepGlnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=D8yIc+yeD2bNWfQAK5K5TPfcLCDgOhWqcqk4ZTTPBgJVbwn4OfhRsvAb4SGeBk2qig
         6LbsIzTsiTlfPT0Yu3tRXZwzcE13UAPV1hpvYdIm5b4eOrKFBZW1DMN10EYcUR4s/tUH
         nia9ME9Q1oDhIVQTCEhubLy9vSk8CiKadutFI=
Received: by 10.90.29.13 with SMTP id c13mr4645369agc.82.1247696528181; Wed, 
	15 Jul 2009 15:22:08 -0700 (PDT)
X-Google-Sender-Auth: fe2092faa27980c9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123339>

Hi,

I know how to use mailmap to map names to email addresses, however,
what if we have some old commits that look like:

commit 1815ccf8ea8a7d99736d9b15c10d2ddf41162faf
Author: ondrej.certik <devnull@localhost>
Date:   Sat Oct 6 01:57:03 2007 +0000

    test for a series bug 364 added, but XFAILed, because sometimes it works, so

commit ef95d618e1fda2dc6b50a0edf343a7b321467527
Author: kirill.smelkov <devnull@localhost>
Date:   Fri Oct 5 20:10:04 2007 +0000

    pprint: add support for multile indexes in unicode mode

commit 7e74ebdf2701f0ab213a6e5ba47b7860fcf90cff
Author: fredrik.johansson <devnull@localhost>
Date:   Fri Oct 5 16:41:04 2007 +0000

    add abc module



E.g. for some reason the addresses are <devnull@localhost>, but the
names are correct (svn names). Then "git shortlog -ns" shows things
like:

   654  Ondrej Certik
   322  Kirill Smelkov
   268  ondrej.certik
   208  Mateusz Paprocki
    74  fredrik.johansson

is there some way to join "ondrej.certik" with "Ondrej Certik"? If the
email address for ondrej.certik was some better one, it'd be easy, but
since it's the same for all the old committers, maybe the only way is
to rewrite our history and fix this. But I just wanted to check if
there is some other way too.

Thanks,
Ondrej
