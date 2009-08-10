From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: Re: [PATCH] gitweb: Optimize git-favicon.png
Date: Mon, 10 Aug 2009 13:39:09 +0200
Message-ID: <4A8006DD.30504@googlemail.com>
References: <20090810110002.4448.88448.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 13:39:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaTDn-0006sJ-LI
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 13:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbZHJLjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 07:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753261AbZHJLjO
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 07:39:14 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:64964 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173AbZHJLjN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 07:39:13 -0400
Received: by bwz19 with SMTP id 19so2509314bwz.37
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=sBM+ZRGxZryiRQPQlIyAltCKedAO5LtV69FX4Pm9pFU=;
        b=tS334r4M21B1xMFLF8iB+KFOEnKjC1vnbjeTh3hexuy1Z5xsNgDmA7XekywB5ZeGfi
         psWnBeT6MA8JxBhOmJGtNmP7+Td/GXxnVkjCOasy3Btw3zngkK2uOB44npHbjdOyUikA
         rYxf2O53HnXAyGdCWN7BSU9ATQ3ssJbT4yyQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ngx1DZOaj2nlQNRV81TF8tOoqKHWC2ysLcszlIH1LXJndx15lH5bPzhwORGRJ6EGZx
         DJS+nqf+z4xTIJaZ7LyYcpawIQYq+niE3+Z87oL+mh8KHWsh8KVPhFoQYfa2tN/J+Lfw
         Nlf9lALLL+780SEyrBGFizHN+dqp/1C8LLLYc=
Received: by 10.103.240.15 with SMTP id s15mr1819619mur.45.1249904353110;
        Mon, 10 Aug 2009 04:39:13 -0700 (PDT)
Received: from golden.local (p5B01E520.dip.t-dialin.net [91.1.229.32])
        by mx.google.com with ESMTPS id j10sm19426224muh.29.2009.08.10.04.39.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 04:39:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; de; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
In-Reply-To: <20090810110002.4448.88448.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125434>

Reduce size of git-favicon.png using a combination of optipng and
pngout. From 164 bytes to 115 bytes (30% reduction).

Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
---

The contest is now open. Who can do better?

 gitweb/git-favicon.png |  Bin 164 -> 115 bytes
 1 files changed, 0 insertions(+), 0 deletions(-)

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

-- 
1.6.4.67.gea5b1
