From: Kay Sievers <kay.sievers@vrfy.org>
Subject: git and symlinks as tracked content
Date: Tue, 03 May 2005 20:33:54 +0200
Message-ID: <1115145234.21105.111.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue May 03 20:32:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT29p-00023a-CW
	for gcvg-git@gmane.org; Tue, 03 May 2005 20:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVECSgC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 14:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVECSfo
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 14:35:44 -0400
Received: from soundwarez.org ([217.160.171.123]:19343 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261559AbVECSd7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 14:33:59 -0400
Received: from dhcp-113.off.vrfy.org (c169067.adsl.hansenet.de [213.39.169.67])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id C2D3A2C97D
	for <git@vger.kernel.org>; Tue,  3 May 2005 20:33:53 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Is there a sane model to make git aware of tracking symlinks in the
repository? In the bk udev tree we've had a test sysfs-tree with a lot
of symlinks in it.

Where can we store the link-target? In its own blob-object or directly
in the tree-object?

How would a exported "patch" with symlinks as content look like?

Thanks,
Kay

