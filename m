From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] Use fast-forward
Date: Sat, 24 Oct 2009 11:31:31 +0300
Message-ID: <1256373092-15126-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 24 10:31:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1c2R-0007Kg-Dk
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 10:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbZJXIbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 04:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbZJXIbi
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 04:31:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:57408 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbZJXIbh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 04:31:37 -0400
Received: by fg-out-1718.google.com with SMTP id d23so521503fga.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=esjTm9u8X2lr2af7d8K2Q/cNc+NogSrRol0mYXsCjjM=;
        b=Dr/JTD/bNtNrPfXfW4wzWiBwIAEwSmysqmDjKgzbtwYCDtvyzK7rfOhkoFrG46VTDT
         3huu64m4viGhzrsD6tWgJ/GVryevuD7Y15GQo9G37e+M/S5qz5Im+wEB4kCThhttEqXy
         tk1CPOQIUSKtNkN9q2ijr+VsKdr5ZprOuRLb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ctGJEHetoToyFMJnj806U5heYTLn37uhk3zXi5RgwYrw3PDeaWp2Vf4PTaJCtYJuNE
         EiBmS10rsknUB6V9cs0Qg6H0LzHWU1lHd8pCSePyFNHYdz38eAFuCMK5dOdKmFff77EF
         +S3eHq9kyc4aSEi9ybcZKQrsPgZmbWI4HPIOE=
Received: by 10.86.159.37 with SMTP id h37mr3503179fge.79.1256373101476;
        Sat, 24 Oct 2009 01:31:41 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id l12sm5554829fgb.22.2009.10.24.01.31.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Oct 2009 01:31:40 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131146>

As suggested in the mailing list, now I've replaced all instances of 'fast
forward' with 'fast-forward'.

Felipe Contreras (1):
  Use 'fast-forward' all over the place

 Documentation/config.txt                     |    2 +-
 Documentation/git-http-push.txt              |    4 ++--
 Documentation/git-push.txt                   |   14 +++++++-------
 Documentation/git-read-tree.txt              |    2 +-
 Documentation/git-receive-pack.txt           |    2 +-
 Documentation/git-reset.txt                  |    4 ++--
 Documentation/git-send-pack.txt              |    4 ++--
 Documentation/gitcore-tutorial.txt           |    4 ++--
 Documentation/githooks.txt                   |    2 +-
 Documentation/glossary-content.txt           |    4 ++--
 Documentation/howto/maintain-git.txt         |    2 +-
 Documentation/howto/revert-branch-rebase.txt |    4 ++--
 Documentation/howto/update-hook-example.txt  |    2 +-
 Documentation/pull-fetch-param.txt           |    4 ++--
 Documentation/user-manual.txt                |   14 +++++++-------
 builtin-fetch--tool.c                        |    8 ++++----
 builtin-fetch.c                              |    4 ++--
 builtin-merge.c                              |    8 ++++----
 builtin-push.c                               |    2 +-
 builtin-receive-pack.c                       |    4 ++--
 builtin-remote.c                             |    2 +-
 builtin-send-pack.c                          |    2 +-
 contrib/examples/git-merge.sh                |    8 ++++----
 contrib/examples/git-resolve.sh              |    2 +-
 contrib/hooks/post-receive-email             |    6 +++---
 git-gui/lib/branch_create.tcl                |    2 +-
 git-merge-octopus.sh                         |    2 +-
 git-pull.sh                                  |    2 +-
 git-rebase--interactive.sh                   |    6 +++---
 git-rebase.sh                                |    2 +-
 t/t1001-read-tree-m-2way.sh                  |    6 +++---
 t/t5505-remote.sh                            |    2 +-
 t/t5518-fetch-exit-status.sh                 |    2 +-
 t/t6028-merge-up-to-date.sh                  |    2 +-
 transport.c                                  |    2 +-
 unpack-trees.c                               |    2 +-
 36 files changed, 72 insertions(+), 72 deletions(-)
