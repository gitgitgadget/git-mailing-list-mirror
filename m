From: David Turner <dturner@twopensource.com>
Subject: (unknown)
Date: Mon, 31 Aug 2015 22:13:08 -0400
Message-ID: <1441073591-639-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 04:13:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWb4r-0005Rm-6A
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 04:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736AbbIACNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 22:13:31 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34000 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722AbbIACNb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 22:13:31 -0400
Received: by qkct7 with SMTP id t7so26869241qkc.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 19:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=BcMp599PJ9m6XtHy0XZa0OTvkntZSiJyDcmuL1LQ7Fw=;
        b=PAnD8tcN/WuTivDxl1ZUyqhWFkqsBleotU5xdfIIpmaOiJ3/6PKS0MWkxR2WCI1zSG
         AURYT2gJnmEGKnbml22GFHxT1cm89KWXhHCesQwhfhe1ndTdQD+EcL4Oxi2hAva31bZI
         iGw3hh3QvbSN7G66q8ILYK7QrdHPDANdLqy4NhRMLyWG0BJVeq/u0kKVKZkrsraQaqkw
         QZQgJY8D7e244y+DTokDFTflHABi846VKjUmFCzHzGgjLfESIBct+bAcSqdoZ55vmZEn
         caInguq6nD37c7p+xGVe2MDfKoFhq4iBTS48bH7QAnyIH4fqKq/qpmLJUreNWmHNjLH9
         ujlQ==
X-Gm-Message-State: ALoCoQmdGH1piEeFOC/uAFoaqVxZckvjD3HAkVKDV7dnV8yoVOMdSCYUhsrB7FGpIw+rtjq4f+R2
X-Received: by 10.55.27.203 with SMTP id m72mr14960083qkh.39.1441073610494;
        Mon, 31 Aug 2015 19:13:30 -0700 (PDT)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id j207sm9926375qhc.17.2015.08.31.19.13.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2015 19:13:29 -0700 (PDT)
Subject: 
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276960>

This version of the patch series squashes in Junio's comment fix and
the xstrndup fix.

In addition, it removes refs/worktree, and just makes refs/bisect
per-worktree.  If we later discover that other things need to be
per-worktree, we can do refs/worktree, but for now, this is
backwards-compatible so we'll do this.
