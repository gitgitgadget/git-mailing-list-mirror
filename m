From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Sun, 14 Apr 2013 10:54:07 -0500
Message-ID: <CAMP44s2Ksi_nNm8f+YTdceSSavtiPODHKw-4eASeEeCWW2N91g@mail.gmail.com>
References: <20130410211311.GA24277@sigill.intra.peff.net>
	<20130410211552.GA3256@sigill.intra.peff.net>
	<CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
	<7vfvywj4au.fsf@alter.siamese.dyndns.org>
	<CAMP44s2QJJnSRVVJscLsTnXk5zdGbA2utefF5SO7=90+ttENew@mail.gmail.com>
	<7vd2u0hdmj.fsf@alter.siamese.dyndns.org>
	<CAMP44s1pZW6OJ2nkegKFQq6=npPSiD4dX_z37t63B9baaFW16w@mail.gmail.com>
	<20130413060031.GA22374@sigill.intra.peff.net>
	<CAMP44s3gOXvHknN1yXQcDYP=OBfjm7=eJnSkh5cj5QJNOarEWQ@mail.gmail.com>
	<7v38ut7ilq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 17:54:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URPFw-0003oE-AB
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 17:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab3DNPyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 11:54:11 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:60757 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab3DNPyK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 11:54:10 -0400
Received: by mail-la0-f42.google.com with SMTP id fn20so3450196lab.15
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=LWYQoRvu3okP4+GHTPhkBgn25ueBNJq13WHF39vGSSo=;
        b=ZDkUU/rhAN7caiP/1jhF2WM18BSqHlFLZWIolfrPyj4twt8ciLgBqKb3rR5wZ6TgwX
         ciIno3L+6ajXkv6Fm7IgYLQaAnmbp6wPlobdB9riPr57j1GwyhhkFbG5qX9ENPCVeRBK
         GUkrfKXwweq4k4wmtR7Gq/nQieSP4gSa1FHJOuXhMSX9aEngu0A8TutoS/bclJ32GBiX
         sdRu9Y2hIwioJH9O+MlRy0znRDxMx4cunOgChTrP4W1NGH3j/nYjqRikFcmG7QPN3Gh0
         zCJxN1M9eL0dBCfxvfdryC5A2UiPqZ6ID4Xbu9eU6XvTtuCbkSsQhaQrGCo24ZYCO16f
         OqEQ==
X-Received: by 10.152.18.164 with SMTP id x4mr5727439lad.38.1365954848000;
 Sun, 14 Apr 2013 08:54:08 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Sun, 14 Apr 2013 08:54:07 -0700 (PDT)
In-Reply-To: <7v38ut7ilq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221144>

On Sun, Apr 14, 2013 at 12:23 AM, Junio C Hamano <gitster@pobox.com> wrote:

> "Double" may only be showing that we do not have enough trusted
> maintainers; ideally I would like it to have "Triple" or more.

A double or triple review raises *a single* standard higher, but
having more than one standard is never good. But apparently your trust
in Jeff means more than caring about the double standard.

But good to know, my patches will always have an unfair disadvantages
to everybody else's.

>  - when we add something, we try not to overengineer or to shoot for
>    unattainable perfection, but we still try to make sure we will
>    not paint ourselves into an unescapable corner when we later want
>    to extend it.

And there is such a thing as being too cautious, to the point where
you walk WAY too slowly for the fear of tumbling, because it happened
a few times in the fast, when you were running. But how would you even
know that you are being too cautions? If you don't dare to walk a bit
faster to find out.

Cheers.

-- 
Felipe Contreras
