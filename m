From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v3] generalizing sorted-array handling
Date: Mon,  8 Nov 2010 23:38:59 +0100
Message-ID: <1289255942-19705-1-git-send-email-ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 08 23:39:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFaN7-0001fg-Vm
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 23:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891Ab0KHWjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 17:39:15 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:44997 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492Ab0KHWjN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 17:39:13 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 54D21D480C3
	for <git@vger.kernel.org>; Mon,  8 Nov 2010 23:39:08 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PFaMl-00058Z-67
	for git@vger.kernel.org; Mon, 08 Nov 2010 23:39:07 +0100
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161000>

Changes from v2:

* separated sorted-array type declaration from array declaration
* proper typechecking (no reason for using void* for "callback data")
* fixed coding style issues
