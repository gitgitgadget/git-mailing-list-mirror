From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Storing state in $GIT_DIR
Date: Thu, 25 Aug 2005 15:32:57 +1200
Message-ID: <46a038f905082420323b025e3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Aug 25 05:33:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E88U9-00041u-Ke
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 05:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbVHYDc6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 23:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbVHYDc6
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 23:32:58 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:13982 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964783AbVHYDc5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2005 23:32:57 -0400
Received: by rproxy.gmail.com with SMTP id i8so224296rne
        for <git@vger.kernel.org>; Wed, 24 Aug 2005 20:32:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eeo1U8+CrRYCYl0kpgVwegaxkJx1gN+ZjkUConGOvueibvyOrq0Bg1qxOIzVLdapH3giFQFq3f11J3DxopNpu3B3K388ln4ucJIIUyLxgIg9EtmcXTX4yFaoG7Lou2hvpf2pNzzLjztlY8MRAFn0fO3S5GZDFV9j0M/cFYXrYLc=
Received: by 10.38.78.21 with SMTP id a21mr127412rnb;
        Wed, 24 Aug 2005 20:32:57 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Wed, 24 Aug 2005 20:32:57 -0700 (PDT)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7742>

Is there a convention of where/how it is safe to store additional
(non-git) data in $GIT_DIR?

The arch import needs to keep a cache with arch-commit-id  =
git-commit-id mappings, and some notes about what patch-trading Arch
recorded. It'd be great to be able to store those in
$GIT_DIR/archimport/ . Is that supported?

It does not need to be replicated with push or pull, merely preserved. 

cheers,


martin
