From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] prompt: introduce GIT_PS1_STATESEPARATOR
Date: Thu, 16 May 2013 17:42:08 +0530
Message-ID: <CALkWK0m7=A0rRj3NzMorGjgSqbfqQow+etbH0v0wrtSRW33tnQ@mail.gmail.com>
References: <1368452958-31090-1-git-send-email-artagnon@gmail.com>
 <1368452958-31090-2-git-send-email-artagnon@gmail.com> <7vli7ioqzx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 14:12:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucx3F-0001g7-4K
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 14:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058Ab3EPMMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 08:12:49 -0400
Received: from mail-ia0-f171.google.com ([209.85.210.171]:46465 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab3EPMMs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 08:12:48 -0400
Received: by mail-ia0-f171.google.com with SMTP id k10so1853355iag.2
        for <git@vger.kernel.org>; Thu, 16 May 2013 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=iUHkc+0B8eNvPxlgcYW17BaVSL0lvfKQS2Eit7gNDgA=;
        b=UIOhsp20yMjCQRq5vuQfW0wvIILp2bGbK70kXL1lrNV5ZBRGISqWKM73erASVmNGda
         BuNRPHymYYJAR9yiKMMOSo0tWEmICeVuMwYYqv3W2Q+lrgYeXT01OhbTQUhbA4qa9DJG
         AiPXFh1hWBWLphDKHDcqkcWuzz45X6nkfrOegqlnwL5BRY4Q1cz2dem1ZQxZ1bGNIzw2
         E5qO9jAolJ11zfvU8t1pXnlrqyHGsrcmJz3NfYo7Qq6rKOGqF75vFNW6485fH/YWjuRK
         vQ5sP1QXuJU4KtmJL8F2LwYjkLOaW5gXUvrT3khK2KOwjY4CXYAanh8SIcNon992t7j+
         6wow==
X-Received: by 10.50.147.71 with SMTP id ti7mr9148965igb.49.1368706368368;
 Thu, 16 May 2013 05:12:48 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 05:12:08 -0700 (PDT)
In-Reply-To: <7vli7ioqzx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224557>

Junio C Hamano wrote:
> It is simpler to use 'default values', no?
>
>         local z=${GIT_PS1_STATESEPARATOR-" "}

There don't seem to be any more comments.  If there are no issues,
could you fix this up locally before queueing?

Thanks.
