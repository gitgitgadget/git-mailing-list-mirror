From: xiaozhu <xiaozhu@gmail.com>
Subject: Re: a bug about format-patch of multibyte characters comment
Date: Sun, 13 Feb 2011 19:50:19 +0900
Message-ID: <4D57B76B.6000600@gmail.com>
References: <4D565D3B.7060808@gmail.com> <20110213075337.GA12112@sigill.intra.peff.net> <20110213083137.GB12112@sigill.intra.peff.net> <4D579A35.1000007@gmail.com> <20110213085236.GA2251@sigill.intra.peff.net> <4D57AEFC.10608@gmail.com> <AANLkTi=Ty22nzd6ja=XmMzMu+YzDKDSBMCOGRfKenhR4@mail.gmail.com> <20110213102627.GB7735@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 13 11:50:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoZXD-00071Z-0c
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 11:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968Ab1BMKu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 05:50:26 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40482 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab1BMKuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 05:50:25 -0500
Received: by iyj8 with SMTP id 8so3875747iyj.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 02:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=kXAZJK7+aCWmN6W1kbyAApCGrXz19ivBbHZO2nXUP/I=;
        b=sHpWOIg9P3jFbR76983EN1r9JsoWlKbC93TbhCVlRkY60/qYp3L371/8aIx54Aunc/
         UDbsiUMdFG0lHl9lVhQEwPLgGRTnlnAbDcOFUBvJqP+MpAglKA6ueqFK9/V3fCaP78Nh
         Kh7e7Nooxn8Z2Ro0whTDcvizOEcSpNfArOqsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=MEnfS/4dB854VnT/r12W4H/DfvU4VaL6iakvpJdC3R5/gUtGPNdgrVY7KsSsBiI2fS
         9yfLuR5hIapub7oVxAabmb86YYl6QaOg1xb1I7Dx2ixRFGtz9hvMROd7b9BYIan4qIau
         WhIS3u7Cv+LFIzw7Y4J+tTtLupIzLMMNAeLHs=
Received: by 10.42.223.1 with SMTP id ii1mr3367370icb.287.1297594224727;
        Sun, 13 Feb 2011 02:50:24 -0800 (PST)
Received: from [192.168.11.57] (softbank126036243176.bbtec.net [126.36.243.176])
        by mx.google.com with ESMTPS id q3sm1342088icf.20.2011.02.13.02.50.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Feb 2011 02:50:24 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110213102627.GB7735@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166661>

> Ah, OK, our mails just crossed paths. git-am already parses this
> correctly (actually, it is git-mailinfo that parses on behalf of
> git-am). We just need format-patch to generate it (and it should also
> probably be folding long lines in general).

I tested it, yes, the git-am parses it "correctly". There is only
one problem that we lost the line break after import a patch. Is
there a way that we can retain the line break after import the
patch?

-xzer
