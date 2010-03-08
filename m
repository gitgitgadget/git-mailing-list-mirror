From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: Re: [PATCH] pull --all: fix error message when current branch is not 
	tracking remote branch
Date: Mon, 8 Mar 2010 23:26:32 +0300
Message-ID: <63cde7731003081226hb27c705l9038f2dccfd1c042@mail.gmail.com>
References: <1267566741-5784-1-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 08 21:26:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NojXD-0004v9-0h
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 21:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457Ab0CHU0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 15:26:35 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:62158 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab0CHU0d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 15:26:33 -0500
Received: by wwa36 with SMTP id 36so3548650wwa.19
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 12:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=xkwodgEbPFm7g+MWIR63ML6kpmpnuAfW4Q0P9RPV1Xk=;
        b=Aa3drim21bTrBqw7GJsxRcE+gI9apLEfpRDQvVxS2OKnA5LR3hi4jZw9r4wf5XPNLj
         yCc9IuUzSRQOO0eDoRdoRNeVNaRIwG3alyqy0+zTrRZH2WVFwrbJZWuOnCHLl7283HzC
         uLFtSmT0gAWLGj8yOjDoNgtCmy3mrFc94bMSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LfPSivfRXJ3/BgyLhSjYV2bWzM+src/JiWj/DBuSags/7TduVDqtK6ZnZQDsKtIe9Q
         syZuUfV4jv9/PNtSdLOZry9TigL6gbXm940n1yl5V/jkIBmGOpTQU11F7pNS7dhsM7Gs
         CmVIw7ryKoKJSmQJg4/55F4omiqu+9X8lLt18=
Received: by 10.216.88.134 with SMTP id a6mr857874wef.66.1268079992323; Mon, 
	08 Mar 2010 12:26:32 -0800 (PST)
In-Reply-To: <1267566741-5784-1-git-send-email-michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141785>

No-one ever interested?
Thought it's useful improvement.

Instead of above-mentioned confusing message, you get
much more clearer explanation:

You asked me to pull without telling me which branch you
want to merge with, and 'branch.<>.merge' in
your configuration file does not tell me, either. Please
specify which branch you want to use on the command line and
try again (e.g. 'git pull <repository> <refspec>').
See git-pull(1) for details.

...
