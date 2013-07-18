From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Re* [PATCH] send-email: improve SSL certificate verification
Date: Thu, 18 Jul 2013 23:06:33 +0530
Message-ID: <CALkWK0na9B2o-uBYHetCfpUsB6duY8==kWkVU8vAUS29OPwDdg@mail.gmail.com>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-2-git-send-email-artagnon@gmail.com> <51D82970.5070108@web.de>
 <20130706143256.GX862789@vauxhall.crustytoothpaste.net> <51D83C7E.8000902@web.de>
 <CALkWK0kAfZLqyCO+e+0PH0-MmjMYX1nJmit5Qb5L3Qf6nyhC9Q@mail.gmail.com>
 <20130714170316.GE11097@vauxhall.crustytoothpaste.net> <51E3677D.6040903@web.de>
 <20130716001506.GG11097@vauxhall.crustytoothpaste.net> <51E4B113.8000009@web.de>
 <7vd2qf4xoo.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 19:37:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzs8n-00087f-C6
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 19:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759242Ab3GRRhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 13:37:16 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:51150 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759127Ab3GRRhO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 13:37:14 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so7625109ieb.38
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Yn3fOCB73kXMvy/eUDY180xWI2ttwXWP9qDnSOE11T0=;
        b=wJ4/QpfizGn12HgWC8Tb836GKltIdrbp67d+gZx0BADEqy9UAbML5pETEvwW8spp1D
         tCD83Tw3RvDIunXRqJHUtWyFX5qiAraTVU/VYDMFk9RYSlBIMZYUTa+pjY5F3gpL9Ojp
         6tpZOD8+PFQyWyAF2uiEOtqidCUpdJo/GJG8YRROU/rqFd3u0UkHQmW6J3IkFCIl+sw/
         AI3quI3mLttSBtpZxsKFIKvPirTjx3X4KaEzEkaRaEm/AAG+9QsSkj2/TqCjfClJl0pD
         vZIuLb04qcJhrW05JD5TmTGp5kYkXnG+QwfP+1/nRZLprDg5chBTtpzVaYRfQvOj9L0J
         kNfQ==
X-Received: by 10.43.15.68 with SMTP id pt4mr6832028icb.35.1374169034256; Thu,
 18 Jul 2013 10:37:14 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Thu, 18 Jul 2013 10:36:33 -0700 (PDT)
In-Reply-To: <7vd2qf4xoo.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230709>

Junio C Hamano wrote:
> Ramkumar, as you will still be the primary author of the resulting
> commit, I tentatively added a line for your sign-off even though you
> haven't signed off _this_ version yet, so that I would not forget.
> If this version looks good, please tell us you would.

Yeah, it seems to work fine for me.  Sign-off is fine.

Thanks for putting it together.
