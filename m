From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: Re: [PATCH] gitweb: Optimize git-favicon.png
Date: Mon, 10 Aug 2009 14:09:00 +0200
Message-ID: <4A800DDC.8070301@googlemail.com>
References: <20090810110002.4448.88448.stgit@localhost.localdomain> <4A8006DD.30504@googlemail.com> <200908101357.49967.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 14:09:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaTgh-0000jG-KK
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 14:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbZHJMJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 08:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753881AbZHJMJF
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 08:09:05 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:62820 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbZHJMJD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 08:09:03 -0400
Received: by bwz19 with SMTP id 19so2522734bwz.37
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 05:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=6UXIiYf1Ap7Cqkb2LEFNlPl7JA2y/hLq+RA6RgNM/O8=;
        b=vFrSVV7b/IUKwEZnT3XA7jvq81baR4DWtoOQ8pj4MdSuXspEHJeoc/7oc9GYnqgqth
         pVKe01SUSTTNwIxiLTsYYNYQT6LTW20R+AGRbkVLrCwvOHihd3mqHNWCQ0sr0XPMubOw
         XoeWD5FSIk0OMVuDICW3GJjCEytAQHYUeu6l0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=PNRmx77fmdR3LAlndMXnQZ3M5SxTT1bfnoOlPAaGhs+s0zcmmf1Gm9/iNT4p/ermlW
         E+o6k5IS96xD2IQjSRGr8wwHomDbs5Hi79iXUEzYPINliLL0O6+s6bJZk5tbfLnHGIKg
         zqPDzMlvz5QUmn3zc0HAi8/0gNraTjI/O0bxM=
Received: by 10.102.244.4 with SMTP id r4mr343055muh.1.1249906143054;
        Mon, 10 Aug 2009 05:09:03 -0700 (PDT)
Received: from golden.local (p5B01E520.dip.t-dialin.net [91.1.229.32])
        by mx.google.com with ESMTPS id y2sm19548324mug.42.2009.08.10.05.09.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 05:09:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; de; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
In-Reply-To: <200908101357.49967.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125437>

Reduce size of git-favicon.png using a combination of optipng and
pngout. From 164 bytes to 115 bytes (30% reduction). Also reduce
git-logo.png's size by one byte using advcomp.

Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
---

Am 10.08.09 13:57, schrieb Jakub Narebski:
> 
> Can you optimize git-logo.png?  Smush.it wasn't able to do it, but
> perhaps different PNG optimization tool will reduce git-logo.png
> size...
> 

advcomp was able to shave one byte off git-logo.png. I don't know if
that's worth the effort.

 gitweb/git-favicon.png |  Bin 164 -> 115 bytes
 gitweb/git-logo.png    |  Bin 208 -> 207 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/gitweb/git-favicon.png b/gitweb/git-favicon.png
index de637c0608090162a6ce6b51d5f9bfe512cf8bcf..aae35a70e70351fe6dcb3e905e2e388cf0cb0ac3 100644
GIT binary patch
delta 85
zcmZ3&SUf?+pEJNG#Pt9J149GD|NsBH{?u>)*{Yr{jv*Y^lOtGJcy4sCvGS>LGzvuT
nGSco!%*slUXkjQ0+{(x>@rZKt$^5c~Kn)C@u6{1-oD!M<s|Fj6

delta 135
zcmXS3!Z<;to+rR3#Pt9J149GDe=s<ftM(tr<t*@sEM{Qf76xHPhFNnYfP!|OE{-7;
zjI0MY3OYE5upapO?DR{I1pyyR7cx(jY7y^{FfMCvb5IaiQM`NJfeQjFwttKJyJNq@
hveI=@x=fAo=hV3$-MIWu9%vGSr>mdKI;RB2CICA_GnfDX

diff --git a/gitweb/git-logo.png b/gitweb/git-logo.png
index 16ae8d5382de5ffe63b54139245143513a87446e..f4ede2e944868b9a08401dafeb2b944c7166fd0a 100644
GIT binary patch
delta 156
zcmV;N0Av5q0nY)D7zqdi0002!DLE{WAt!%wNkl<Zc-rli(F%Yd6hp6fOaK3mORa}A
z2z1~>otGhl0|P~i$)-spEt!DmG!4Oj(E`y{=&}QVPE<oMZAOGbjq8K~(J6VKR=YOW
zicn}%Cu(Zk>Vav`S8+sy%-3K4v`F-e93n=ACyP7?a2n|X$Q?(91Ro%p-ctYo000O{
KMNUMnLSTYNOFs$#

delta 157
zcmV;O0Al~o0nh=E7zqRe0000j+0-qOAt!%xNkl<ZD9>X^XCMShTo?)nDq>S%AOZ*t
zX+^A|p#d-qlVCO`QjxI%5!T^VWNd8AY-|jo3~(x91}ec~9kT%fQ=|y!00S5%RuR<U
zAeS59v<@{SaVdhCFu0Qn5xGT(!HuAzL?H$zL4rVq!9|H6Z~*|MJt4&s9Gd<B000R9
LNkvXXu0mjfVZ1Yp

-- 
1.6.4.67.gea5b1
 
