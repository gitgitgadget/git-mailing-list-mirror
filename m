From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 03/11] ref-filter: add option to pad atoms to the right
Date: Tue, 28 Jul 2015 00:13:57 +0530
Message-ID: <CAOLa=ZR05e-sx51ne==2+t+rS6mGxXAX44Vd2vHCvBYMM16K3A@mail.gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com> <1437982035-6658-3-git-send-email-Karthik.188@gmail.com>
 <vpq3809aho9.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 27 20:44:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJnO3-0005lq-T6
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 20:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbbG0So1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 14:44:27 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34646 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbG0So1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 14:44:27 -0400
Received: by oigd21 with SMTP id d21so56602988oig.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 11:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=biapEqdFa0pgIM1OY1MTJ2rQOgtKBd1UfMoaJcMmlWM=;
        b=XDVrFeSK0u6TGQcRtmPHqoEjzSZEyrnbMguzPvdX1PWxxDUPaCnQBuZzitdGq4jrss
         SjXWur2VFGg47JaBd95LwlwrJEqpg7VwaGx6kUIpg3mgXZCXD2SjgblkfAf1IhgZkmqs
         1XWA9TP1csVnzoUHC/oYoAoAxo98vBmZP1IDRqPq6LzTPZrx2b6Fg9Gp1rK4rBqkS03V
         ib9Y84lmegucQsSMkDIqvNIs8rKHhv34bSaz0RO630UYBPW1hts1G0UyZ1gTtfwJcAdB
         ZzmN1HRUyvufm1QajqLC9+dYl7v3lrNE257pdBsRjg4PMYx9R78ys17F8pPKi5Vl14GI
         by/A==
X-Received: by 10.202.200.151 with SMTP id y145mr28264914oif.111.1438022666734;
 Mon, 27 Jul 2015 11:44:26 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 27 Jul 2015 11:43:57 -0700 (PDT)
In-Reply-To: <vpq3809aho9.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274696>

On Mon, Jul 27, 2015 at 6:20 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> u
> also need to check that it is taken into account for the right atom and
> only this one. I'd suggest
>
> --format '%(refname)%(padright:25)|%(refname)|%(refname)|'

I guess this is more accurate, Thanks.

-- 
Regards,
Karthik Nayak
