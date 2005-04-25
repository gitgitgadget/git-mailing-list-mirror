From: Paul Dickson <paul@permanentmail.com>
Subject: Re: [PATCH] Add archive-tree, a cpio archive creator
Date: Mon, 25 Apr 2005 15:30:11 -0700
Message-ID: <20050425153011.34c93b38.paul@permanentmail.com>
References: <20050424014346.GA23083@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 00:26:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQC2D-0001y5-OC
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 00:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVDYWb2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 18:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVDYWbY
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 18:31:24 -0400
Received: from orb.pobox.com ([207.8.226.5]:50852 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261260AbVDYWaX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 18:30:23 -0400
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP
	id 6E93D611; Mon, 25 Apr 2005 18:30:17 -0400 (EDT)
Received: from red.pwd.internal (ip68-230-78-84.ph.ph.cox.net [68.230.78.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C98B87;
	Mon, 25 Apr 2005 18:30:14 -0400 (EDT)
Received: from violet.pwd.internal (violet [192.168.1.4])
	by red.pwd.internal (8.12.8/8.12.8) with SMTP id j3PMUBT3031820;
	Mon, 25 Apr 2005 15:30:16 -0700
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20050424014346.GA23083@lsrfire.ath.cx>
X-Mailer: Sylpheed version 1.9.7 (GTK+ 2.4.14; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 24 Apr 2005 03:43:46 +0200, Rene Scharfe wrote:

> This patch adds archive-tree, a program to create a cpio archive of all
> files referenced by a given tree or commit object.  Why cpio and not
> e.g., tar?  The cpio format I chose (GNU cpio calls it "odc") is dead
> simple compared to any tar variant.  I was simply being lazy. :-P

Use the "newc" format.  The "odc" will generate a lot of errors on a
large filesystem (which I discovered this past weekend).

	-Paul

