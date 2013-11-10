From: silvio@port1024.net
Subject: [PATCH v2] git-send-mail: ask smtp password several times
Date: Sun, 10 Nov 2013 12:56:52 +0100
Message-ID: <1384084613-12260-1-git-send-email-silvio@port1024.net>
References: <1383992508-2097-1-git-send-email-silvio@port1024.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 10 12:57:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfTdh-0001wS-L3
	for gcvg-git-2@plane.gmane.org; Sun, 10 Nov 2013 12:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232Ab3KJL5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 06:57:05 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:37039 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3KJL5D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 06:57:03 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3dHYbx5vfzz3hjFs
	for <git@vger.kernel.org>; Sun, 10 Nov 2013 12:57:00 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3dHYbw6lsWzbbh2
	for <git@vger.kernel.org>; Sun, 10 Nov 2013 12:57:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id vvrEI8-vonxq for <git@vger.kernel.org>;
	Sun, 10 Nov 2013 12:56:59 +0100 (CET)
Received: from port1024.net (ppp-188-174-127-23.dynamic.mnet-online.de [188.174.127.23])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPS
	for <git@vger.kernel.org>; Sun, 10 Nov 2013 12:56:59 +0100 (CET)
Received: from [10.1.0.181] (helo=zwielicht.lan)
	by port1024.net with esmtp (Exim 4.82)
	(envelope-from <silvio@port1024.net>)
	id 1VfTdT-00039C-5J
	for git@vger.kernel.org; Sun, 10 Nov 2013 12:56:59 +0100
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1383992508-2097-1-git-send-email-silvio@port1024.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237584>

Hi,

Here the second version of my patch.

With this patch we are able to enter more than one time the password for the
smtp server. Before this patch we had only one trial.

I'm a newbie in perl. Please have attention to newbie failures for perl.

To me it was not possible to implement a test for my changes. Has someone
suggestion to this?

v2:
	* rebase to master-branch (0ecd94d7d728)
	* fix some perl-styles

v1:
	* first version. patch was based on next branch

Cheers,
	Silvio
