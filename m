From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Thu, 2 May 2013 12:01:34 -0500
Message-ID: <CAMP44s1yMR5zrWycdfrToTUQ1j_aTFbySgn_gvROAvjUH1eN-g@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-2-git-send-email-artagnon@gmail.com>
	<7va9oe5y6k.fsf@alter.siamese.dyndns.org>
	<CAMP44s31jyuGGG1Wn9D=D9udkJJdXQfwVAnHuOg02FWinpmn7Q@mail.gmail.com>
	<CALkWK0=B_Ym_ei181eV-WeqJZJyHPv-AmLzYwajm13wftJkB6g@mail.gmail.com>
	<CAMP44s1x8pu2B2h3wKmuBDXz3Tqyk9qyijshcD6iN+NpYDCQdQ@mail.gmail.com>
	<CALkWK0k5zyGwZaP84YMON8VZbfjRxQ3PG2ML2ds8GdQY38s7SA@mail.gmail.com>
	<CAMP44s2nqLrLRFM1bH028FpV+tPYUWYDz_AffaBhVfwwm4h=kg@mail.gmail.com>
	<CALkWK0m=gmf9g_O3uHmpGkSa165G-5VGROTgjQx87XwvDDQKSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:01:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXwt4-00070g-13
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759198Ab3EBRBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:01:37 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:65078 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674Ab3EBRBg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:01:36 -0400
Received: by mail-lb0-f179.google.com with SMTP id d10so757525lbj.38
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=pL/j3+8GujRYfVAaRTQs3dbbXdfAcNmU3ZrwOMLZiNk=;
        b=QxMIDOc9RA36qTA0132lD+DeH68TGKsOOFGrQHwo2/nUUUhA/rFcVVnbsGSoOEIPk6
         mCUxXQJumkDbXf3dnamosGI8mhKxlThyKOai5n0r4FCkOuk4pU0m/WXibaBlUHblR96w
         9ULaUGFO27LwVYoJ2BiYmpbahd3Nu9ZrOa3XlHt/xsf37SO93Tjqd3N0uLwOBhMDzhCE
         5iK33MYaIXIgRSpPlNWxNJwS7HhjvYlMo1n35849k0PK+JVZ1zm119C7Rgfx0Ixz8JTr
         mQprv1U+wnXG6JUL3TsJoedKHREwVaOEiRfrHFomUQ6OZo7XhUZ8NM0qcYFREohQRXyn
         hlwA==
X-Received: by 10.112.22.198 with SMTP id g6mr2951563lbf.135.1367514094892;
 Thu, 02 May 2013 10:01:34 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 2 May 2013 10:01:34 -0700 (PDT)
In-Reply-To: <CALkWK0m=gmf9g_O3uHmpGkSa165G-5VGROTgjQx87XwvDDQKSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223224>

On Thu, May 2, 2013 at 11:56 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> Your approach can NOT be documented.
>
> Ah, I missed that.  The explanation I was looking for is:
>
> HEAD has been special right from the start, and we cannot elevate
> anything else to its status now.

We can, but do we _need_ to? Adding another magical symbolic ref that
has limited scope should not be a huge task, as the effects can be
documented, but another magical symbolic ref that does *exactly* the
same as HEAD would require too many changes in the code and
documentation it's not even worth considering, especially if we don't
_need_ to.

-- 
Felipe Contreras
