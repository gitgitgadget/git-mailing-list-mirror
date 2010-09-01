From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: next no longer compiles on non-gnu platforms
Date: Wed, 01 Sep 2010 11:32:59 -0500
Message-ID: <8DusojDb7VpklNHC3-7Gf5asKbh2H3Cql9FiAGL1ccyieG0lQClVow@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: jjensen@workspacewhiz.com
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 01 18:33:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqqFI-0005vg-RC
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 18:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab0IAQdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 12:33:03 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43333 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618Ab0IAQdB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 12:33:01 -0400
Received: by mail.nrlssc.navy.mil id o81GX0nN008659; Wed, 1 Sep 2010 11:33:00 -0500
X-OriginalArrivalTime: 01 Sep 2010 16:33:00.0788 (UTC) FILETIME=[57BA0340:01CB49F3]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155059>


FYI

Since 83c0e5ad 'Add string comparison functions that respect the
ignore_case variable.' was merged to next, it can't be compiled on
platforms without the GNU FNM_CASEFOLD extension to fnmatch.

If we're going this route, then non-gnu platforms will need to
build with the fnmatch in compat/ and Makefile will need a
NO_FNMATCH define.

-Brandon
