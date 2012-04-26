From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.9.7
Date: Thu, 26 Apr 2012 12:53:24 -0700
Message-ID: <xmqqpqau6z25.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 22:03:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNUuT-0000Fp-0o
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 22:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226Ab2DZUDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 16:03:18 -0400
Received: from mail-fa0-f74.google.com ([209.85.161.74]:62317 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282Ab2DZUDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 16:03:16 -0400
Received: by faaa25 with SMTP id a25so3286faa.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 13:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-type:x-gm-message-state;
        bh=hBsedXX1w/cVUM1SydgeDKZMPlzQjd4Tm+X3LVqmX40=;
        b=SWugxY8gFK5Rj/41qBgxUiwTKj1C7kMy2oP7LVjnKB7v/R9SBPQsfSTeovNfi+bczM
         sm0/1/AqL7oF8mfXCGcRiP9VLkd41MGe6dLQfMwWlA8G+rePzE7G9YyIzZVmdBmLa3BQ
         wKQhrQLkz4tJPoZj/1zLB4OiIfJqlNbyRMUZmQdgQcL7ZcKnppbWv+SJECwzz+pWsySu
         nDyO5L3af97RnnETkz87NZ9e9xnCBeCZbQPBMIGgnq0UbR05hZpiEVVqxsjV3a1Ij5ZU
         EyHte5tIEERYoqfFuxlRiadPbQaXljNNlAqc1YHFH0vDdjDCqmnPl6V+gVJpPjHWn4W9
         6GAA==
Received: by 10.14.127.10 with SMTP id c10mr2467910eei.2.1335470595219;
        Thu, 26 Apr 2012 13:03:15 -0700 (PDT)
Received: by 10.14.127.10 with SMTP id c10mr2467901eei.2.1335470595118;
        Thu, 26 Apr 2012 13:03:15 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si3780821eef.1.2012.04.26.13.03.15
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 26 Apr 2012 13:03:15 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id E62155C0060;
	Thu, 26 Apr 2012 13:03:14 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 4F2C6E1759; Thu, 26 Apr 2012 13:03:14 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmT1/QwEm4RVGYcmpkv1I32/MyqJV0Eu9vDZi5RK3KfMtB/jia20CVSa5gM1ZKsZxqS5VkMuXIw1fe051zkW47gjSYdi+fe2qQ+nHuPmukqiOFcaNsnZ6nem/VywxFBrXIzMhwf1UkS4BdQ3XNuRDfePRkFiPjOFHuZKSXV2W1jLfgJa5E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196397>

A maintenance release Git 1.7.9.7 is now available at the usual
places.

This backmerges the performance fix to connectivity check performed
after "git fetch" finishes transferring objects from the other end.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

97f6006daccf916078896f8b24aadd882d941cf7  git-1.7.9.7.tar.gz
9a1575a4de8074b4034ae5baaf87b5ae615d635c  git-htmldocs-1.7.9.7.tar.gz
6cae2f1ea878de96b24644c23abc0086ac9283cc  git-manpages-1.7.9.7.tar.gz

Also the following public repositories all have a copy of the v1.7.9.7
tag and the maint-1.7.9 branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git
