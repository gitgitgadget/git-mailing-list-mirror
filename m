From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] gitk: Add mouse right-click options
Date: Thu,  7 May 2015 22:29:19 -0400
Message-ID: <1431052160-82758-1-git-send-email-rappazzo@gmail.com>
Cc: Michael Rappazzo <rappazzo@gmail.com>, Jens.Lehmann@web.de,
	Johannes.Schindelin@gmx.de, Josef.Weidendorfer@gmx.de,
	Knut.Franke@gmx.de, alexhenrie24@gmail.com, andersk@MIT.EDU,
	andrew.kw.w@gmail.com, angavrilov@gmail.com, arjen@yaph.org,
	askeolsson@gmail.com, astrilhayato@gmail.com,
	barra_cuda@katamail.com, bdowning@lavos.net, bebarino@gmail.com,
	bernt@norang.ca, chriscool@tuxfamily.org,
	das@users.sourceforge.net, dave@dulson.com, davvid@gmail.com,
	drafnel@gmail.com, fbriere@fbriere.net, felipe.contreras@gmail.com,
	gabriele.mzt@gmail.com, gauthier@ostervall.se, gitster@pobox.com,
	giuseppe.bilotta@gmail.com, gsromero@infernal-iceberg.com,
	hirofumi@mail.parknet.co.jp, ilya.bobyr@gmail.com, j6t@kdbg.org,
	jeffh@ActiveState.com, jim@meyering.net,
	jon.delStrother@bestbefore.tv, jrnieder@gmail.com,
	judge.packham@gmail.com, kaitanie@cc.helsinki.fi, kevin@sb.org,
	killekulla@rdrz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 04:29:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqY2i-0007KL-Pk
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 04:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbbEHC3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 22:29:30 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34488 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbEHC33 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 22:29:29 -0400
Received: by qgfi89 with SMTP id i89so30601768qgf.1
        for <git@vger.kernel.org>; Thu, 07 May 2015 19:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zWlbFFyxM5FXRITVraEXTRJUhWCjpVCpnjdtha9WLH0=;
        b=a/YC5FBNpiGLeZxZv3MLu+s1LGHqHfF2d9r88oun92d5bEsaf7xGhi+PrdZnZk0PO8
         UjXXLri3Ta2kr7E9LbF3IiI6FTUBL47AcoA9m7twq1QOQiIbkCCtGVM3i1cQnqUixWYs
         YgcKn7nCeCdqp85Y2YCqjRXA0HR/BFrjafELFRp/24mmWeay8UU8oGFVIyRdtT6zr+VC
         Mf+8vkX4EtjQac4Fr5MPGGpO8QHYeVUgDg38ZW/jEsWAlL6aF/B/R+q4B+DSqadHGG+5
         Tcef2hGnj2ZDVm5ivHpavC7MombB2HK2y2jrIvLFcEbo/OC0VYywfkPJ145iSlw2UBD0
         hm4A==
X-Received: by 10.140.49.11 with SMTP id p11mr2214805qga.60.1431052169017;
        Thu, 07 May 2015 19:29:29 -0700 (PDT)
Received: from localhost (ool-18e49664.dyn.optonline.net. [24.228.150.100])
        by mx.google.com with ESMTPSA id 21sm2708925qks.47.2015.05.07.19.29.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 19:29:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268596>

I work in a large and deep codebase, and found it useful to have these additional features in gitk.  

First, in the commit list, a right click on a branch name will add an option ('Copy branch name') to put that name on the system clipboard.

Second, in the file list of a commit, a right click on a file will add an option ('Copy path') to put the file path on the system clipboard.


Michael Rappazzo (1):
  gitk: Add mouse right-click options

 gitk-git/gitk | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.4.0
