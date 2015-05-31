From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v4 8/8] ref-filter: add 'ref-filter.h'
Date: Mon, 01 Jun 2015 02:20:18 +0530
Message-ID: <556B740A.5030404@gmail.com>
References: <5569EF77.4010300@gmail.com> <1433008411-8550-8-git-send-email-karthik.188@gmail.com> <CAPig+cR88O=STcJDrB+96uJ0Y60mO49QxoJfbOY8Xk4hPvNxGA@mail.gmail.com> <556AC40C.5020205@gmail.com> <vpqlhg4jx0d.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun May 31 22:50:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzABh-0004AB-97
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 22:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758575AbbEaUuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 16:50:25 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34410 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758488AbbEaUuX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 16:50:23 -0400
Received: by payr10 with SMTP id r10so12250674pay.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 13:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xByNXKUxos23S0FQaAeruvQ0yH8kJgjL2eqLy7l4GYs=;
        b=rB12YbXmSalwGCw1UexVt/RgbIsmaDxH8LR95iBJRK0ti+pMHYz7qPa1eOyeJPMTmM
         ouSUHFaMGzsXqv/qYW6BbPxlSEpsCySPFrkg8Ih61LPhVrDD/8mebjpqV3kbJjvXfj6I
         dxIJocgUyTIl3BO3YFkafcFmBd3v+yQSw2wiE093Q+Tf+QFg48u6m7ViFrtdywnKuGi9
         3Sn/hOvIASSIFf+pzshdYTK9GIIgvapuDH2qkfuAl/I1WkvBVwYKIpSWZJkRRKNfXawh
         2vyTDcXVDsITJGa8prhWva4Gqfv4Bn/QZ7O1KPcno7p5Nd+IStW0fiUPumZ8/Ki3/0ux
         w5TA==
X-Received: by 10.68.98.65 with SMTP id eg1mr34269307pbb.72.1433105423149;
        Sun, 31 May 2015 13:50:23 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id po2sm12064209pbb.13.2015.05.31.13.50.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 13:50:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqlhg4jx0d.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270354>

On 06/01/2015 02:16 AM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > That is kind of a problem, If I need to swap those commits also, I'd
> > have to add the part where ref-filter is added to the Makefile with
> > the code movement from for-each-ref to ref-filter. This again will not
> > just be Code movement.
>
> You can have a preparatory patch that adds ref-filter.c containing just
> "#include ref-filter.h" and ref-filter.h with proper content. After this
> preparatory patch, you're in a rather silly situation because you have
> an almost empty .c file, but it's still passing all tests and
> compileable.
>
> Then, the next patch can be just code movement.
>
Would it be okay, If I just include the Makefile addition along with the code movement
from 'for-each-ref' to 'ref-filter.c' like Eric suggested?

-- 
Regards,
Karthik
