From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Re: Pull is Evil
Date: Thu, 01 May 2014 18:39:01 -0500
Message-ID: <5362db1554fa8_79d876f2f0bc@nysa.notmuch>
References: <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362664C.8040907@xiplink.com>
 <20140501175623.GY6227@odin.tremily.us>
 <53628CB1.8010302@xiplink.com>
 <20140501234522.GD75770@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri May 02 01:49:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg0jY-0001gO-Vd
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 01:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbaEAXtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 19:49:41 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:45980 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbaEAXtk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 19:49:40 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo20so4433169obc.31
        for <git@vger.kernel.org>; Thu, 01 May 2014 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=SkA98x5weP0B9IZ4KcTWznPS9Cp+2gt5cCdyq6cBDx8=;
        b=Eho87OxxKfnvoG2WfV/50o+Sx1Qb7WSB/hi5F+sxuOHjfMJhNbQ+3DY/I3MRfUIONl
         ymSkiJ8QURVeCpJt6dniV1gXlSqLCGal8UCsFcq4pLpeR6tdEdWZCc03nAd9FLDvBA8R
         VM6ONXcgurwBRvpfS2vCUyY52Hplkg1t02uU8wBHhoiOHXQ52PR5F4RHu/j82FbO1ZYv
         ifVlK6hRNIn21C3944kg4t/XDBNPeKlzsoSHtr0ybu2JffI9BjfXRPkxW1iyDkK/mQEb
         9e0oliZgqdHp4XNl6yT8fnYYJ+iSgMh8ApTTpdypUyTd2T7Gbuuv9U3+k1arzcgZdsJf
         k1Wg==
X-Received: by 10.182.200.131 with SMTP id js3mr12606235obc.0.1398988180156;
        Thu, 01 May 2014 16:49:40 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id js4sm37025869oeb.3.2014.05.01.16.49.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 16:49:38 -0700 (PDT)
In-Reply-To: <20140501234522.GD75770@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247898>

brian m. carlson wrote:
> I just used this to illustrate the fact that there isn't actually one
> completely correct case with pull.

Nobody is arguing otherwise. The argument is that `git pull` by default
can be made more sensible.

-- 
Felipe Contreras
