From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Git's translations need to be updated for submission
Date: Wed, 6 Jul 2011 21:34:27 +0200
Message-ID: <CACBZZX4dP-OsrZ3wBOeSkzDFy6XBgeY=eqJUF2acyLC8W-3Vpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jan Engelhardt <jengelh@medozas.de>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?Q?Marcin_Cie=C5=9Blak?= <saper@saper.info>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Reed <sam@reedyboy.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 21:34:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeXrs-0007Co-FC
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 21:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951Ab1GFTea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 15:34:30 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:37058 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235Ab1GFTe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 15:34:29 -0400
Received: by fxd18 with SMTP id 18so375626fxd.11
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 12:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=JT2QPos7a/AzakfIjcp6aqe3XWj5yOB6eqDlvk+ReOU=;
        b=FdHfX/n8Nk9So6MihHevEuJZNsv8MUipNBlv8w8Y18gAhGvRosQZSxFadmzIltZJRg
         5/1zIeI1ByJlRsNqsH45zDzaeIRafquxtiLJwN+ERqtgYK8F9kwclo/rKUkOsvIQromk
         KAcIiqLQwKzUB0AM7va7BgfcR5kWfsyftl1T0=
Received: by 10.223.32.142 with SMTP id c14mr13395774fad.59.1309980867764;
 Wed, 06 Jul 2011 12:34:27 -0700 (PDT)
Received: by 10.223.114.208 with HTTP; Wed, 6 Jul 2011 12:34:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176726>

I was going to submit Git's po/*.po files from the i18n branch but I
found that while everything else has been cooking they've become out
of date:

    $ parallel -v -k 'msgfmt --statistics {}' ::: *.po
    msgfmt --statistics de.po
    622 translated messages, 58 fuzzy translations, 21 untranslated messages.
    msgfmt --statistics en_GB.po
    3 translated messages, 698 untranslated messages.
    msgfmt --statistics hi.po
    14 translated messages, 45 fuzzy translations, 642 untranslated messages.
    msgfmt --statistics is.po
    24 translated messages, 36 fuzzy translations, 641 untranslated messages.
    msgfmt --statistics pl.po
    24 translated messages, 46 fuzzy translations, 631 untranslated messages.
    msgfmt --statistics sv.po
    531 translated messages, 80 fuzzy translations, 90 untranslated messages.

In particular the fuzzy translations have to be fixed (in some cases
they're completely wrong), and it would be nice to have the
untranslated messages translated.

The files can be retrieved from the ab/i18n-po branch of
git://github.com/avar/git.git:

    https://github.com/avar/git/tree/ab%2Fi18n-po/po

Submissions to this mailing list or via GitHub pull request (better)
are welcome. Once these are fixed up I can submit these to the list.
