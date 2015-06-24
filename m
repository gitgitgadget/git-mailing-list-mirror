From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/5] Bisect terms
Date: Wed, 24 Jun 2015 12:41:36 -0700
Message-ID: <xmqq616cao7j.fsf@gitster.dls.corp.google.com>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435159062-23468-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 24 21:41:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qYJ-00088C-Qg
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbbFXTlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:41:39 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36436 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbbFXTli (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 15:41:38 -0400
Received: by igbiq7 with SMTP id iq7so104527487igb.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 12:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Svxfoc5v3fHcniGlUQQ7PRabbkA8T4AVwkbeROsgrms=;
        b=m38Fxi0jPpba9XExTEbY3Rpf0c5X1AybXt1B4nLqear5UrBTCXblS37Rq1aZ24+cDk
         9kqgs61oKBLflg4/eivvbfUIAEKJuzqiZe4oIrSv4JMX7JDBHRYdnhfcOOzn1sqKQi76
         l5xSlPoj1QUGcVMKyLHSvRhnajDtm5NXz9l9OM86y1k+1cxAOLIwJ6t9rvBBKtberAEc
         ouXiewj2vcfTRqhti36xFI74Hiu4I2rxvlFGRV/6jNZ+omYAg4f7a7ns9AovtfYlCfxT
         pSmYZUFrKNhcR4+/HwXF8xBXhvQ8XJJ/VCwlsPTnMXQh03WTG7HGNTn+Nbyh6ojIkWLD
         bQgg==
X-Received: by 10.107.154.70 with SMTP id c67mr54165981ioe.22.1435174898221;
        Wed, 24 Jun 2015 12:41:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1c05:dbc5:2f2f:d033])
        by mx.google.com with ESMTPSA id d4sm17963335iod.17.2015.06.24.12.41.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jun 2015 12:41:37 -0700 (PDT)
In-Reply-To: <1435159062-23468-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Wed, 24 Jun 2015 17:17:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272589>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

>  Documentation/git-bisect.txt |  67 +++++++++++++-
>  bisect.c                     |  94 +++++++++++++++-----
>  git-bisect.sh                | 207 +++++++++++++++++++++++++++++++++++--------
>  revision.c                   |  20 ++++-
>  t/t6030-bisect-porcelain.sh  |  83 ++++++++++++++++-
>  5 files changed, 407 insertions(+), 64 deletions(-)
>  mode change 100755 => 100644 git-bisect.sh

How come nobody noticed this last line so far, during the 7 rounds
of reviews?

I'll locally fix it up so no need to resend.

Thanks.
