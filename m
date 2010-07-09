From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH] diff.c: fix a graph output bug
Date: Fri, 9 Jul 2010 09:04:45 +0800
Message-ID: <AANLkTilSbmU5ejI5lWcN9GFQ544xd0zBtn-5s-nLzBAv@mail.gmail.com>
References: <4c35eb6c.21078e0a.1455.ffffe42d@mx.google.com>
	<7vhbk9o6ie.fsf@alter.siamese.dyndns.org>
	<7v1vbdo4j5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: struggleyb.nku@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 03:04:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX21S-00010F-JF
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 03:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192Ab0GIBEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 21:04:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56260 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589Ab0GIBEs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 21:04:48 -0400
Received: by wyf23 with SMTP id 23so1070921wyf.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 18:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=HzfiyPQg5RAhV6VuYu5lPZ++PIA+Bvt09GHMqZcMbhw=;
        b=LwVsXq/2Ij9GlLykn8UI1cqRNCk13IvguTiXN8Uty6VvngNoT5RyTEvpYLtO4KWa2k
         ZreLCQBUSuQoETYTU7hFu+9KZ9eaKOBztwubUUoA1lr9/g0jmC9mV2wXtMaQmtRRLnXQ
         NzzjLLYZq67iOI26zq98B20orz6Zp07IWm2Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Pef8HK/zZgK7TJ2bvQpP/SLPW7bm4bi+X4aBBmtGykTBulDl0a5kv2U1r4H/UwW2Gi
         DYMasf2Dl1KMjVXqdmGDQ35MzkypEcC2w6Abo97YEGJYsCTbUTvYmoW0U0cT/rkatosv
         66QGvEm/dFYwOVyTy8P0kuLZwUMW/knVuyX0I=
Received: by 10.227.135.66 with SMTP id m2mr7473602wbt.187.1278637485781; Thu, 
	08 Jul 2010 18:04:45 -0700 (PDT)
Received: by 10.216.163.142 with HTTP; Thu, 8 Jul 2010 18:04:45 -0700 (PDT)
In-Reply-To: <7v1vbdo4j5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150627>

On Fri, Jul 9, 2010 at 8:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> reset at the end of line_prefix so it won't be effect anyway.

s/effect/affected/  ?

nazri
