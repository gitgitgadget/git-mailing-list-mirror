From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 01/10] refs: add "for_each_bisect_ref" function
Date: Thu, 26 Mar 2009 17:54:40 +0100
Message-ID: <fabb9a1e0903260954u23bd7c7aq505e016e7a5c0c29@mail.gmail.com>
References: <20090326055509.1bc16b28.chriscool@tuxfamily.org> 
	<fabb9a1e0903252320j2edf4a8ct39f784c4319c3cb0@mail.gmail.com> 
	<200903260848.42104.chriscool@tuxfamily.org> <49CBA42D.3000404@drmicha.warpmail.net> 
	<alpine.DEB.1.00.0903261748280.12753@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 26 17:56:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmssg-0005Iu-5C
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 17:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378AbZCZQzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 12:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754188AbZCZQzH
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 12:55:07 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:33819 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbZCZQzF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 12:55:05 -0400
Received: by an-out-0708.google.com with SMTP id d14so475938and.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 09:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=daBiy36QPhVJtAehODNvulv/I5qmV+j0wC2TkxIcdfo=;
        b=dFk3E3je+LdJOVuswzTXY3estaVUz9Yk8ZlnHI0whFtp0iW96R54/KVxdIqX5V622o
         cPahX0Pb9vL+l//PpwvowzUyGGhXqZKWsUeAOc50H6cbi3vLwbBMCsO9DyU0a+h7ySK7
         qRMyvOqlIsB3w2eyTVKqoN+5kW/6tL7vNJljY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F+64b8FlpHZabsvwetGCrVz8uzv6UJ3fXGCJW/WMWJt4iH2Ic+9jWBoj34YIFSF3YD
         rn6lwZ5wkR/T+8cgLOqajIXurwyIc1t546hupiXDluFu5h3xxq9BmGl5rsvIzwOROwOv
         CtnxfmrHeXsF8hfDw3hHABdwiiYPP32G6eYWw=
In-Reply-To: <alpine.DEB.1.00.0903261748280.12753@intel-tinevez-2-302>
Received: by 10.100.14.10 with SMTP id 10mr770836ann.152.1238086497858; Thu, 
	26 Mar 2009 09:54:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114802>

Heya,

On Thu, Mar 26, 2009 at 17:52, Johannes Schindelin
<Johannes.Schindelin@gmx.de> > From the patch series' titles
(especially when they are cropped due to the
> text window being too small to fit the indented thread), it is not all
> that obvious what you want to achieve with those 10 patches.

<snip>

> Unfortunately, that does not reveal to me, quickly, what is the current
> state of affairs, and what you changed since the last time.

This is exactly what I meant to say, only worded much much better,
thanks Johannes! :)

-- 
Cheers,

Sverre Rabbelier
