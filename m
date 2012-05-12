From: Andy Kitchen <kitchen.andy@gmail.com>
Subject: git rebase -f --autosquash
Date: Sat, 12 May 2012 20:38:42 +1000
Message-ID: <D7BE2BACB49749DB9FC37D4ACCCD008B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 12:39:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ST9jf-0000TF-0p
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 12:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642Ab2ELKi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 06:38:57 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56942 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab2ELKi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 06:38:56 -0400
Received: by dady13 with SMTP id y13so4067783dad.19
        for <git@vger.kernel.org>; Sat, 12 May 2012 03:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:subject:x-mailer:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        bh=n+PbJYOjemBVApZlakXOQSq+K8XbxYiLEyAm8nWAaTU=;
        b=Aeh3I3h7inyBnfDBzRMU6mq+IQMk99v2mWhME9cI1vF7fyGyvJHfMfNAfB+gTEGEme
         IYvhydICPqFfpyoiqgZD/RRbsryrVpHBf5jnqTnevE+FGigVHqrC1SRL6Eb5x1uF0AAv
         dRGu8dU6P7hO8UfOlthrhAom/Tc/mOgHA3BDhQUUik1cyZujMwJQrLvAjDTbSB+DMnik
         eH/nsnCZR49YVbQffAEzqHaW6JrWjHUvpfyv9XVCAmqOjPTtwMJUWGw20Yr8Q8dKOwAB
         SqM4sGqij30nCJbxEMqnQHtQjVPSwrDQWchcDZeytPomWMPGGeE66WQGocwz30KaOXDt
         DggA==
Received: by 10.68.223.234 with SMTP id qx10mr3805279pbc.154.1336819135701;
        Sat, 12 May 2012 03:38:55 -0700 (PDT)
Received: from iceman.local (220-244-228-34.static.tpgi.com.au. [220.244.228.34])
        by mx.google.com with ESMTPS id tx9sm15652809pbc.10.2012.05.12.03.38.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 May 2012 03:38:47 -0700 (PDT)
X-Mailer: sparrow 1.5 (build 1043.1)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197720>

Hi All, 

I commonly use:

git commit --fixup <commit>

to preen commits before pushing them. I can run

git rebase -i --autosquash HEAD@{upstream}

to apply these fixes, however, autosquash only
applies to interactive rebases.

Because I am sure that my fixes are applicable,
I would like to be able to non-interactively autosquash, possibly
like so:

git rebase -f --autosquash HEAD@{upstream}


Would anyone else find this feature useful?


Kind Regards

AK
