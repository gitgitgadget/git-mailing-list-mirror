From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH] Add .git/version
Date: Thu, 17 Nov 2005 16:25:37 +0300
Message-ID: <11322339372137-git-send-email-matlads@dsmagic.com>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Nov 17 14:30:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecjme-0003uO-9D
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 14:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVKQN0Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 08:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVKQN0Q
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 08:26:16 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:58629 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP
	id S1750798AbVKQN0O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 08:26:14 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id 36B405160
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 16:27:44 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=igloo)
	by igloo.ds.co.ug with smtp (Exim 4.54)
	id 1Ecjlh-0000Lw-CE
	for git@vger.kernel.org; Thu, 17 Nov 2005 16:25:37 +0300
In-Reply-To: 200511160205.43443.Josef.Weidendorfer@gmx.de
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12111>


This patch series attempts to add .git/version support to init-db.c. THis
is an overview of the patches.

First patch makes the Makefile build GIT_VERSION from the variables VERSION,
PATCHLEVEL, and SUBLEVEL ala the kernel. These variables will be used later
in init-db.c

Second patch adds support to init-db.c for writing the .git/version file.

- Martin -
