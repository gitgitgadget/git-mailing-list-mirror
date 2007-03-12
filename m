From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH 0/5] git-mailinfo fixes/features
Date: Mon, 12 Mar 2007 15:52:03 -0400
Message-ID: <11737291282223-git-send-email-dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 20:53:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQqaQ-0002GW-Sh
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbXCLTxf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbXCLTxf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:53:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55918 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbXCLTxf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:53:35 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2CJrYHv022108
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 15:53:34 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2CJrX2O020366
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 15:53:33 -0400
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2CJrXxX029968
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 15:53:33 -0400
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l2CJq8af019759
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 15:52:08 -0400
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l2CJq8uf019758
	for git@vger.kernel.org; Mon, 12 Mar 2007 15:52:08 -0400
X-Mailer: git-send-email 1.5.0.2.211.g2ca9-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42071>


I am trying to get my own custom git-am to parse non-patches from my Inbox
better.  Using git-mailinfo had a lot of limitations.  I rewrote and
restructured builtin-mailinfo.c to handle what I want to do better.  

In addition to a lot of fixes, I am looking to add a few small backwards
compatible features.  The following patches accomplish that.

This is an update to my previous set of patches.  These new fixes deal with
some of the issues Junio and Linus brought up.

Any feedback would be great.

Cheers,
Don
