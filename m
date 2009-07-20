From: Woody Gilk <woody.gilk@kohanaphp.com>
Subject: git-archive and submodules
Date: Mon, 20 Jul 2009 11:22:32 -0500
Message-ID: <41ceb5540907200922r5decb047h75e723a1809b587e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 18:22:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSvdR-0000iD-RX
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 18:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbZGTQWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 12:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbZGTQWd
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 12:22:33 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:46306 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbZGTQWd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 12:22:33 -0400
Received: by qw-out-2122.google.com with SMTP id 8so894488qwh.37
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=ZqkCWJccsejwWihRF2TVfH8mW0pzK+nKSvPi3tn96lc=;
        b=BxSleRxJhecgvlQDcZmn43ABAnSvxpRiWQtPJXUDeVvkXlgCLv/Ge6CGGoxjf243ga
         Pftgv2kxOJr0bAy0V9ntNszf/vBhysRzn5Xwees9NMLqWuMrgONojw2IHl30sbskJERW
         zTQNboq9jTgJvBDEJcR/uhJscIpPHR66Vusgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=msTPi9WX3xZwBCp/cJNlmYDrI1HCdLY/zFMVDT5sz42wEKkL7ZgQIUmb8Uw5yP6yZ0
         Ia2FggHLIS4By5Fa58DR4TzoecRSak5XtU+gS5IH3ZcedDvmDtXyV5rsCfup/xx8bEEU
         oCsVXdd4ZbZASo5lpZERejGT/e6KsdBZ2Ekhg=
Received: by 10.229.91.12 with SMTP id k12mr796437qcm.66.1248106952794; Mon, 
	20 Jul 2009 09:22:32 -0700 (PDT)
X-Google-Sender-Auth: 932477308679952b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123620>

(Please note that I am not subscribed to the mailing list, so if you
want me to read your reply, it must be sent to
woody.gilk@kohanaphp.com)

I would find it hugely valuable if git-archive would support
submodules, rather than leaving empty files in the place of
submodules. Supporting submodules is critical to packaging releases
(combined with signed tags). With git-archive not support submodules,
it means that I have to manually package and sign each release, rather
than using git-tag.

This seems like it should be a fairly trivial thing to support,
possibly with the addition of a --with-submodules parameter for
git-archive to avoid backwards compatibility issues.

Thank you,
-Woody Gilk
Lead Developer of Kohana PHP Framework
