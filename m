From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 22:41:35 +0530
Message-ID: <CALkWK0mMvUXnMDY87h3US0gRuM44ADEYXPh+JVP23Ja1=yz=VQ@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
 <877gjrpsk4.fsf@hexa.v.cablecom.net> <CALkWK0kn7mEosWSdWs1Jjx-L32wmL51W=X7ny9BYQMttG1LPvQ@mail.gmail.com>
 <87li87awwc.fsf@linux-k42r.v.cablecom.net> <7va9om5zxu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 19:12:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVPiY-0000xe-3W
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 19:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758161Ab3DYRMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 13:12:18 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:46826 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757789Ab3DYRMR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 13:12:17 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so3928733iea.4
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+VfpDSML6YsqmQ1CZ8kbIb4gQSrPqdYYuBw2kgmjZj8=;
        b=ZS/M7Gw8ZmHglzhjGit2BOaSfEBjTE/HDMaoraKzbFEGipXBAY/xY3yX1nrkJ+ahWp
         sdtooYFQXhuIVNM2FL8aUDD00m06nW2aHJBHF2Alh95l5t2iB0hyM99sT2sltD7G/3Fy
         nk8PrYcoTWvCq3Ebknj4Nlv7YH5bFFYmwnWCzhVSuX0H3/0yeZUIVYjgNqS3gG7sW7Qo
         hqIDRcOQXp99RrCSqpRvxthW4LsF5Ufh3/S/bcRlsz8etkwUAQfhNt515rSaQ7e2xGm5
         y7KmCZPlRK7Y5ID+2OkwQo1xNaFWOXHAy1WpkOCcYxnoEYA0p2oEHW0crbGvBxF/tFf1
         82Kg==
X-Received: by 10.50.73.65 with SMTP id j1mr19568135igv.49.1366909937317; Thu,
 25 Apr 2013 10:12:17 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 25 Apr 2013 10:11:35 -0700 (PDT)
In-Reply-To: <7va9om5zxu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222397>

Junio C Hamano wrote:
> than ^!/^@
> which I agree were more-or-less "let's add a random cruft on a whim
> without thinking things through" mistakes.

I thought ^@ was invented for scripting, but can't imagine a usecase for ^!.
