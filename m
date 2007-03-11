From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH 0/2] Make gc a builtin.
Date: Sun, 11 Mar 2007 18:06:56 -0400
Message-ID: <11736508181273-git-send-email-jbowes@dangerouslyinc.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 23:07:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQWCD-0007Uj-GF
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 23:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932876AbXCKWHO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 18:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbXCKWHN
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 18:07:13 -0400
Received: from ms-smtp-05.southeast.rr.com ([24.25.9.104]:58656 "EHLO
	ms-smtp-05.southeast.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932879AbXCKWHM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Mar 2007 18:07:12 -0400
Received: from localhost (cpe-066-057-086-146.nc.res.rr.com [66.57.86.146])
	by ms-smtp-05.southeast.rr.com (8.13.6/8.13.6) with ESMTP id l2BM7A3P022494
	for <git@vger.kernel.org>; Sun, 11 Mar 2007 18:07:11 -0400 (EDT)
X-Mailer: git-send-email 1.5.0.2
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41995>

The following two patches make git-gc a builtin command.

The first patch modifies run-command.*, making two public functions that take
va_lists (one of these existed already, of course), so that less code has to be duplicated in builtin-gc.c for error handling. The second patch contains the
builtin-gc.c code itself.

-James
