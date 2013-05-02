From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Thu, 2 May 2013 22:26:55 +0530
Message-ID: <CALkWK0m=gmf9g_O3uHmpGkSa165G-5VGROTgjQx87XwvDDQKSg@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-2-git-send-email-artagnon@gmail.com> <7va9oe5y6k.fsf@alter.siamese.dyndns.org>
 <CAMP44s31jyuGGG1Wn9D=D9udkJJdXQfwVAnHuOg02FWinpmn7Q@mail.gmail.com>
 <CALkWK0=B_Ym_ei181eV-WeqJZJyHPv-AmLzYwajm13wftJkB6g@mail.gmail.com>
 <CAMP44s1x8pu2B2h3wKmuBDXz3Tqyk9qyijshcD6iN+NpYDCQdQ@mail.gmail.com>
 <CALkWK0k5zyGwZaP84YMON8VZbfjRxQ3PG2ML2ds8GdQY38s7SA@mail.gmail.com> <CAMP44s2nqLrLRFM1bH028FpV+tPYUWYDz_AffaBhVfwwm4h=kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 18:58:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXwpo-0001NW-O8
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 18:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578Ab3EBQ6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 12:58:10 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:61590 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761653Ab3EBQ5g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 12:57:36 -0400
Received: by mail-ie0-f170.google.com with SMTP id aq17so914509iec.1
        for <git@vger.kernel.org>; Thu, 02 May 2013 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1t4Q+dGZ9P7G6Njh7IuDjF7ZmJeJT8yQ9bl7k8W/iEs=;
        b=gCjnqCSXq/bT3VyUwP44s7t7Kn4U9W3CuKpU9NcMZNSnShAVztOtgrLQLtY/51pan1
         qa938s3jE5vJpKTAsRgeVdbdqXcgVrSBD/+w5dC4PU3K3AiLSlcG0tV9XAnlBWmZ+6Sw
         C+2+sGqlnjR87q7hajGlflGj4yseSHIr6+gFtaea3CajotP+xwKc+1KTIbDPa80AhsIi
         LhUeEwtMxIfYyqgf03UKYr+goH1CbdAwNw5juslFiMsn0teCiuA+1SbF7wWk/THyshQV
         6exSBqrnR6oDlqtkX6PlZcDVfBYrsolUDgkvl/W8d6dEz72IINFFpeOq8kpcQ8Kdxl7y
         enqA==
X-Received: by 10.50.3.38 with SMTP id 6mr4264354igz.44.1367513855646; Thu, 02
 May 2013 09:57:35 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 09:56:55 -0700 (PDT)
In-Reply-To: <CAMP44s2nqLrLRFM1bH028FpV+tPYUWYDz_AffaBhVfwwm4h=kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223222>

Felipe Contreras wrote:
> Your approach can NOT be documented.

Ah, I missed that.  The explanation I was looking for is:

HEAD has been special right from the start, and we cannot elevate
anything else to its status now.

Thanks.  And sorry it took me so long.
