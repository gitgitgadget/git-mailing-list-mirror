From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Clone from shallow bundle bug
Date: Wed, 01 Apr 2015 10:06:35 -0400
Message-ID: <551BFB6B.3080101@ubuntu.com>
References: <551B0D37.5070407@ubuntu.com> <CACsJy8C0wMFiPw1thSWN-dPVW+9N=JXDsy_HFCj=Oyu2rf40eg@mail.gmail.com> <551BEA4A.9050708@ubuntu.com> <CACsJy8C4G01LOhg13=rhkCTMGTq-NTHgG-k-kaoT9jALnd7CZw@mail.gmail.com> <551BF2E6.6050000@ubuntu.com> <CACsJy8BR=JjJ_WJ+wGLk_AhpjRh+avJnRb2KmRiVx_+2cintLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 16:07:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdJIx-0005vE-Dk
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 16:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220AbbDAOHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 10:07:30 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33542 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbbDAOHa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 10:07:30 -0400
Received: by qgfa8 with SMTP id a8so43163789qgf.0
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=b1Vrdj3csZiXwbtAB+eOOqu6xqMryxp9EKT3/aIpi1E=;
        b=YXO2E0eB5jyQhoZMEPvIUjgBrwc/Lp2f1eTP9LBxJiUr5n0ykmSK1gyHqCFIbJd8TC
         V4JZHcDasHdzecTC+9ZkE7neFDq9cAWHiMXXr0rL6AP6nIpkIyk3xjhC4ja8UrxVfDKk
         PVm+v0d7J2sKOyswVG9vo3AwtLHkfzCD8tpu0PrmRMhs2UEwNw4nYZdRMJk4qsxzva0U
         RTPsxcsGRC47tOGFbSpALwirPA0JfMLGyyXdL/Iw5C8Vv7h2Rd+mW1SeilTcoH8lzTu/
         k5SuJmT2V5jltscacxfY7vDyZC9OISTPDHSm+xYVN/Fs0kySDpcB1PMbCLHdY/lhGmby
         +KNA==
X-Received: by 10.140.23.38 with SMTP id 35mr49863870qgo.106.1427897249415;
        Wed, 01 Apr 2015 07:07:29 -0700 (PDT)
Received: from [10.1.1.228] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id x15sm1312034qkx.28.2015.04.01.07.07.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2015 07:07:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CACsJy8BR=JjJ_WJ+wGLk_AhpjRh+avJnRb2KmRiVx_+2cintLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266609>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 4/1/2015 9:36 AM, Duy Nguyen wrote:
> Thank you. I can reproduce it now. We need to plug this hole.

I'd much rather it not refuse to clone so that I can end up with a
proper shallow clone.  At least the way it is now, when I clone the
detached head, I can manually add the .git/shallow file and everything
is fine.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJVG/trAAoJENRVrw2cjl5RTTIIAJkdte4gWrrOGA49CI0xivX7
1FXH3tPp/Nhd7gG3MXNfozm78DS3ZWqoU4l2SUhoE3La9UJ81T2rVo9GjcR/yXeS
V0In+JyoQX3spZdtvH18qzKCFczyeUlu260EG7mQsBFgnAHsAJW3BPA6DWEPpfJS
U3RPGt4S7KKy2+XJAGZJgvhvwM9vndgx161Kgwwpdocv2uWmv0AZEcMzOppZQy3y
RqWSO5iY3qRwpMiRRh9YsQsuVNpXGxwPqV5oXXFLD7yaAMqCF5qdUYz8fWNQQ1+V
49RpGzMNHA60FP9BrvlHMCaJgFEvBT4nrpN4MCQgkelp8LOELX1kfuq9MWl1irA=
=BmpO
-----END PGP SIGNATURE-----
