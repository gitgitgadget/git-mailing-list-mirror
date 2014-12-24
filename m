From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] transport: simplify duplicating a substring in
 transport_get() using xmemdupz()
Date: Tue, 23 Dec 2014 18:08:47 -0800
Message-ID: <20141224020847.GC29365@google.com>
References: <549A0657.6010509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 24 03:08:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3bNg-0003cT-GL
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 03:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbaLXCIv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Dec 2014 21:08:51 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:42510 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaLXCIv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 21:08:51 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so6344339igd.8
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 18:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0phf3W9BUuiFl81a3dS0mVJrpqMPpf4T9FpYt6EeJY0=;
        b=ulnK1FfQ8BDnvPiBsVGXCrIz8CIICaynRoDkPoDxuEfoJ3lFfEcz1vZcn1RzOErWc+
         VArK8ByXA29tdUj3eqv1YT+FS0lXzC2rHfGOnPAoVvFPq9P9vSrgpFOcabIqQJELMZtv
         K8QQPLbcDt1TWdL+f+ffLHk+GXPiJYP0HHOCaKeWqVLVjrTrlutVbBSF/LUq+M5mPoBx
         Q60E0T8ywR3Yt5stcA81FVX6FZD/Fz5YTCkGQtW1RDe8utO4cBU+Fhfu/gzG9UjjYXlH
         PKX8MB1YVwyVOIGYrfMfMg/3rds2zSgu9+h2RRivxzdXQOZJodOp2ty8z+Hdzu3AYNDP
         PtEw==
X-Received: by 10.42.253.195 with SMTP id nb3mr24504312icb.34.1419386930302;
        Tue, 23 Dec 2014 18:08:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:f575:2fb0:789a:eca0])
        by mx.google.com with ESMTPSA id 5sm10722773iom.7.2014.12.23.18.08.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Dec 2014 18:08:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <549A0657.6010509@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261788>

Ren=E9 Scharfe wrote:

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  transport.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Since external_specification_len(url) is defined to always be less than
strlen(url) when is_url(url), this should be safe.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
