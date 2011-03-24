From: Afzal Mohammed <lazfamam@gmail.com>
Subject: Rebase difficulty
Date: Thu, 24 Mar 2011 22:52:31 +0530
Message-ID: <1300987351-3248-1-git-send-email-lazfamam@gmail.com>
Cc: Afzal Mohammed <lazfamam@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 18:22:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2oFH-0001Up-KW
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 18:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933955Ab1CXRWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 13:22:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45247 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933672Ab1CXRWp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 13:22:45 -0400
Received: by iwn34 with SMTP id 34so145220iwn.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 10:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=bfr9PXn1LGJAnHN86CU1pIFkiTvY2RSWjNkKD7VHMqE=;
        b=neS91HXuLmFK9+mgIXd6iLB7eATUTdchdogd3bB6Ee7D0eKkIlg5+Fv+YV4JSMKcX+
         9ZLsQRdtHWOqeGnPBS4ugusDRR7SO8wJJWV6l8kKwxLToThIQ6XipYvo8NtkBXUtJSPI
         DuT49rso9VZTHYHK5n3TJnCJRkwh3kMY+dr7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dEm7B6rCXN/jP2kCIUSTTNIHQiV3CLXBMG5S+RO91wg9GpyHhwNGP3UuVTJM2sFySz
         A/4At09uCt/L6Dkq6RYQjmNfHBhZxA9wl/tJ/+U8/8Apl+w0i/cCW3yTRpdxh6nNmkH3
         7vXJeTwM3Tf0/iJqTAAYHKIT9nOMjaZN5CLOY=
Received: by 10.42.163.138 with SMTP id c10mr6315498icy.269.1300987364160;
        Thu, 24 Mar 2011 10:22:44 -0700 (PDT)
Received: from localhost.localdomain ([122.178.223.121])
        by mx.google.com with ESMTPS id g17sm63588ibb.6.2011.03.24.10.22.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 10:22:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169928>

Hi,

Is there a way, while in the process of rebasing, to skip multiple patches with single command ?

Current scenario,

"[1] git rebase upstream" has been executed initially, around 500 commits would be present after upstream.

out of this 500, some commits has to be skipped (contiguous at different points) and some has to be applied. After [1], git starts applying, it has to be stopped, skip a few, continue applying a few, skip a few and so on.

Please let me know if there is an easy way of doing it or is there any other command meant for this.

Thanks
Afzal
