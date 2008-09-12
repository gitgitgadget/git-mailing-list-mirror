From: David Christensen <david@endpoint.com>
Subject: [PATCH v2] Teach git.el to mark/unmark files by regexp
Date: Thu, 11 Sep 2008 23:22:03 -0500
Message-ID: <1221193324-59334-1-git-send-email-david@endpoint.com>
References: <F0D63233-0302-4CF8-9CE1-FC12F2B80F91@endpoint.com>
Cc: julliard@winehq.org, gister@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 06:23:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke0C3-0000PF-UK
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 06:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbYILEWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 00:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbYILEWP
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 00:22:15 -0400
Received: from smtp.sunflower.com ([24.124.0.128]:57588 "EHLO
	smtp.sunflower.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbYILEWP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 00:22:15 -0400
Received: from localhost.localdomain (188.142.45.66.cm.sunflower.com [66.45.142.188])
	by smtp.sunflower.com (8.13.1/8.13.1) with ESMTP id m8C4M5q1023382;
	Thu, 11 Sep 2008 23:22:05 -0500
X-Mailer: git-send-email 1.6.0.1.90.g27a6e.dirty
In-Reply-To: <F0D63233-0302-4CF8-9CE1-FC12F2B80F91@endpoint.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95681>


Teaches git-mark-regexp to respect a prefix argument as an indication
to unmark files.  Also adds other dired-like key bindings.
