From: Stefan Haller <stefan@haller-berlin.de>
Subject: Re: [BUG] gitk: clicking on a connecting line produces can't read "cflist_top"
Date: Thu,  4 Oct 2012 22:50:15 +0200
Message-ID: <1349383817-14457-1-git-send-email-stefan@haller-berlin.de>
References: <506956E1.1080303@viscovery.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 01:06:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJti2-00033L-Rd
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197Ab2JDUur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 16:50:47 -0400
Received: from server90.greatnet.de ([83.133.96.186]:45011 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856Ab2JDUuq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 16:50:46 -0400
Received: from localhost.localdomain (dslb-088-073-094-229.pools.arcor-ip.net [88.73.94.229])
	by server90.greatnet.de (Postfix) with ESMTPA id 4056C2C4074;
	Thu,  4 Oct 2012 22:50:45 +0200 (CEST)
X-Mailer: git-send-email 1.8.0.rc0.36.gef0f079
In-Reply-To: <506956E1.1080303@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207045>

Sorry, I didn't realize that there is a display mode where the
list of files is empty, not even showing a "Comments" entry.

Here's a patch that fixes it, plus another patch that is only related
in so far as the bug that it fixes was introduced by the same commit.

[PATCH 1/2] gitk: Fix error message when clicking on a connecting line
[PATCH 2/2] gitk: When searching, only highlight files when in Patch mode
