From: Darrin Thompson <darrint@progeny.com>
Subject: Patch (apply) vs. Pull
Date: Mon, 20 Jun 2005 11:19:25 -0500
Message-ID: <1119284365.3926.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jun 20 18:09:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkOpU-0001Xc-K7
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 18:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVFTQO0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 12:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVFTQO0
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 12:14:26 -0400
Received: from zealot.progeny.com ([216.37.46.162]:54729 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S261200AbVFTQOY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2005 12:14:24 -0400
Received: from dhcp-2-246.progeny.com (dhcp-2-246.progeny.com [192.168.2.246])
	by morimoto.progeny.com (Postfix) with ESMTP id A4F1B636AF
	for <git@vger.kernel.org>; Mon, 20 Jun 2005 11:14:23 -0500 (EST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.0.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In trying to understand git I've adopted a mental model where everybody
duplicates locally the remote history in which they are interested.
These histories have various points in common, allowing for intelligent
merging. That makes perfect sense to me, until I look at the list
archives filled with patches.

How exactly are these patches being generated? Is there a right-way(tm)
which causes the recipient's a later pullers' histories to be
intelligently handled in the future?

TIA.

--
Darrin



