From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] use REALLOC_ARRAY for changing the allocation size
 of arrays
Date: Wed, 24 Sep 2014 11:47:40 -0700
Message-ID: <20140924184740.GK1175@google.com>
References: <5415C89C.4090509@web.de>
 <CAPc5daXuYVXG=b3Mjn=8oE71FqE_PRZ=XHXW_0F5uHawWwy4HQ@mail.gmail.com>
 <541886D5.8060202@web.de>
 <541887F9.3000100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Sep 24 20:47:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWrbR-0002Tj-02
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 20:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbaIXSro convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2014 14:47:44 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:63510 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbaIXSro (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2014 14:47:44 -0400
Received: by mail-pa0-f53.google.com with SMTP id hz1so9358665pad.40
        for <git@vger.kernel.org>; Wed, 24 Sep 2014 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YInTtoEgWkwhBgYp0iEqvKd0r4nHLQ1Uqpqyw1wZ+/E=;
        b=vHDzMkRe1Dthb2Th/i80Cc/edqtGFI1uK777sh/4RgsH9NpIzyRLDrpM1OuhVzbpnI
         2n2gBaloBzOf8lFldxjyR+HaZJ7UQY/RVUvPsj9CajaKBX1z6fQ5Ys8Bo+1qEh64Sn1p
         bUHsm41J9ArMqel6n/MYlSdOgTnDiaVyL928HYoV21dL8tz/8Qib9dAjzLdKmPvj4PUO
         9C9HaOgbC81WcIFya2ovzDRN4RGyg3mQQfiyk5XlH8cWzGal3k7rHzWhJmEqEIwyv0p/
         awT4HTOMPeMw/DpvBFCtVactYQO8fQrFc21ja3CSqr5UOs5zZoTXddkZXUttwfROjcds
         RTag==
X-Received: by 10.68.130.37 with SMTP id ob5mr3856407pbb.107.1411584463559;
        Wed, 24 Sep 2014 11:47:43 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id xk6sm60438pbc.11.2014.09.24.11.47.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Sep 2014 11:47:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <541887F9.3000100@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257464>

Ren=E9 Scharfe wrote:

> --- a/khash.h
> +++ b/khash.h

(not really about this patch) Where did this file come from?  Do we
want to be able to sync with upstream to get later bugfixes (e.g.,
https://github.com/attractivechaos/klib/commit/000f0890)?  If so, it
might make sense to avoid unnecessary changes to the file so it's
easier to see when it's safe to replace the file wholesale with a new
version.

Curious,
Jonathan
