From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] Introduce remote.pushdefault
Date: Mon, 18 Mar 2013 14:32:46 +0530
Message-ID: <CALkWK0niFD81e_GnMDf-bY89J=GdyNbyi9sr-BruHs9wTzsZEg@mail.gmail.com>
References: <7v1ucr43mk.fsf@alter.siamese.dyndns.org> <1360314123-1259-1-git-send-email-artagnon@gmail.com>
 <7v4nhm1s85.fsf@alter.siamese.dyndns.org> <CALkWK0m2N=D47WJLk1F4j1GsGGWHyfxVF_WGXBbG3vyrfQ-oLA@mail.gmail.com>
 <20130317054803.GB16070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 18 10:03:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHVyh-0004zx-7M
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 10:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009Ab3CRJDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 05:03:08 -0400
Received: from mail-ia0-f171.google.com ([209.85.210.171]:56428 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab3CRJDH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 05:03:07 -0400
Received: by mail-ia0-f171.google.com with SMTP id z13so5076843iaz.30
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fD4Q7R0ODXRCUGdegncITPBrRBzTX3S3ew/CUGTHggM=;
        b=E+0RNKNlEsN46zTyKIKrlQJP7jxFvVaU5nmkpisAgf2OC7NvdfKH6YoH35egXxI4pt
         y9Ye9G8ke8rZ+lv5lcvlbaWdp9CJT3bXqIbjOvb29SR/hHbcOHyjwYTivRZ+lRkmzlLU
         eTwrZ5sUJ5tiFWxS7qOIKQsoKMxZCnwRYs2DEwI2VrDmEFDQh3vZ4AN/FDQfS3JpgehW
         vZmLB0bEYLR0T7KuAew1/2iF4tlNtv9IrQSG5SGnvTw+ldE4T3dVW6BmDFvhf+r/+70s
         eiol1xJRVF1GpjSJ/DIwt/2g0Wn01kgfPz6BGkbTg+0dejAbpr0/Iub67MTv1XKX1hdF
         YcLA==
X-Received: by 10.50.119.102 with SMTP id kt6mr5715135igb.12.1363597386677;
 Mon, 18 Mar 2013 02:03:06 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 18 Mar 2013 02:02:46 -0700 (PDT)
In-Reply-To: <20130317054803.GB16070@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218399>

Jeff King wrote:
> So the push lookup list is (in order of precedence):
>
>   1. branch.*.pushremote
>   2. remote.pushdefault
>   3. branch.*.remote
>   4. remote.default
>   5. origin
>
> and it solves Junio's issue because the way to say "override my
> remote.pushdefault for this branch" is not to set "branch.*.remote", but
> to set "branch.*.pushremote".

Right, thanks for clearing that up Jeff.  I'll re-roll with
remote.pushdefault overriding branch.<name>.remote.

Ram
