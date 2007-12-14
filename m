From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: config.c fixes, take 2
Date: Fri, 14 Dec 2007 15:59:56 -0500
Message-ID: <1197665998-32386-1-git-send-email-krh@redhat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 14 21:25:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3H6Q-00088N-66
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 21:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409AbXLNUZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 15:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755335AbXLNUZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 15:25:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55407 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755256AbXLNUZI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 15:25:08 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBEKIVpF024368;
	Fri, 14 Dec 2007 15:18:31 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBEKIUqi002800;
	Fri, 14 Dec 2007 15:18:30 -0500
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lBEKIUZr000415;
	Fri, 14 Dec 2007 15:18:30 -0500
X-Mailer: git-send-email 1.5.4.rc0.9.g7b331-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68340>

Hi,

Here's a follow-up series that allocates the lock_file on the heap.
Also, git_config_rename_section() did an extra close too so I added
a fix for that in this series.

cheers,
Kristian
