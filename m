From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH v3 0/2] Using gitfile repository with clone --reference
Date: Tue,  9 Apr 2013 18:21:58 -0400
Message-ID: <1365546120-22048-1-git-send-email-aaron@schrab.com>
References: <7v8v4rtzw4.fsf@alter.siamese.dyndns.org>
Cc: junio@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 00:23:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPgwa-0004MO-9k
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 00:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935774Ab3DIWXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 18:23:09 -0400
Received: from pug.qqx.org ([50.116.43.67]:39852 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934972Ab3DIWXH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 18:23:07 -0400
Received: from zim.qqx.org (cpe-107-015-024-243.nc.res.rr.com [107.15.24.243])
	by pug.qqx.org (Postfix) with ESMTPSA id C8F1857E03
	for <git@vger.kernel.org>; Tue,  9 Apr 2013 18:23:04 -0400 (EDT)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 4011c
	by zim.qqx.org (DragonFly Mail Agent);
	Tue, 09 Apr 2013 18:23:02 -0400
X-Mailer: git-send-email 1.8.2.677.g9202ef0
In-Reply-To: <7v8v4rtzw4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220644>

Here's the third version of my series for dealing with gitfiles in clone
--reference.

The first patch is unchanged from the previous version except for the
addition of a Reviewed-by line.

The second patch has been modified so that it now supports having a .git
file supplied as the argument to the option directly rather than only
dealing with that if the containing directory was supplied.  This makes
the first patch from the series more important, since it would make even
less sense to complain that the path isn't a directory when a
non-directory is acceptable.

I've also fixed the minor style issue in the test script from the previous
versions.
