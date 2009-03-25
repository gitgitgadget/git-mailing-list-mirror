From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [BUG] Infinite loop in git send-email if ran non-interactively.
Date: Wed, 25 Mar 2009 12:04:41 -0400
Message-ID: <76718490903250904q3ca9f20ak7288e49e226bb9fb@mail.gmail.com>
References: <vpqiqlyj64o.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Mar 25 17:09:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmVe4-0000HD-P7
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 17:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761198AbZCYQEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 12:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759452AbZCYQEp
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 12:04:45 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:64793 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759305AbZCYQEo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 12:04:44 -0400
Received: by yx-out-2324.google.com with SMTP id 31so96248yxl.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vR67s2J8rok0jgXgtNvsukL2vhhC09g546DLI5QSS84=;
        b=ulWvZ/ozUsGS0OENYRht3k98D7gmNpiLdYB0SDM1KsWVLM79ESU8RBDoTcqlYrFbiL
         v0u5X2u2ZzdOeC0wMofX1wPDH9dmTq5mkQmd8/NWiaCjDRKnKyKKt0jK/LbQdtrtyLF+
         DrE8x4al+9+TpY9PMS9qLTbQkmVdvdDaRvgOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T+ZMo56/KxgIoKMCu3RY+STtlLZ3LaCv9WczSWkwe5lKRZmiA5L4oXbzoHsqvFpkYC
         X0scDquUDvOCzvmwAvVf18EaMuz7djSe7w3f1pOD9p92tdCG43eXQxw94ZRjqMmy6MWy
         apz8z2Lf62rvFkUtIV6HhmXiSqYxJfdyJiSvM=
Received: by 10.150.228.12 with SMTP id a12mr177897ybh.13.1237997082084; Wed, 
	25 Mar 2009 09:04:42 -0700 (PDT)
In-Reply-To: <vpqiqlyj64o.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114613>

On Wed, Mar 25, 2009 at 5:36 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Hi,
>
> I've been hit by c1f2aa45b (send-email: add --confirm option and
> configuration setting) running git send-email from a cron job.

BTW, can you provide the details on how you are invoking send-email?

Have stdin/stdout/stderr been redirected? What arguments are you
giving it? And is this Vixie cron?

Thanks,

j.
