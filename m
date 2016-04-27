From: Mike Hommey <mh@glandium.org>
Subject: Announcing git-cinnabar 0.3.2
Date: Thu, 28 Apr 2016 07:51:16 +0900
Message-ID: <20160427225116.GA28101@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 00:51:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avYIs-0001Rw-FO
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 00:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbcD0WvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 18:51:23 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:33460 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147AbcD0WvW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 18:51:22 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1avYIe-0007ZQ-QI
	for git@vger.kernel.org; Thu, 28 Apr 2016 07:51:16 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292837>

Git-cinnabar is a git remote helper to interact with mercurial
repositories. It allows to clone, pull and push from/to mercurial remote
repositories, using git.

Code on https://github.com/glandium/git-cinnabar

[ Previous announcements:
  http://marc.info/?l=git&m=145294370431454
  http://marc.info/?l=git&m=145284823007354
  http://marc.info/?l=git&m=142837367709781 (...)]

What's new since 0.3.1?

- Fixed a performance regression when cloning big repositories on OSX.
- git configuration items with line breaks are now supported.
- Fixed a number of issues with corner cases in mercurial data (such as,
  but not limited to nodes with no first parent, malformed .hgtags,
  etc.)
- Fixed a stack overflow, a buffer overflow and a use-after free in
  cinnabar-helper.
- Better work with git worktrees, or when called from subdirectories.
- Updated git to 2.7.4 for cinnabar-helper.
- Properly remove all refs meant to be removed when using git version
  lower than 2.1.

Mike
