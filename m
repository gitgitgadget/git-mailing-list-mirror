From: Kay Sievers <kay.sievers@vrfy.org>
Subject: hmm, can't we give the "root" a parent?
Date: Mon, 12 Sep 2005 20:11:01 +0200
Message-ID: <20050912181101.GA22221@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 12 20:13:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEslo-0002ge-Qr
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 20:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVILSLF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 14:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVILSLF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 14:11:05 -0400
Received: from soundwarez.org ([217.160.171.123]:59351 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932066AbVILSLE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 14:11:04 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 3516062C89; Mon, 12 Sep 2005 20:11:01 +0200 (CEST)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8409>

Can't we teach the git tools that a "root commit" (one without a any
parent) is not visible as a "root", if let's say:
  .git/parents/<root-commit-id> -> <fake-parent-id>

does connect a "fake" parent to the "root"? This way we could add any
older Linux history to the current tree. Combined with "alternates" it
could live in a complete different repository too.

Thanks,
Kay
