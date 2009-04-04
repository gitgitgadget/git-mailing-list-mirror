From: Dan McGee <dpmcgee@gmail.com>
Subject: git send-email prompting too much
Date: Sat, 4 Apr 2009 12:02:45 -0500
Message-ID: <449c10960904041002s22124b74k8440af216b1de9ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 19:04:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq9Ie-0007nH-2D
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 19:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbZDDRCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 13:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbZDDRCu
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 13:02:50 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:62473 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbZDDRCt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 13:02:49 -0400
Received: by ewy9 with SMTP id 9so1361982ewy.37
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=tYlu9RR4+36PAICygJFMyWoXDtokRpmTnGB6sim5uTo=;
        b=WMStdTG/Z2Ijmgsc5bQKXDNFpuoQUiN2wiFFeASmKgTPGXK3Zx8o20QmO+0z93TVIU
         5zsk3hpHPonKxWyoPXIqJC5ysVOUJ1MtJ2wjMMMAayGMgD7fQ/OVLV2hx7e1kEGEGqb7
         letVgQU2xiiXUgeIx2gfOR4QF7RLKo7bULINk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=PPKFyBhlIe8D94ZUfs1Qv4YMTjPNfNqmCjJnsAtlKsn+2DtZi3OBmenWltL4kc222I
         CtDfH0vlwlwqliuq4EQeBAXu6NP/nl3YClNSAqflP0JjC2MCUjDvZyYzHzUQdkv1hO8v
         krmSPzOyRKjmol4FV8iDDVOIUV5lq8PwpByVk=
Received: by 10.216.11.138 with SMTP id 10mr747875wex.51.1238864565143; Sat, 
	04 Apr 2009 10:02:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115588>

I'm guessing this is related to commit
6e1825186bd052fc1f77b7c8c9a31fbb9a67d90c but I haven't bisected yet.
Having to hit enter 10 times ad the Message-ID prompt seemed a bit odd
to me. Has anyone else seen this behavior?

dmcgee@galway ~/projects/git (working)
$ git send-email 000*
0001-git-repack-use-non-dashed-update-server-info.patch
0002-pack-objects-report-actual-number-of-threads-to-be.patch
Who should the emails appear to be from? [Dan McGee <dpmcgee@gmail.com>]
Emails will be sent from: Dan McGee <dpmcgee@gmail.com>
Message-ID to be used as In-Reply-To for the first email?
Message-ID to be used as In-Reply-To for the first email?
Message-ID to be used as In-Reply-To for the first email?
Message-ID to be used as In-Reply-To for the first email?
Message-ID to be used as In-Reply-To for the first email?
Message-ID to be used as In-Reply-To for the first email?
Message-ID to be used as In-Reply-To for the first email?
Message-ID to be used as In-Reply-To for the first email?
Message-ID to be used as In-Reply-To for the first email?
Message-ID to be used as In-Reply-To for the first email?
(mbox) Adding cc: Dan McGee <dpmcgee@gmail.com> from line 'From: Dan
McGee <dpmcgee@gmail.com>'
(body) Adding cc: Dan McGee <dpmcgee@gmail.com> from line
'Signed-off-by: Dan McGee <dpmcgee@gmail.com>'

From: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
Cc: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 1/2] git-repack: use non-dashed update-server-info
Date: Sat,  4 Apr 2009 11:59:55 -0500
Message-Id: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com>
X-Mailer: git-send-email 1.6.2.2.404.ge96f3.dirty

    The Cc list above has been expanded by additional
    addresses found in the patch commit message. By default
    send-email prompts before sending whenever this occurs.
    This behavior is controlled by the sendemail.confirm
    configuration setting.

    For additional information, run 'git send-email --help'.
    To retain the current behavior, but squelch this message,
    run 'git config --global sendemail.confirm auto'.

Send this email? ([y]es|[n]o|[q]uit|[a]ll): a
OK. Log says:
Sendmail: /usr/bin/msmtp -i git@vger.kernel.org dpmcgee@gmail.com
From: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
Cc: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 1/2] git-repack: use non-dashed update-server-info
Date: Sat,  4 Apr 2009 11:59:55 -0500
Message-Id: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com>
X-Mailer: git-send-email 1.6.2.2.404.ge96f3.dirty

Result: OK
(mbox) Adding cc: Dan McGee <dpmcgee@gmail.com> from line 'From: Dan
McGee <dpmcgee@gmail.com>'
(body) Adding cc: Dan McGee <dpmcgee@gmail.com> from line
'Signed-off-by: Dan McGee <dpmcgee@gmail.com>'
OK. Log says:
Sendmail: /usr/bin/msmtp -i git@vger.kernel.org dpmcgee@gmail.com
From: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
Cc: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 2/2] pack-objects: report actual number of threads to be used
Date: Sat,  4 Apr 2009 11:59:56 -0500
Message-Id: <1238864396-8964-2-git-send-email-dpmcgee@gmail.com>
X-Mailer: git-send-email 1.6.2.2.404.ge96f3.dirty
In-Reply-To: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com>
References: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com>

Result: OK
