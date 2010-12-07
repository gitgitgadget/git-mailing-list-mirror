From: Thiago Farina <tfransosi@gmail.com>
Subject: cmd_cherry in builtin/log.c?
Date: Tue, 7 Dec 2010 14:02:36 -0200
Message-ID: <AANLkTikXmc-3BBkxy-D8GNLAMXUOPghp78GpStZ-_wBW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: rene.scharfe@lsrfire.ath.cx
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 07 17:02:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ004-0002k5-Rk
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 17:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab0LGQCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 11:02:39 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:62752 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307Ab0LGQCi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 11:02:38 -0500
Received: by bwz16 with SMTP id 16so178604bwz.4
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 08:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=CBGszJw11gwGktcFIue2j4tndGOGHnuofZQYr/EHgoQ=;
        b=klKYSN3hE/st5gLU50AwVhXfGl40DAuzy1xJDmhNofNJ3UhUxxbiab+f6yf9ZRsO04
         o0BOuDlHD3Toz/2QnphIQTAtFxARag1VDs9SdQuoWP3knrO4/5XQF8If9NKg1xnt4ETj
         VZByzpBhjjuCzjCv+2FaBluo2X538oT/SQl4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=pRW4PojeyQuh8Yu7nmO3nHm+iFoALtJ1ks7XnqrZ+kKnmNKFYp3UoSEMka+PJ/lADT
         2oyO0CHtMcb7ynpesHrMnw1mO9GYdXmj/a+G0UdiJCgkieF4BKmEN6wY5lBmTG+bJ2Ap
         tjIXvn1zczfarGLJ/c90hgbRI78qgYiVWLgA8=
Received: by 10.204.118.138 with SMTP id v10mr587965bkq.94.1291737756862; Tue,
 07 Dec 2010 08:02:36 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Tue, 7 Dec 2010 08:02:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163081>

I was looking into builtin/log.c to see how it does --reverse and I
saw that cmd_cherry is there.

I'm wondering, why is it there? What was the reason to make the
decision to put it there and not in builtin/cherry.c?
