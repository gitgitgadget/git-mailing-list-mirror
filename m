X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: git fetch with multiple remotes failing?
Date: Tue, 31 Oct 2006 17:59:13 +0200
Message-ID: <20061031155913.GA5157@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 15:57:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30587>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GevzF-0002Gs-B1 for gcvg-git@gmane.org; Tue, 31 Oct
 2006 16:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423515AbWJaP4b (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 10:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423510AbWJaP4b
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 10:56:31 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:30866 "EHLO
 dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1423515AbWJaP4a (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 10:56:30 -0500
Received: from mellanox.co.il ([194.90.237.34]) by dev.mellanox.co.il
 (8.13.1/8.13.1) with SMTP id k9VFuPgo024759 for <git@vger.kernel.org>; Tue,
 31 Oct 2006 17:56:26 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Tue, 31 Oct 2006
 17:59:13 +0200
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org


$ cat .git/remotes/origin
URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Pull: +refs/heads/master:refs/heads/linus_master
$ cat .git/remotes/jejb-scsi-misc-2.6
URL: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git
Pull: +refs/heads/master:refs/heads/jejb-scsi-misc-2.6
$ git fetch -f origin jejb-scsi-misc-2.6
error: no such remote ref refs/heads/jejb-scsi-misc-2.6
Fetch failure:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Looks I must give remotes one by one?


-- 
