From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Sat, 19 Feb 2011 10:27:59 +0100
Message-ID: <4D5F8D1F.3000901@gmail.com>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org> <1297304069-14764-1-git-send-email-pclouds@gmail.com> <20110218022701.GA23435@elie> <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com> <20110218092518.GB30648@elie> <4D5F0A7C.1080507@gmail.com> <7v39nkooem.fsf@alter.siamese.dyndns.org> <20110219005030.GB27316@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 10:28:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqj6t-0005P9-FI
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 10:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759Ab1BSJ2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 04:28:11 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47658 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab1BSJ2J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 04:28:09 -0500
Received: by bwz15 with SMTP id 15so1441172bwz.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 01:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wWRcc6T/qpTNhmDFcTsln2CSOB2PwUXP1Q6vQwzNo6E=;
        b=FUQUyoC6K5N0WdVUcHID2eRFieX1IUA+a/N9PmRWwIj5WU+9c+7x+Rq+kJxCo1Lqud
         LUDUqZYfv+04GpnMt1RpjuLQlAHb2HsaOSaF0t3MLvOybvMvT0caWxpCVCDgzM3F1aWi
         7A53KM9bzmEkWKBppaEA73SgU5wKrtEoxk/NY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=bFQKB6nMNWaXQftVkWadCsciA9RyGLvI6SsjrnMsy6QJhCCcSxcK3SrUyygXNmCWGt
         4u1HOHkJo1wyvBkKTLeQItiBFNIvexW2zdxzMU322olAo5Sy5kWYjoZ50R2qnk0AGMMQ
         ST/pgPOacLahngtUJJ314A764pHyovPkxPzY0=
Received: by 10.204.122.68 with SMTP id k4mr1564477bkr.153.1298107688071;
        Sat, 19 Feb 2011 01:28:08 -0800 (PST)
Received: from [192.168.1.101] (akw69.neoplus.adsl.tpnet.pl [83.26.26.69])
        by mx.google.com with ESMTPS id b6sm2075409bkb.10.2011.02.19.01.28.06
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 01:28:07 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <20110219005030.GB27316@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167262>

W dniu 19.02.2011 01:50, Jonathan Nieder pisze:
> At the risk of becoming repetitive: it is quite possible for make to
> take an O=elsewhere/ parameter to support both types.

I'm ok with O=elsewhere


> I am also in the camp of preferring to see frotz.o next to frotz.c.
> After editing frotz.c, I can do "make frotz.o" to make sure it still
> compiles.

"make frotz.o" has nothing to do with where the objects are generated, IMO.

Is this the only reason you prefer having objects with sources? 


-- 
Piotr Krukowiecki
