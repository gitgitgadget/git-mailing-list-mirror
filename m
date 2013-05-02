From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Thu, 2 May 2013 17:06:50 +0530
Message-ID: <CALkWK0n0e563Bjw=tXww9hDckv3Rekvp6u0m2uJ8UMrqsFOKMQ@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-2-git-send-email-artagnon@gmail.com> <7va9oe5y6k.fsf@alter.siamese.dyndns.org>
 <CAMP44s31jyuGGG1Wn9D=D9udkJJdXQfwVAnHuOg02FWinpmn7Q@mail.gmail.com>
 <CALkWK0=B_Ym_ei181eV-WeqJZJyHPv-AmLzYwajm13wftJkB6g@mail.gmail.com>
 <CAMP44s1x8pu2B2h3wKmuBDXz3Tqyk9qyijshcD6iN+NpYDCQdQ@mail.gmail.com> <CALkWK0k5zyGwZaP84YMON8VZbfjRxQ3PG2ML2ds8GdQY38s7SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 13:37:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXrpa-0006z8-P6
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 13:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758147Ab3EBLhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 07:37:32 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:38454 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159Ab3EBLhb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 07:37:31 -0400
Received: by mail-ia0-f179.google.com with SMTP id g4so382954iae.10
        for <git@vger.kernel.org>; Thu, 02 May 2013 04:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JOsJeUbpa7ERFhCId+28uj0lebqLssBOpcx9fm780kc=;
        b=WpnTKzrVba/4e0WGDuwvNa4vF8z2pQQwtswcYMAh9bNbTW7pINxgVJV6gi1ebKFLR+
         1qYUEzoR7BlkQ6QL3uHUZ3/68+BUeo4R9Oo/t93tyEc33KdrzccdzmnNOat2iVC5OWN9
         yQuqEDssbp19DjfCfPZdHl2MTocc7r7ufJExFEO8eYr5vOpRsdl8pH6dzTOtf6WH6qrA
         emIOIomc01gtFccD+MN9H8OuU4X1dpJKI4p61mXCqa2bI08NKTleRvhkNCQdsRuovBXZ
         itFZ3iuHFYnlXf/2MxqWu4fNyYIJbuV3JhU/j2xDB5nxDGqZft3T2bgUTkeC12amJ1Uz
         rImQ==
X-Received: by 10.42.27.146 with SMTP id j18mr3146242icc.54.1367494651042;
 Thu, 02 May 2013 04:37:31 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 04:36:50 -0700 (PDT)
In-Reply-To: <CALkWK0k5zyGwZaP84YMON8VZbfjRxQ3PG2ML2ds8GdQY38s7SA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223193>

Ramkumar Ramachandra wrote:
> [...]

Disclaimer: I'm not saying that my implementation is Correct and
Final.  I will be more thorough in my re-roll about justifying my
changes.

What I am saying is that we should fix symbolic refs, and that @
should be implemented at the ref-level to maximize usefulness.
